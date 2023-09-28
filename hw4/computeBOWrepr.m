function [bow_repr] = computeBOWrepr(features, means)

num_clusters = size(means, 1);

bow_repr = zeros(num_clusters);

% normalize the BOW representation
bow_repr = bow_repr ./ sum(bow_repr);

end

