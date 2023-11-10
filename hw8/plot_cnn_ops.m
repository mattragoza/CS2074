function plot_cnn_ops(input, conv, relu, pool)

    [H, W] = size(input);
    scale = 50;
    cmax = max(abs(conv), [], 'all');
    cmax = max(eps, cmax);
    
    figure('Position', [100 100 4.4*scale*W scale*H]);
    colormap('gray');
    
    subplot(1, 4, 1);
    imagesc(input, [-1, 1]);
    title('input');
    yticks(1:size(input, 1));
    xticks(1:size(input, 2));
    
    subplot(1, 4, 2);
    imagesc(conv, [-cmax, cmax]);
    title('conv');
    yticks(1:size(conv, 1));
    xticks(1:size(conv, 2));
    
    subplot(1, 4, 3);
    imagesc(relu, [-cmax, cmax]);
    title('relu');
    yticks(1:size(relu, 1));
    xticks(1:size(relu, 2));
    
    subplot(1, 4, 4);
    imagesc(pool, [-cmax, cmax]);
    title('pool');
    yticks(1:size(pool, 1));
    xticks(1:size(pool, 2));

end