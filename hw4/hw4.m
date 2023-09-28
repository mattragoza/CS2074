clc; clear; debug = 1;

image = imread('images/ella.jpg');
load('clusters/means_k2.mat', 'means');

%% Part 1
[x, y, scores, Ix, Iy] = extract_keypoints(image, debug);
display_keypoints(image, x, y, scores, Ix, Iy);
features = compute_features(x, y, scores, Ix, Iy);

%% Part 2
bow_repr = computeBOWrepr(features, means);
