clear; clc;

load('weights_samples.mat');

N =  4; % num data samples
D = 25; % num input units
K =  4; % num output units

x = [x1 x2 x3 x4];
y = 1:4;
W = {W1, W2, W3};

fprintf('  \tL_hinge \tL_cross\n')
for k=1:3

    % s(i,j) = class score i for sample j
    s = W{k}*x; 

    L_hinge = 0;
    L_cross = 0;
    for j=1:N
        L_hinge = L_hinge + hinge_loss(s(:,j), y(j));
        L_cross = L_cross + cross_entropy_loss(s(:,j), y(j));
    end
    L_hinge = L_hinge / N;
    L_cross = L_cross / N;

    fprintf('W%d\t%.6f\t%.6f\n', k, L_hinge, L_cross);
end
