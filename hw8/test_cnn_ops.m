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
		
% first test

output1a = my_conv(image, filter, 0, 2);
output1b = max(0, output1a); 				% RELU
output1 = my_pool(output1b, 2);

plot_cnn_ops(image, output1a, output1b, output1);

% second test

output2a = my_conv(image, filter, 1, 4);
output2b = max(0, output2a);				% RELU
output2 = my_pool(output2b, 3);

% save outputs

save('outputs.mat', 'output1', 'output2');
