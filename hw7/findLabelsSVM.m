function [test_preds] = findLabelsSVM(train_reprs, train_labels, test_reprs)

    size(train_reprs);  % (n_train, repr_size)
    size(train_labels); % (n_train, 1)
    size(test_reprs);   % (n_test, repr_size)

    % train multi-class SVM classifier
    model = fitcecoc(train_reprs, train_labels);

    % predict test labels with SVM classifier
    test_preds = predict(model, test_reprs);

end