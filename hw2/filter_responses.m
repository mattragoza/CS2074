image_dir = 'images/';
image_names = {
    'cardinal1.jpg', ...
    'cardinal2.jpg', ...
    'leopard1.jpg', ...
    'leopard2.jpg', ...
    'panda1.jpg', ...
    'panda2.jpg'
};
num_images = length(image_names);

plot_dir = 'plots/';
mkdir(plot_dir);

%% create filter bank
F = makeLMfilters();
num_filters = size(F, 3);

%% load and preprocess images
images = {};
for i=1:num_images

    % read image file
    im_file = fullfile(image_dir, image_names{i});
    im = imread(im_file);

    % convert to grayscale and resize to 100x100
    im = rgb2gray(im);
    im = imresize(im, [100, 100]);

    images{i} = im;
end

%% apply filters to images
set(0, 'DefaultFigureVisible', 'off');
for j=1:num_filters
    % create plot for each filter
    figure('Position', [10 10 800 400]);
    colormap gray;

    % display filter
    subplot(2, 4, 1);
    filter = F(:,:,j);
    imagesc(filter);
    title(strcat('filter ', num2str(j)));

    % display image responses
    for i=1:num_images
        subplot(2, 4, 2+i);
        response = imfilter(images{i}, filter);
        imagesc(response);
        title(image_names{i});
    end

    % save plot to file
    plot_name = strcat('responses_to_filter_', num2str(j), '.png');
    plot_file = fullfile(plot_dir, plot_name);
    disp(plot_name);
    saveas(gcf, plot_file);
end
set(0, 'DefaultFigureVisible', 'on');