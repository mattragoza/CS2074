debug_mode = 0;

image_dir = 'images/';
image_names = {'spiral.jpg', 'chess.jpg', 'cathedral.jpg'};
num_images = length(image_names);

if debug_mode
    output_dir = 'plots/';
    mkdir(output_dir);
end

for i=1:num_images

    % load image, reduce size, and detect keypoints
    image_file = fullfile(image_dir, image_names{i});
    image = imread(image_file);
    image = imresize(image, 0.5);
    [x, y, scores, Ih, Iv] = extract_keypoints(image, debug_mode);
    
    % diplay image and detected keypoints
    if debug_mode
        figure('Position', [100, 100, 1200, 800]);
        ax1 = subplot(2, 2, 1); imagesc(image); title('Input image and detected keypoints');
        hold on; scatter(x, y, [], 'yellow');
        ax2 = subplot(2, 2, 2); imagesc(scores); title('Harris corner detector response');
        %hold on; scatter(x, y, [], 'white', 'MarkerEdgeAlpha', 0.1);
        ax3 = subplot(2, 2, 3); imagesc(Ih); title('Horizontal image gradient');
        ax4 = subplot(2, 2, 4); imagesc(Iv); title('Vertical image gradient');
        colormap gray; linkaxes([ax1, ax2, ax3, ax4]);
        plot_file = fullfile(output_dir, image_names{i});
    else
        % set marker scale based on keypoint score
        min_size = 10;
        max_size = 1000;
        min_score = min(scores);
        max_score = max(scores);
        normed_scores = (scores - min_score) / (max_score - min_score);
        s = normed_scores * (max_size - min_size) + min_size;

        figure('Position', [100, 100, 1200, 800]);
        imagesc(image); title('Input image and detected keypoints');
        hold on; scatter(x, y, s, 'yellow');
        plot_file = sprintf('vis%d.png', i);
    end
    saveas(gcf, plot_file);
    disp(plot_file);
end
