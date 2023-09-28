function [features] = compute_features(x, y, scores, Ix, Iy)

num_features = 8;   % num histogram bins
kernel_hsize = 5;   % kernel half size
eps = 1e-12;

% points are invalid if too close to the image border
[height, width] = size(Ix);
x_valid = (x - kernel_hsize > 0) & (x + kernel_hsize <= width);
y_valid = (y - kernel_hsize > 0) & (y + kernel_hsize <= height);
valid_points = (x_valid & y_valid);

% erase invalid points
x = x(valid_points);
y = y(valid_points);
scores = scores(valid_points);
num_points = size(scores, 1);

% compute gradient magnitude and orientation
M = sqrt(Ix.^2 + Iy.^2);
theta = atand(Iy ./ (Ix + eps));

% quantize gradient orientation
bin_size = 180 / num_features;
bin_edges = -90:bin_size:90;
[counts, bin_edges, theta_bins] = histcounts(theta, bin_edges);

% compute histograms of oriented gradients
features = zeros(num_points, num_features);
for i=1:num_points
    x_patch = (y(i) - kernel_hsize):(y(i) + kernel_hsize);
    y_patch = (x(i) - kernel_hsize):(x(i) + kernel_hsize);
    M_patch = M(x_patch, y_patch);
    theta_patch = theta_bins(x_patch, y_patch);
    for j=1:num_features
        features(i,j) = sum(M_patch(theta_patch == j));
    end
end

% normalize each feature vector
features = features ./ sum(features, 2);

% clip HOG features to 0.2
features(features > 0.2) = 0.2;

% normalize each feature vector again
features = features ./ sum(features, 2);

end

