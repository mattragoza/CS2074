function [energyImage, Ix, Iy] = energy_image(im)

% convert image to grayscale double
im = double(rgb2gray(im));

% Sobel derivative filters
Dx = [1 0 -1;2 0 -2;1 0 -1];
Dy = [1 2 1;0 0 0;-1 -2 -1];

% apply filters to image
Ix = imfilter(im, Dx);
Iy = imfilter(im, Dy);

% compute energy as gradient magnitude
energyImage = sqrt(Ix.^2 + Iy.^2);
