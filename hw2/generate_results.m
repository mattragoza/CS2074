function generate_results(filename, reduceAmt, reduceWhat)

% parse image filename
[image_dir, image_name, image_ext] = fileparts(filename);

% load image and print original size
im = imread(filename);
original_size = size(im, 1:2);
fprintf('Original size: %s\n', mat2str(original_size));

% start reducing image size
im_reduced = im;
reduced_size = original_size;

if strcmp(reduceWhat, 'WIDTH')
    assert(original_size(2) > reduceAmt);
    for i=1:reduceAmt
        im_reduced = reduceWidth(im_reduced, (i == 1));
        reduced_size = size(im_reduced, 1:2);
        fprintf('Reduced size: %s\n', mat2str(reduced_size));
    end
else
    assert(strcmp(reduceWhat, 'HEIGHT'))
    assert(original_size(1) > reduceAmt);
    for i=1:reduceAmt
        im_reduced = reduceHeight(im_reduced, (i == 1));
        reduced_size = size(im_reduced, 1:2);
        fprintf('Reduced size: %s\n', mat2str(reduced_size));
    end
end
% save energy plot
plot_file = sprintf('%s_energy.png', image_name);
saveas(gcf, plot_file);

% compare result to imresize
im_resized = imresize(im, reduced_size);

figure('Position', [10 10 3*original_size(2) original_size(1)]);
subplot(1, 3, 1);
imagesc(im);
title(sprintf('original size: %s', mat2str(original_size)));
axis image;
subplot(1, 3, 2);
imagesc(im_reduced);
title(sprintf('content-aware resize: %s', mat2str(reduced_size)));
axis image;
subplot(1, 3, 3);
imagesc(im_resized);
title(sprintf('standard resize: %s', mat2str(reduced_size)));
axis image;

plot_file = sprintf('%s_%s_reduced.png', image_name, reduceWhat);
saveas(gcf, plot_file);
