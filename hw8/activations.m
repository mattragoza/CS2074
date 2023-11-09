clear; clc;

% 1) encode the input and weights

D = 4; % num input units
M = 3; % num hidden units
K = 2; % num output units

% input vector
x = [0; 10; 2; 30];

% layer 1 weights
W1 = [
    0.50 0.60 0.40 0.30;
    0.02 0.25 0.40 0.30;
    0.72 0.10 0.35 0.30
 ];

% layer 2 weights
W2 = [
    0.70 0.45 0.50;
    0.17 0.90 0.80
];

% 2) compute z_2 using tanh activation

z = tanh(W1 * x);

fprintf('z_2 = %.16f\n', z(2));

% 3) compute y_1 using relu + sigmoid activation

z = my_relu(W1 * x);
y = my_sigmoid(W2 * z);

fprintf('y_1 = %.16f\n', y(1));

