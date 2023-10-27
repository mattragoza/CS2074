function [bow_repr] = computeBOWrepr(features, means)

% features: (num_points, num_features)
% means: (num_clusters, num_features)

num_points = size(features, 1);
num_clusters = size(means, 1);
num_features = size(means, 2);

% compute distances b/tw keypoints and cluster means
dist2 = pdist2(features, means);

% assign clusters to each keypoint based on minimum distance
min_inds = (dist2 == min(dist2, [], 2));

% count the points that were assigned to each cluster
bow_repr = sum(min_inds, 1);

% normalize the bag-of-words representation
bow_repr = bow_repr ./ sum(bow_repr);

end

