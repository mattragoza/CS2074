
image_file = 'images/spiral.jpg';
im = imread(image_file);

% corner detection parameters
k = 0.05;
hsize = 2;              % half window size
fsize = 2 * hsize + 1;  % full window size

% convert image to grayscale double
im_gray = double(rgb2gray(im));
[height, width] = size(im_gray);

% Sobel derivative filters
Dh = [1 0 -1;2 0 -2;1 0 -1];
Dv = [1 2 1;0 0 0;-1 -2 -1];

% apply derivative filters to image
Ih = imfilter(im_gray, Dh);
Iv = imfilter(im_gray, Dv);

% compute corner detection scores
R = zeros(height, width);
for i=(hsize + 1):(height - hsize - 1)
    for j=(hsize + 1):(width - hsize - 1)

        % compute structure tensor
        M = zeros(2, 2);
        for u=-hsize:hsize
            for v=-hsize:hsize
                M(1,1) = M(1,1) + Ih(i+u,j+v)^2;
                M(1,2) = M(1,2) + Ih(i+u,j+v)*Iv(i+u,j+v);
                M(2,1) = M(2,1) + Ih(i+u,j+v)*Iv(i+u,j+v);
                M(2,2) = M(2,2) + Iv(i+u,j+v)^2;
            end
        end
        % approximate smallest eigenvalue
        R(i,j) = det(M) - k * trace(M)^2;
    end
end

% apply score threshold
threshold = quantile(R, 0.9999, 'all');
R_threshold = (R > threshold);

% perform non-max suppression
R_suppress = zeros(height, width);
for i=(hsize + 1):(height - hsize - 1)
    for j=(hsize + 1):(width - hsize - 1)
        if R(i,j) > threshold
            window = R(i-hsize:i+hsize, j-hsize:j+hsize);
            window_max = max(window, [], 'all');
            if R(i,j) < window_max
                R_suppress(i,j) = 0;
            else
                R_suppress(i,j) = 1;
            end
        end
    end
end

% convert to pixel indices
[y, x] = find(R_suppress);

%% VISUALIZATION

% diplay color and grayscale image
figure;
subplot(1, 2, 1); imagesc(im);
subplot(1, 2, 2); imagesc(im_gray);
colormap gray;

% display image gradient
figure;
subplot(1, 2, 1); imagesc(Ih);
subplot(1, 2, 2); imagesc(Iv);
colormap gray;

% display image gradient
figure;
subplot(1, 2, 1); imagesc(Ih);
subplot(1, 2, 2); imagesc(Iv);
colormap gray

% display corner detection
figure;
subplot(1, 3, 1); imagesc(R);
subplot(1, 3, 2); imagesc(R_threshold);
subplot(1, 3, 3); imagesc(R_suppress); hold on; scatter(x, y);
colormap gray;
