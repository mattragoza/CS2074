function [centers] = detectCircles(im, edges, radius, top_k)

[height, width, ~] = size(im);

quantization = 4;
hbins = ceil(height / quantization);
wbins = ceil(width / quantization);
H = zeros(hbins, wbins);

for i=1:size(edges, 1)
    x = edges(i,1);
    y = edges(i,2);
    mag = edges(i,3); % gradient magnitude
    phi = edges(i,4); % gradient angle
    % ignore edges on the image border
    if (1 < x && x <= width - 1) && (1 < y && y <= height - 1)
        for theta=1:360
            a = x - radius * cosd(theta);
            b = y - radius * sind(theta);
            if (0 < a && a <= width) && (0 < b && b <= height)
                a_idx = ceil(a / quantization);
                b_idx = ceil(b / quantization);

                % I found much better circle detection accuracy by
                % weighting the accumulated values by the gradient
                % magnitude and angle relative to theta, which makes
                % sense if you think about how the edges that define
                % the circle boundary should be oriented
                h = sqrt(mag) .* abs(cosd(theta - phi)).^2;
                
                H(b_idx,a_idx) = H(b_idx,a_idx) + h;
            end
        end
    end
end

% detect top K circle parameters
[H_max, inds] = sort(H(:), 'descend');
max_inds = inds(1:top_k);
[b, a] = ind2sub(size(H), max_inds);
centers = [a, b] * quantization

% visualize Hough transform
figure('Position', [10 10 width * 2 height]);
subplot(1, 2, 1);
imshow(H, [0, H_max(1)]);
title(sprintf('Hough transform (r = %d)', radius));

% visualize detected circles
subplot(1, 2, 2);
imshow(im);
viscircles(centers, radius * ones(top_k, 1));
title(sprintf('Detected circles (top k = %d)', top_k));

end

