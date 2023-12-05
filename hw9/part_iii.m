% TRANSFER LEARNING + DATA AUGMENTATION (~10-20 sec)

data_root = 'scenes_lazebnik';
image_shape = [227 227 3];
n_image_classes = 8;
n_train_images_per_class = 10;
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

% apply data augmentation

image_augmenter0 = imageDataAugmenter( ...
    RandXReflection = false, ...
    RandRotation = [0 0], ...
    RandScale = [1 1], ...
    RandXTranslation = [0 0], ...
    RandYTranslation = [0 0] ...
);

image_augmenter1 = imageDataAugmenter( ...
    RandXReflection = true, ...
    RandRotation = [0 0], ...
    RandScale = [1 1], ...
    RandXTranslation = [0 0], ...
    RandYTranslation = [0 0] ...
);

image_augmenter2 = imageDataAugmenter( ...
    RandXReflection = true, ...
    RandRotation = [0 0], ...
    RandScale = [0.5 2], ...
    RandXTranslation = [-2 2], ...
    RandYTranslation = [-2 2] ...
);

augmented_train_images = augmentedImageDatastore( ...
    image_shape, ...
    train_images, ...
    DataAugmentation = image_augmenter2 ...
 );

all_accuracy = [];
for run=1:5
    fprintf('Training run %d / 5\n', run);

    % load the pretrained model
    net = alexnet;
    
    % replace final layers
    pretrained_layers = net.Layers(1:end-9);
    
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
    net = trainNetwork(augmented_train_images, layers, options);
    
    % evaluate test set
    y_pred = classify(net, test_images);
    y_true = test_images.Labels;
    
    accuracy = sum(y_pred == y_true) / numel(y_true);
    fprintf('Final test accuracy: %.4f\n', accuracy);

    all_accuracy = [all_accuracy accuracy];
end

fprintf('mean = %.4f\n std = %.4f\n', mean(all_accuracy), std(all_accuracy));