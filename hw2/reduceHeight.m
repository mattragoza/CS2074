% Code written for CS1674 by Adriana Kovashka 
% DO NOT SHARE as students in the next issue might need to implement this

function [reducedColorImage] = reduceHeight(im, display_flag)

    energyImage = energy_image(im);
    M = cumulative_minimum_energy_map(energyImage, 'HORIZONTAL');
    hs = find_optimal_horizontal_seam(M);
    
    num_rows = size(im, 1);
    num_cols = size(im, 2);
    num_channels = size(im, 3);
    
    assert(length(hs) == num_cols);
        
    reducedColorImage = zeros([num_rows-1 num_cols num_channels]);

    for i = 1:num_cols
        for j = 1:num_channels
            this_col = im(:, i, j);
            this_col(hs(i)) = [];
            reducedColorImage(:, i, j) = this_col;
        end      
    end
    
    reducedColorImage = uint8(reducedColorImage);
    
    if(display_flag)
        figure('Position', [10 10 3*size(im, 2) size(im, 1)]);
        subplot(1, 3, 1); imagesc(energyImage);
        title('energy');
        axis image;
        subplot(1, 3, 2); imagesc(M);
        title('cumulative minimum energy');
        axis image;
        subplot(1, 3, 3); imagesc(im); displaySeam(im, hs, 'HORIZONTAL');
        title('optimal horizontal seam'); 
        axis image;
        colormap gray;
    end
    
    
    