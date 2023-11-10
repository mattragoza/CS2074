function plot_cnn_ops(input, conv, relu, pool)

[H, W] = size(input);
scale = 50;

figure('Position', [100 100 4.4*scale*W scale*H]);
colormap('gray');

subplot(1, 4, 1);
imagesc(input);
title('input');

subplot(1, 4, 2);
imagesc(conv);
title('conv');

subplot(1, 4, 3);
imagesc(relu);
title('relu');

subplot(1, 4, 4);
imagesc(pool);
title('pool');

end