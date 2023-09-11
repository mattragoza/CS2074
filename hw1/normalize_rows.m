function [B] = normalize_rows(A)
num_cols = size(A, 2);
row_sums = sum(A, 2);
B = A ./ repmat(row_sums, 1, num_cols);
