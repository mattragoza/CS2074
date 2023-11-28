% TRAINING FROM SCRATCH (~25 min)

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

% define the model architecture
layers = [ ...
    imageInputLayer(image_shape)
    ...
    convolution2dLayer(11, 50)
    reluLayer
    maxPooling2dLayer(3, Stride=1)
    ...
    convolution2dLayer(5, 60)
    reluLayer
    maxPooling2dLayer(3, Stride=2)
    ...
    fullyConnectedLayer(n_image_classes)
    softmaxLayer
    classificationLayer
];

% specify training hyperparameters
options = trainingOptions('sgdm', ...
    InitialLearnRate = learning_rate, ...
    MaxEpochs = n_train_epochs, ...
    Plots = 'training-progress', ...
    Verbose = true ...
);

% train the network
net = trainNetwork(train_images, layers, options);

% evaluate test set
y_pred = classify(net, test_images);
y_true = test_images.Labels;

accuracy = sum(y_pred == y_true) / numel(y_true);
fprintf('Final test accuracy: %.4f', accuracy);

% Training finished: Max epochs completed.
% Final test accuracy: 0.1675
