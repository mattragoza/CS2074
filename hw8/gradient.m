clear; clc;

load('weights_samples.mat');

N =  4; % num data samples
D = 25; % num input units
K =  4; % num output units

x = [x1 x2 x3 x4];
y = 1:4;

W = W1; % K x D

% numerical differentiation
%   dL/dW = [L(W + h) - L(W)] / h
h = 1e-6;

% optimizer hyperparameters
learning_rate = 1e-2;
max_iteration = 1000;
min_delta = 1e-5;

L_prev = inf;
for it=0:max_iteration + 1

    % forward pass
    s = W*x;
    
    % compute average loss
    L_W = 0;
    for i=1:N
        L_W = L_W + hinge_loss(s(:,i), y(i));
    end
    L_W = L_W / N;

    % relative change in loss value
    delta = (L_W - L_prev) / (abs(L_prev) + eps);

    fprintf('[%d] L = %.4f (%.6f)\n', it, L_W, delta);

    % convergence check
    if (it == max_iteration) || (abs(delta) < min_delta)
        break
    end

    % compute numerical gradient
    grad_L = zeros(size(W)); % K x D
    for d=1:D
        for k=1:K
            % copy and perturb weights
            Wh = W(:,:);
            Wh(k,d) = W(k,d) + h;
    
            % forward pass
            s = Wh*x;
    
            % compute average loss
            L_Wh = 0;
            for n=1:N
                L_Wh = L_Wh + hinge_loss(s(:,n), y(n));
            end
            L_Wh = L_Wh / N;
    
            % compute partial derivative
            grad_L(k,d) = (L_Wh - L_W) / h;
        end
    end

    % update weights
    W(:,:) = W - learning_rate * grad_L;

    L_prev = L_W;
end
