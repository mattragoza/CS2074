image_dir = 'images/';
im_name1 = 'woman_neutral.png';
im_name2 = 'woman_happy.png';

% load and preprocess images
im1 = imread(fullfile(image_dir, im_name1));
im1 = rgb2gray(im1);
im1 = imresize(im1, [512, 512]);

im2 = imread(fullfile(image_dir, im_name2));
im2 = rgb2gray(im2);
im2 = imresize(im2, [512, 512]);

% obtain blurred images
im1_blur = imgaussfilt(im1, 10, 'FilterSize', 31);
im2_blur = imgaussfilt(im2, 10, 'FilterSize', 31);

% obtain detail image
im2_detail = im2 - im2_blur;

% create hybrid image
hybrid = im1_blur + im2_detail;
imwrite(hybrid, 'hybrid.png');
