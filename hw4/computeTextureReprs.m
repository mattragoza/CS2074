% DO NOT SHARE AS FUTURE STUDENTS MIGHT BE ASKED TO IMPLEMENT THIS

function [texture_repr_concat, texture_repr_mean] = computeTextureReprs(image, F)

    responses = zeros(size(F, 3), size(image, 1), size(image, 2));    
    image = rgb2gray(image);

    for i = 1:size(F, 3)
        this_filter = F(:, :, i);        
        filt_im = imfilter(image, this_filter);
        responses(i, :, :) = filt_im;
    end
    
    texture_repr_concat = responses(:)';
    texture_repr_mean = mean(mean(responses, 3), 2)';

end