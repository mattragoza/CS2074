function [reducedColorImage] = reduceWidth(im, display_flag)

energyImage = energy_image(im);
M = cumulative_minimum_energy_map(energyImage, 'VERTICAL');
vseam = find_optimal_vertical_seam(M);

num_rows = size(im, 1);
num_cols = size(im, 2);
num_channels = size(im, 3);

reducedColorImage = zeros([num_rows num_cols-1 num_channels], 'uint8');
for i=1:num_rows
    for j=1:num_channels
        curr_row = im(i,:,j);
        curr_row(vseam(i)) = [];
        reducedColorImage(i,:,j) = curr_row;
    end
end

if(display_flag)
    figure('Position', [10 10 3*size(im, 2) size(im, 1)]);
    subplot(1, 3, 1); imagesc(energyImage);
    title('energy');
    axis image;
    subplot(1, 3, 2); imagesc(M);
    title('cumulative minimum energy');
    axis image;
    subplot(1, 3, 3); imagesc(im); displaySeam(im, vseam, 'VERTICAL');
    title('optimal vertical seam');
    axis image;
    colormap gray;
end
