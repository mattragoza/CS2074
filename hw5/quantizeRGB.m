function [outputImage, meanColors, clusterIds] = quantizeRGB(image, k)

[height, width, ~] = size(image);

n_pixels = height * width;
X = reshape(image, [n_pixels, 3]);
X = double(X);

[clusterIds, meanColors] = kmeans(X, k);

size(clusterIds)
size(meanColors)

Y = meanColors(clusterIds,:);
outputImage = reshape(Y, [height, width, 3]);
outputImage = uint8(outputImage);

figure('Position', [10 10 width * 2 height]);
subplot(1,2,1);
imshow(image);
title('Original image');

subplot(1,2,2);
imshow(outputImage);
title(sprintf('Segmentation (k = %d)', k))

end