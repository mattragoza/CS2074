function [pyramid, level_0, level_1] = computeSPMRepr(im_size, sift, means)

    quad_width  = im_size(1) / 2;
    quad_height = im_size(2) / 2;

    x = sift.f(1,:)';
    y = sift.f(2,:)';
    features = double(sift.d');

    % level_0: (1 x mean_size)
    level_0 = computeBOWRepr(features, means);

    % level_1: (1 x 4*mean_size)
    level_1 = [];
    for i=0:1
        for j=0:1
            upper = i * quad_height;
            left  = j * quad_width;
            lower = upper + quad_height;
            right = left  + quad_width;
            quad = (y > upper) & (x > left) & (y <= lower) & (x <= right);
            quad_bow = computeBOWRepr(features(quad,:), means);
            level_1 = [level_1 quad_bow];
        end
    end

    % pyramid: (1 x 5*mean_size)
    pyramid = [level_0 level_1];
end