function y = sigmoid(x)
    exp_x = exp(x);
    y = exp_x / (1 + exp_x);
end