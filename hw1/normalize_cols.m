function [B] = normalize_cols(A)
num_rows = size(A, 1);
col_sums = sum(A, 1);
B = A ./ repmat(col_sums, num_rows, 1);
