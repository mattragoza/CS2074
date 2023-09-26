function [x, y, scores, Ih, Iv] = extract_keypoints(image, hsize, filter, threshold)

% default arguments
if nargin < 4
    threshold = 5e10; % score threshold
end
if nargin < 3
    filter = 1; % apply Gaussian filter
end
if nargin < 2
   hsize = 2; % half window size
end

% corner detection parameter(s)
k = 0.05;
fsize = 2 * hsize + 1; % full window size

% convert image to grayscale double
image_gray = double(rgb2gray(image));
[height, width] = size(image_gray);

% Sobel derivative filters
Dh = [-1 0 1; -2 0 2; -1 0 1];
Dv = [-1 -2 -1; 0 0 0; 1 2 1];

% compute image gradient
Ih = imfilter(image_gray, Dh, 'symmetric');
Iv = imfilter(image_gray, Dv, 'symmetric');

% compute corner detection scores
R = zeros(height, width);
for i=(hsize + 1):(height - hsize - 1)
    for j=(hsize + 1):(width - hsize - 1)

        % compute structure tensor
        M = zeros(2, 2);
        for u=-hsize:hsize
            for v=-hsize:hsize
                M(1,1) = M(1,1) + Ih(i+u,j+v)^2;
                M(1,2) = M(1,2) + Ih(i+u,j+v)*Iv(i+u,j+v);
                M(2,1) = M(2,1) + Ih(i+u,j+v)*Iv(i+u,j+v);
                M(2,2) = M(2,2) + Iv(i+u,j+v)^2;
            end
        end
        % approximate smallest eigenvalue
        R(i,j) = det(M) - k * trace(M)^2;
    end
end

% NOTE: I found better corner detection accuracy by applying a 5x5 Gaussian
% filter to the scores before applying the threshold and non-max suppression
if filter
    f = [1; 4; 6; 4; 1] / 16;
    R = imfilter(R, f * f');
end
scores = R;

% apply score threshold
R_threshold = (R > threshold);

% perform non-max suppression
hsize = 1; 
R_suppress = zeros(height, width);
for i=(hsize + 1):(height - hsize - 1)
    for j=(hsize + 1):(width - hsize - 1)
        if R_threshold(i,j)
            window = R(i-hsize:i+hsize, j-hsize:j+hsize);
            window_max = max(window, [], 'all');
            if R(i,j) < window_max
                R_suppress(i,j) = 0;
            else
                R_suppress(i,j) = 1;
            end
        end
    end
end

% convert to pixel indices
[y, x] = find(R_suppress);

% return scores at keypoints intead of entire score map
%scores = R(sub2ind([height, width], y, x));

end
