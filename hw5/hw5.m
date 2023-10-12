%% dot

im = imread('images/dot.bmp');
edges = [150 150 255 30];
detectCircles(im, edges, 100, 1); saveas(gcf, 'output/dot_100.png');

%% circle

im = imread('images/circle.bmp');
edges = detectEdges(im, 10);
detectCircles(im, edges, 52, 1); saveas(gcf, 'output/circle_52.png');

%% jupiter

im = imread('images/jupiter.jpg');
edges = detectEdges(im, 10);
detectCircles(im, edges, 13, 1); saveas(gcf, 'output/jupiter_13.png');
detectCircles(im, edges, 32, 1); saveas(gcf, 'output/jupiter_32.png');
detectCircles(im, edges, 51, 1); saveas(gcf, 'output/jupiter_51.png');
detectCircles(im, edges, 108, 1); saveas(gcf, 'output/jupiter_108.png');

%% egg

im = imread('images/egg.jpg');
edges = detectEdges(im, 20);
detectCircles(im, edges, 3, 5); saveas(gcf, 'output/egg_3.png');
detectCircles(im, edges, 5, 5); saveas(gcf, 'output/egg_5.png');
detectCircles(im, edges, 8, 5); saveas(gcf, 'output/egg_8.png');

%% k-means segmentation

im = imread('images/fish.jpg');
quantizeRGB(im, 3); saveas(gcf, 'output/k3.png');
quantizeRGB(im, 6); saveas(gcf, 'output/k6.png');
quantizeRGB(im, 12); saveas(gcf, 'output/k12.png');
