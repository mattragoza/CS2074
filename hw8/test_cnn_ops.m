% test_cnn_ops
clear; clc;

% image and filter

image = [	0 0 0 0 0 0 0 0 0; ...
			0 0 0 0 0 0 0 0 0; ...
			1 1 1 1 1 0 0 0 0; ...
			1 1 1 1 1 1 0 0 0; ...
			1 1 1 1 1 1 1 0 0; ...
			1 1 1 1 1 1 1 1 0; ...
			1 1 1 1 1 1 1 1 1; ...
			1 1 1 1 1 1 1 1 1; ...
			1 1 1 1 1 1 1 1 1 	]; 
			
filter = [ 	0 -1 -1; 
			1  0 -1; 
			1  1  0];

% my test cases
%filter = [-1 -2 -1; 0 0 0; 1 2 1] / 2;
%my_conv(image, filter, 0, 3); % 3 x 3;
%my_conv(image, filter, 0, 1); % 7 x 7;
%my_conv(image, filter, 1, 1); % 9 x 9;

%conv = my_conv(image, filter, 1, 1); % 9 x 9
%relu = max(0, conv); % RELU
%pool = my_pool(relu, 3); % 3 x 3
%plot_cnn_ops(image, conv, relu, pool);

% first test
output1a = my_conv(image, filter, 0, 2); % 4 x 4
output1b = max(0, output1a); % RELU
output1 = my_pool(output1b, 2); % 2 x 2
plot_cnn_ops(image, output1a, output1b, output1);

% second test

output2a = my_conv(image, filter, 1, 4); % 3 x 3
output2b = max(0, output2a); % RELU
output2 = my_pool(output2b, 3); % 1 x 1
plot_cnn_ops(image, output2a, output2b, output2);

% save outputs

save('outputs.mat', 'output1', 'output2');
