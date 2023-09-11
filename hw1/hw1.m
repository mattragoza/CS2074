%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matrices and vectors:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
% 1. Generate a 1000000x1 (one million by one) vector of random numbers from a 
%    Gaussian (normal) distribution with mean of 0 and standard deviation of 5.
%    Use Matlab's randn function.

a = randn(1000000, 1) * 5;

%%
% 2. Add 1 to every value in the previous list, by using a loop. To determine 
%    how many times to loop, use Matlab's size function. Time this operation 
%    and print the number in the code. Write that number down in answers.txt.
%    Use Matlab's documentation to find out how to time operations.

tic;
for i=1:size(a)
    a(i) + 1;
end
time = toc;
time

%%
% 3. Now add 1 to every value in the original random vector, without using a 
%    loop. Time this operation, print the time and write it down. Use a 
%    different way to print the number than the method you used above. (See
%    ways to print numbers at the beginning of the Matlab tutorial script.)

tic;
a + 1;
time = toc;
disp(time);

%%
% 4. Plot the exponential function 2.^x, for non-negative even values of x 
%    smaller than 100, without using loops.

figure;
x = 0:2:98;
plot(x, 2.^x);
xlabel('x');
ylabel('y');
title('Exponential function (y = 2^x)');

%%
% 5. Create two matrices A and B which, when added together, result in a 10x10
%    matrix C containing all numbers from 1 to 100. In other words, when I add
%    A and B and convert the result to vector form, I should get a vector 
%    containing all numbers from 1 to 100.
%    In code, C = A + B; assert(all(C(:) == (1:100)') == 1); 
%    Each matrix should only be created with a single command (no loops). 
%    Don't use a matrix of all zeros as A or B, and make sure the entries are 
%    in order (that's what the assertion checks).

A = repmat((1:10)', 1, 10);     % column vectors of 1 to 10 in steps of 1
B = repmat(0:10:90, 10, 1);     % row vectors of 0 to 90 in steps of 10
C = A + B;
assert(all(C(:) == (1:100)'));

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Loops allowed:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
% 6. Create a script that prints all the integers between 1 and 10, in random 
%    order, with pauses of 1 second between each two prints.

p = randperm(10);
for i=1:10
    disp(p(i));
    if ~mod(i, 2)
        pause(1);
    end
end

%%
% 7. Generate two random matrices A and B, and compute their product by hand, 
%    using loops. The size of the first matrix should be [5, 3] and of the 
%    second [3, 5]. Check your code by comparing the loop-computed product with 
%    the product that you get from Matlab's A*B.

M = 5; K = 3; N = 5;
A = rand(M, K);
B = rand(K, N);

C = zeros(M, N);
for i=1:M
    for j=1:N
        for k=1:K
            C(i,j) = C(i,j) + A(i,k) * B(k,j);
        end
    end
end
error = norm(C - A*B)       % error is close to zero

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Functions:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
% 8. Write a function function [B] = normalize_rows(A) which uses a single 
%    command (one line and no loops) to make the sum in each row of the matrix
%    1. Use the repmat function. The sum of the entries in each row should be 
%    1, in the matrix output by your function. Note that you can't obliterate 
%    the original matrix, i.e. you can't just create rows with N values of 1/N 
%    each--you have to transform the original values but preserve their order.
%    You can assume all entries in the vector are non-negative and the sum is
%    positive.

A = rand(randi(5,1,2));
B = normalize_rows(A);
error = norm(sum(B, 2) - 1)     % error is close to zero

%%
% 9. Now write a function function [B] = normalize_columns(A) which instead
%    ensures that the sum in each column is 1.

A = rand(randi(5,1,2));
B = normalize_cols(A);
error = norm(sum(B, 1) - 1)     % error is close to zero

%%
% 10. Create a function function [val] = fib(n) that returns the n-th number
%     (n >= 1) in the Fibonacci sequence 1, 1, 2, 3, 5, 8, 13...

assert(fib(1) == 1);
assert(fib(2) == 1);
assert(fib(3) == 2);
assert(fib(4) == 3);
assert(fib(5) == 5);
assert(fib(6) == 8);
assert(fib(7) == 13);

%%
% 11. Implement a function function [N] = my_unique(M) that takes in a matrix
%     M, removes duplicate rows from that input matrix and outputs the result
%     as matrix N. You cannot call Matlab's unique function. Loops are allowed.

M = randi(2, randi(10), randi(4)) - 1;     % random matrix of 0's and 1's
N = my_unique(M);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Images:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
% 12. Read this image into Matlab as a matrix, and write down its dimensions.

im = imread('pittsburgh.png');
im_size = size(im)

%%
% 13. Convert the image into grayscale.

im_gray = rgb2gray(im);

%%
% 14. Use the function sum and a logical operator which measures equality to a
%     scalar, to determine and write down how many pixels in the grayscale
%     image are equal to 6. Don't use loops.

num_pixels = sum(im_gray == 6, 'all')

%%
% 15. Find the darkest pixel in the image, and write its value and 
%     [row, column] in your answer sheet. Don't use loops. Hint: Convert to a 
%     vector first, and use Matlab's ind2sub function. Use Matlab's help to 
%     find out how to use that function.

[min_val, min_idx] = min(im_gray(:));
[min_row, min_col] = ind2sub(size(im_gray), min_idx)

%%
% 16. Consider a 31x31 square (a square with side equal to 31 pixels) that is  
%     centered on the darkest pixel from the previous question. Replace all 
%     pixels in that square with white pixels (pixels with value 255). Do this 
%     with loops.

for i=-15:15
    for j=-15:15
        im_gray(min_row+i, min_col+j) = 255;
    end
end

%%
% 17. Take the previous image with the white square in it. Place a 121x121 gray  
%     square (e.g. pixel values 150) at the center of this image. This time you 
%     are NOT allowed to use loops. Hint: You can access a range of rows and 
%     columns in a matrix; see examples in the tutorial.

mid_row = size(im_gray, 1) / 2;
mid_col = size(im_gray, 2) / 2;

im_gray(mid_row-60:mid_row+60, mid_col-60:mid_col+60) = 150;

%%
% 18. Make a new figure, display the modified image (which includes both a 
%     white square and gray square), and save the new figure to a file using 
%     saveas(gcf, 'new_image.png').

figure;
imagesc(im_gray);
truesize;
colormap gray;
saveas(gcf, 'new_image.png');

%%
% 19. Using the original pittsburgh.png image, compute the scalar average pixel 
%     value along each channel (R, G, B) separately, then subtract the average 
%     value per channel. Display the resulting image and write it to a file 
%     mean_sub.png. If you choose to do this using a new matrix as your image, 
%     make sure it is of the same class/datatype (uint8) as the original image;
%     a simple cast would do the job. You may use loops.

avg_color = mean(im, 1:2);
im2 = double(im);
im2 = im2 - repmat(avg_color, size(im, 1:2));
im2 = uint8(im2);

figure;
imagesc(im2);
truesize;
saveas(gcf, 'mean_sub.png');
