clear; clc;
load train.mat;
load test.mat;
load means.mat;

n_train = size(train_images, 1);
n_test  = size(test_images, 1);
repr_size = size(means, 1) * 5;

disp('Computing train SPM representations');

train_reprs = zeros(n_train, repr_size);
for i=1:n_train
    im_size = train_images(i,:);
    sift = train_sift{i};
    [pyramid, L0, L1] = computeSPMRepr(im_size, sift, means);
    train_reprs(i,:) = pyramid;
end

disp('Computing test SPM representations');

test_reprs  = zeros(n_test, repr_size);
for i=1:n_test
    im_size = test_images(i,:);
    sift = test_sift{i};
    [pyramid, L0, L1] = computeSPMRepr(im_size, sift, means);
    test_reprs(i,:) = pyramid;
end

disp('Performing KNN and SVM classification');

findLabelsKNN(train_reprs, train_labels, test_reprs, 5);
findLabelsSVM(train_reprs, train_labels, test_reprs);

disp('Done');
