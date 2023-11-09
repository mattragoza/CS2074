function loss = cross_entropy_loss(scores, correct_class)
    size(scores);        % 4 x 1
    size(correct_class); % 1 x 1

    exp_scores = exp(scores);
    class_probs = exp_scores / sum(exp_scores);
    loss = -log(class_probs(correct_class));
end