function [output] = my_pool(input, pool_size)
    debug = false;

    % input and filter size
    [H_in, W_in] = size(input);
    H_ft = pool_size;
    W_ft = pool_size;

    pad = 0;
    stride = pool_size;
    
    % padded input size
    H_pad = H_in + 2*pad;
    W_pad = W_in + 2*pad;

    if pad > 0 % pad the input with zeros
        padded_input = zeros([H_pad, W_pad]);
        padded_input((1:H_in) + pad, (1:W_in) + pad) = input;
    else
        padded_input = input;
    end

    % calculate output size
    H_out = floor((H_pad - H_ft) / stride) + 1;
    W_out = floor((W_pad - W_ft) / stride) + 1;
    if true
        fprintf( ...
            'my_pool([%d x %d], size=%d, pad=%d, stride=%d) -> [%d x %d]\n', ...
            H_in, W_in, H_ft, pad, stride, H_out, W_out ...
        );
    end

    % apply filter to padded input
    output = zeros([H_out, W_out]);
    for i=1:H_out
        for j=1:W_out

            % determine current window extent
            window_top    = 1 + (i - 1) * stride;
            window_bottom = window_top + H_ft - 1;
            window_left   = 1 + (j - 1) * stride;
            window_right  = window_left + W_ft - 1;
            if debug
                fprintf( ...
                    '%d, %d: [%d, %d] -> [%d, %d]\n', ...
                    i, j, window_top, window_left, window_bottom, window_right ...
                );
            end
            window = padded_input( ...
                window_top:window_bottom, ...
                window_left:window_right ...
            );

            % compute maximum value in window
            output(i,j) = max(window, [], 'all');
        end
    end
end