
im1 = imread('images/keble1.png');
im2 = imread('images/keble2.png');

%im1 = imread('images/uttower1.jpg');
%im2 = imread('images/uttower2.jpg');

%% identify corresponding keypoints

PA = [279 123; 255 102; 337 15; 158 103; 324 106; 265 223; 218 181; 257 41];
PB = [183 138; 160 116; 240 34;  60 115; 226 122; 167 238; 120 194; 163 55];

%PA = [373 293; 327 505;  79 618; 103 505; 314 614; 392 575; 480 309; 531 521];
%PB = [816 321; 781 537; 551 650; 566 543; 780 648; 855 608; 928 329; 1000 550];

figure('Position', [50 50 900 400]);
subplot(1, 2, 1);
imshow(im1); impixelinfo()
hold on; plot(PA(:,1), PA(:,2), 'ro');

subplot(1, 2, 2);
imshow(im2); impixelinfo()
hold on; plot(PB(:,1), PB(:,2), 'bo');

%% estimate homography

H = estimate_homography(PA, PB);

%% apply homography

p1 = [163 78];
%p1 = [462 502]

p2 = apply_homography(p1, H);

figure('Position', [50 50 900 400]);
subplot(1, 2, 1);
imshow(im1);
hold on;
plot(p1(:,1), p1(:,2), 'go');

subplot(1, 2, 2);
imshow(im2);
hold on;
plot(p2(:,1), p2(:,2), 'yo');

saveas(gcf, 'keble_onept.png');
%saveas(gcf, 'uttower_onept.png');

%% create mosaic image

[H1, W1, ~] = size(im1);
[H2, W2, ~] = size(im2);

im3 = uint8(zeros(3*H2, 3*W2, 3));
im3(H2+1:H2*2, W2+1:W2*2, :) = im2;

for x=1:W2
    for y=1:H2
        p1 = [x, y];
        p2 = apply_homography(p1, H);
        p2 = p2 + [W2, H2];

        fxp = floor(p2(1));
        fyp = floor(p2(2));
        cxp = ceil(p2(1));
        cyp = ceil(p2(2));

        im3(fyp,fxp,:) = im1(y,x,:);
        im3(fyp,cxp,:) = im1(y,x,:);
        im3(cyp,fxp,:) = im1(y,x,:);
        im3(cyp,cxp,:) = im1(y,x,:);
    end
end

figure;
imshow(im3);
saveas(gcf, 'keble_mosaic.png')
%saveas(gcf, 'uttower_mosaic.png')
