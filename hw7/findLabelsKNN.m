function [test_preds] = findLabelsKNN(train_reprs, train_labels, test_reprs, k)

    size(train_reprs);  % (n_train, repr_size)
    size(train_labels); % (n_train, 1)
    size(test_reprs);   % (n_test, repr_size)

    % compute pairwise distances b/tw test and train vectors
    distances = pdist2(test_reprs, train_reprs);

    % get indices that sort the distances for each test vector
    [~, nearest_inds] = sort(distances, 2);

    % get labels of k-nearest train features for each test vector
    k_nearest_labels = train_labels(nearest_inds(:,1:k));

    % vote for test labels based on k-nearest train labels
    test_preds = mode(k_nearest_labels, 2);

end