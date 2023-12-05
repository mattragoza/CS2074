function IoU = intersect_over_union(bbox_A, bbox_B)
    % bbox = [x y h w]

    A_left   = bbox_A(1);
    A_upper  = bbox_A(2);
    A_height = bbox_A(3);
    A_width  = bbox_A(4);

    A_right  = A_left  + A_width;
    A_lower  = A_upper + A_height;
    A_area   = A_width * A_height;

    B_left   = bbox_B(1);
    B_upper  = bbox_B(2);
    B_height = bbox_B(3);
    B_width  = bbox_B(4);

    B_right  = B_left  + B_width;
    B_lower  = B_upper + B_height;
    B_area   = B_width * B_height;

    % intersection
    I_left  = max(A_left,  B_left);
    I_upper = max(A_upper, B_upper);
    I_right = min(A_right, B_right);
    I_lower = min(A_lower, B_lower);

    I_width  = max(0, I_right - I_left);
    I_height = max(0, I_lower - I_upper);
    I_area = I_width * I_height;

    % union
    U_area = A_area + B_area - I_area;

    IoU = I_area / U_area;
end