
image_dir = 'images/';
image_names = {'spiral.jpg', 'chess.jpg', 'cathedral.jpg'};
num_images = length(image_names);

output_dir = 'plots/';
mkdir(output_dir);

for i=1:num_images

    % load image, reduce size, and detect keypoints
    image_file = fullfile(image_dir, image_names{i});
    image = imread(image_file);
    image = imresize(image, 0.5);
    [x, y, scores, Ih, Iv] = extract_keypoints(image);
    
    % diplay image, gradient, and keypoints
    
    figure('Position', [100, 100, 1200, 800]);
    ax1 = subplot(2, 2, 1); imagesc(image); title('Input image and detected keypoints');
    hold on; scatter(x, y, [], 'yellow');
    ax2 = subplot(2, 2, 2); imagesc(scores); title('Harris corner detector response');
    %hold on; scatter(x, y, [], 'white', 'MarkerEdgeAlpha', 0.1);
    ax3 = subplot(2, 2, 3); imagesc(Ih); title('Horizontal image gradient');
    ax4 = subplot(2, 2, 4); imagesc(Iv); title('Vertical image gradient');
    colormap gray; linkaxes([ax1, ax2, ax3, ax4]);

    plot_file = fullfile(output_dir, image_names{i});
    saveas(gcf, plot_file);
    disp(plot_file);
end
