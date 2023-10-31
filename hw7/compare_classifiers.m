clear; clc;
load train.mat;
load test.mat;
load means.mat;

n_train = size(train_images, 1);
n_test = size(test_images, 1);
mean_size = size(means, 1);

disp('Computing train SPM representations');

train_reprs = zeros(n_train, mean_size * 5);

for i=1:n_train
    im_size = train_images(i,:);
    sift = train_sift{i};
    [pyramid, L0, L1] = computeSPMRepr(im_size, sift, means);
    train_reprs(i,:) = pyramid;
end

disp('Computing test SPM representations');

test_reprs = zeros(n_test, mean_size * 5);

for i=1:n_test
    im_size = test_images(i,:);
    sift = test_sift{i};
    [pyramid, L0, L1] = computeSPMRepr(im_size, sift, means);
    test_reprs(i,:) = pyramid;
end

disp('Performing SVM classification');
test_preds_svm = findLabelsSVM(train_reprs, train_labels, test_reprs);
train_preds_svm = findLabelsSVM(train_reprs, train_labels, train_reprs);

test_acc_svm = compute_accuracy(test_preds_svm, test_labels);
train_acc_svm = compute_accuracy(train_preds_svm, train_labels);

k_values = 1:2:21;
test_accs_knn = zeros(1, length(k_values));
train_accs_knn = zeros(1, length(k_values));

for i=1:length(k_values)

    k = k_values(i);
    fprintf('Performing KNN classification (k = %d)\n', k);
 
    test_preds_knn = findLabelsKNN(train_reprs, train_labels, test_reprs, k);
    train_preds_knn = findLabelsKNN(train_reprs, train_labels, train_reprs, k);
    
    test_accs_knn(i) = compute_accuracy(test_preds_knn, test_labels);
    train_accs_knn(i) = compute_accuracy(train_preds_knn, train_labels);
end

figure;

subplot(1, 2, 1);
plot(k_values, train_accs_knn, 'b'); hold on;
yline(train_acc_svm, 'r');
ylim([0, 1]);
xlabel('k');
ylabel('accuracy');
title('Train accuracy');
legend('KNN', 'SVM')

subplot(1, 2, 2);
plot(k_values, test_accs_knn, 'b'); hold on;
yline(test_acc_svm, 'r');
ylim([0, 1]);
xlabel('k');
ylabel('accuracy');
title('Test accuracy');
legend('KNN', 'SVM')

saveas(gcf, 'results.png');
disp('Done');
