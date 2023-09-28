clc; clear; debug = 1;

image = imread('images/ella.jpg');
[height, width] = size(image, 1:2);

[x, y, scores, Ix, Iy] = extract_keypoints(image, debug);
display_keypoints(image, x, y, scores, Ix, Iy);
features = compute_features(x, y, scores, Ix, Iy);
