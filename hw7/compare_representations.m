clear; clc;
load train.mat;
load test.mat;
load means.mat;

n_train = size(train_images, 1);
n_test = size(test_images, 1);
mean_size = size(means, 1);

disp('Computing train SPM representations');

train_reprs_py = zeros(n_train, mean_size * 5);
train_reprs_L0 = zeros(n_train, mean_size * 1);
train_reprs_L1 = zeros(n_train, mean_size * 4);

for i=1:n_train
    im_size = train_images(i,:);
    sift = train_sift{i};
    [pyramid, L0, L1] = computeSPMRepr(im_size, sift, means);
    train_reprs_py(i,:) = pyramid;
    train_reprs_L0(i,:) = L0;
    train_reprs_L1(i,:) = L1;
end

disp('Computing test SPM representations');

test_reprs_py = zeros(n_test, mean_size * 5);
test_reprs_L0 = zeros(n_test, mean_size * 1);
test_reprs_L1 = zeros(n_test, mean_size * 4);

for i=1:n_test
    im_size = test_images(i,:);
    sift = test_sift{i};
    [pyramid, L0, L1] = computeSPMRepr(im_size, sift, means);
    test_reprs_py(i,:) = pyramid;
    test_reprs_L0(i,:) = L0;
    test_reprs_L1(i,:) = L1;
end

disp('Performing SVM classification using full SPM pyramid');
test_preds_py = findLabelsSVM(train_reprs_py, train_labels, test_reprs_py);

disp('Performing SVM classification using only SPM level 0');
test_preds_L0 = findLabelsSVM(train_reprs_L0, train_labels, test_reprs_L0);

disp('Performing SVM classification using only SPM level 1');
test_preds_L1 = findLabelsSVM(train_reprs_L1, train_labels, test_reprs_L1);

test_acc_py = compute_accuracy(test_preds_py, test_labels);
test_acc_L0 = compute_accuracy(test_preds_L0, test_labels);
test_acc_L1 = compute_accuracy(test_preds_L1, test_labels);

fprintf('Method\tAccuracy\n');
fprintf('pyramid\t%.4f\n', test_acc_py);
fprintf('level_0\t%.4f\n', test_acc_L0);
fprintf('level_1\t%.4f\n', test_acc_L1);

disp('Done');
