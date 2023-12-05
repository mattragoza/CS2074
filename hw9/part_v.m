% OBJECT DETECTION

if ~exist('fasterRCNNResNet50EndToEndVehicleExample.mat','file')
    disp('Downloading pretrained detector (118 MB)...');
    pretrainedURL = 'https://www.mathworks.com/supportfiles/vision/data/fasterRCNNResNet50EndToEndVehicleExample.mat';
    websave('fasterRCNNResNet50EndToEndVehicleExample.mat', pretrainedURL);
end

pretrained = load('fasterRCNNResNet50EndToEndVehicleExample.mat');

%%

image_files = { ...
    'images/cars1.jpg', ...
    'images/cars2.jpg', ...
    'images/cars3.jpg'  ...
};
true_bboxs = [ % x y h w
    [115 104 108  70];
    [ 29  57 164 134];
    [104 126  60  52];
];

for i=1:3
    % load and resize the image
    im = imread(image_files{i});
    im = imresize(im, [224 224]);
    true_bbox = true_bboxs(i,:);

    % apply Faster R-CNN object detector
    [bbox, score] = detect(pretrained.detector, im);

    % visualize results
    figure;
    label = sprintf('score: %.2f', score);
    im = insertShape(im, 'rectangle', true_bbox, Color='magenta');
    im = insertObjectAnnotation(im, 'rectangle', bbox, label);
    imshow(im);
    impixelinfo;

    % compute intersection over union
    iou = intersect_over_union(bbox, true_bbox)
end
