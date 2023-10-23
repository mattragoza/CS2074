function H = estimate_homography(PA, PB)

    size(PA)
    size(PB)

    N = size(PA, 1);

    A = zeros(2*N, 9);
    for i=1:N
        x = PA(i,1);
        y = PA(i,2);
        xp = PB(i,1);
        yp = PB(i,2);

        row1 = 2*i - 1;
        row2 = 2*i;
   
        A(row1,:) = [-x -y -1  0  0  0  x*xp y*xp xp];
        A(row2,:) = [ 0  0  0 -x -y -1  x*yp y*yp yp];
    end

    [~, ~, V] = svd(A);
    h = V(:, end); % smallest singular vector
    H = reshape(h, 3, 3)';

end