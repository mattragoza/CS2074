% compare_representations

% USE/NOTES:
% MAKE SURE TO ADD YOUR HW2 and HW3 FOLDERS TO THE PATH;
% DO NOT SHARE AS FUTURE STUDENTS MIGHT BE ASKED TO IMPLEMENT THIS

% get list of images for the comparison
im_list = {'cardinal1.jpg', 'cardinal2.jpg', 'leopard1.jpg', 'leopard2.jpg', 'panda1.jpg', 'panda2.jpg'}; 

% load filters
F = makeLMfilters;

% NOTE: not the best way of doing this-- some repeated computation

for k = [2 5 10 50]
    
    % load cluster centers
    load(strcat('means_k', num2str(k)));  
    
    % initialize storage for each of the three types of representations
    reprs_bow = [];
    reprs_texture_concat = [];
    reprs_texture_mean = [];
    
    % compute representations

    for i = 1:length(im_list)
        im = imread(im_list{i});  
        im = imresize(im, [300 300]);

        [x, y, scores, Ix, Iy] = extract_keypoints(im); % from HW3
        [features] = compute_features(x, y, scores, Ix, Iy); % you implement 
        repr1 = computeBOWRepr(features, means); % you implement   
        [repr2, repr3] = computeTextureReprs(im, F); % provided

        reprs_bow = [reprs_bow; repr1];
        reprs_texture_concat = [reprs_texture_concat; repr2];
        reprs_texture_mean = [reprs_texture_mean; repr3];

    end

    % ratios for BOW with different k (number of cluster centers)

    within_dists = []; % for all images of the same animal category
    between_dists = []; % for all images NOT of the same animal category
    all_dists = zeros(length(im_list));

    for i = 1:length(im_list)
        for j = (i+1):length(im_list)
            temp = norm(reprs_bow(i, :) - reprs_bow(j, :));
            if( (mod(i, 2) == 1) && (j == i+1) )
                within_dists = [within_dists temp];
            else
                between_dists = [between_dists temp];
            end
            all_dists(i, j) = temp;
        end
    end

    r = mean(within_dists) / mean(between_dists);
    fprintf('Ratio for BOW k=%u: %f\n', k, r);
       
end

% ratio for texture concat

within_dists = [];
between_dists = [];
all_dists = zeros(length(im_list));

for i = 1:length(im_list)
    for j = (i+1):length(im_list)
        temp = norm(reprs_texture_concat(i, :) - reprs_texture_concat(j, :));
        if( (mod(i, 2) == 1) && (j == i+1) )
            within_dists = [within_dists temp];
        else
            between_dists = [between_dists temp];
        end
        all_dists(i, j) = temp;
    end
end

r = mean(within_dists) / mean(between_dists);
fprintf('Ratio for texture concat: %f\n', r);

% ratio for texture mean

within_dists = [];
between_dists = [];
all_dists = zeros(length(im_list));

for i = 1:length(im_list)
    for j = (i+1):length(im_list)
        temp = norm(reprs_texture_mean(i, :) - reprs_texture_mean(j, :));
        if( (mod(i, 2) == 1) && (j == i+1) )
            within_dists = [within_dists temp];
        else
            between_dists = [between_dists temp];
        end
        all_dists(i, j) = temp;
    end
end

r = mean(within_dists) / mean(between_dists);
fprintf('Ratio for texture mean: %f\n', r);
