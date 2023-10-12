function [centers] = detectCircles(im, edges, radii, top_k)

[height, width, ~] = size(im)

quantization = 4;
hbins = ceil(height / quantization);
wbins = ceil(width / quantization);
nrads = length(radii);
H = zeros(hbins, wbins, nrads);

for i=1:size(edges, 1)
    x = edges(i,1);
    y = edges(i,2);
    mag = edges(i,3); % gradient magnitude
    phi = edges(i,4); % gradient angle
    % ignore edges on the image border
    if (1 < x && x <= width - 1) && (1 < y && y <= height - 1)
        for r_idx=1:nrads
            radius = radii(r_idx);
            for theta=1:360
                a = x - radius * cosd(theta);
                b = y - radius * sind(theta);
                if (0 < a && a <= width) && (0 < b && b <= height)
                    a_idx = ceil(a / quantization);
                    b_idx = ceil(b / quantization);
                    h = sqrt(mag) .* abs(cosd(theta - phi)).^2;
                    H(b_idx,a_idx,r_idx) = H(b_idx,a_idx,r_idx) + h;
                end
            end
        end
    end
end

% detect top K circle parameters
[H_max, inds] = sort(H(:), 'descend');
max_inds = inds(1:top_k);
[b, a, r] = ind2sub(size(H), max_inds);
centers = [a, b] * quantization

% visualize Hough transform
for i=1:nrads
    figure;
    imshow(H(:,:,i), [0, H_max(1)]);
end

% visualize detected circles
figure;
imshow(im);
viscircles(centers, radii(r)');

end

