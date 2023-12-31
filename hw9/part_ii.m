% TRANSFER LEARNING (~10-20 sec)

data_root = 'scenes_lazebnik';
image_shape = [227 227 3];
n_image_classes = 8;
n_train_images_per_class = 100;
n_train_epochs = 5;
learning_rate = 1e-4;

% load image data set
images = imageDatastore(data_root, ...
    IncludeSubfolders = true, ...
    LabelSource = 'foldernames' ...
);

% split into train and test sets
[train_images, test_images] = splitEachLabel( ...
    images, n_train_images_per_class, 'randomize' ...
);

all_accuracy = [];
for run=1:5
    fprintf('Training run %d / 5\n', run);

    % load the pretrained model
    net = alexnet;
    
    % replace final layers
    pretrained_layers = net.Layers(1:end-5); % -9 or -5
    
    layers = [
        pretrained_layers
        fullyConnectedLayer(n_image_classes)
        softmaxLayer
        classificationLayer
    ];
    
    % specify training hyperparameters
    options = trainingOptions('sgdm', ...
        InitialLearnRate = learning_rate, ...
        MaxEpochs = n_train_epochs, ...
        ... %Plots = 'training-progress', ...
        Verbose = true ...
    );
    
    % train the network
    net = trainNetwork(train_images, layers, options);
    
    % evaluate test set
    y_pred = classify(net, test_images);
    y_true = test_images.Labels;
    
    accuracy = sum(y_pred == y_true) / numel(y_true);
    fprintf('Final test accuracy: %.4f\n', accuracy);

    all_accuracy = [all_accuracy accuracy];
end

fprintf('mean = %.4f\n std = %.4f\n', mean(all_accuracy), std(all_accuracy));
