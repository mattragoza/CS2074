function display_keypoints(image, x, y, scores, Ix, Iy)

[height, width] = size(image, 1:2);
num_rows = 1;
num_cols = 4;

figure('Position', [100, 100, num_cols * width * 1.2, num_rows * height]);

ax1 = subplot(num_rows, num_cols, 1);
imagesc(image); hold on;
scatter(x, y, [], 'yellow');
title('Input image and detected keypoints');

ax2 = subplot(num_rows, num_cols, 2);
imagesc(scores);
title('Harris corner detector response');

ax3 = subplot(num_rows, num_cols, 3);
imagesc(Ix);
title('Horizontal image gradient');

ax4 = subplot(num_rows, num_cols, 4);
imagesc(Iy);
title('Vertical image gradient');

colormap gray;
linkaxes([ax1, ax2, ax3, ax4]);
