function loss = hinge_loss(scores, correct_class)
    size(scores);        % K x 1
    size(correct_class); % 1 x 1
  
    margin = (scores - scores(correct_class) + 1);
    max_margin = max(0, margin);
    max_margin(correct_class) = 0;
    loss = sum(max_margin);
end