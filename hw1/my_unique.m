function [N] = my_unique(M)

num_rows = size(M, 1);
num_cols = size(M, 2);

% compute L2 distance b/tw pairs of row vectors
% vectorize by using the polarization identity:
%   dist2(x,y) = x.x + y.y - 2 x.y

x_dot_y = M * M';
x_dot_x = diag(x_dot_y);
y_dot_y = x_dot_x';

distance = ...
    repmat(x_dot_x, 1, num_rows) + ...
    repmat(y_dot_y, num_rows, 1) - ...
    2 * x_dot_y;

% detect duplicate rows when distance from row i
%   to row j is less than a tolerance, and j > i
i = 1:num_rows;
j = i';
tol = 1e-8;
duplicate = (distance < tol) & (j > i);

% indices of unique rows that are not duplicates
%   of any previous row
unique_inds = find(~any(duplicate, 2));
N = M(unique_inds, :);

% debugging outputs
M
distance
duplicate
unique_inds
N
