function displaySeam(im, seam, seamDirection)

hold on;
if strcmp(seamDirection, 'VERTICAL')
    plot(seam, 1:size(im,1));
else
    assert(strcmp(seamDirection, 'HORIZONTAL'));
    plot(1:size(im,2), seam);
end
hold off;
