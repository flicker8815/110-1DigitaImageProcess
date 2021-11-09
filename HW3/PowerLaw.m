function[] = PowerLaw(imagePath, gamma)
    x = imread(imagePath);
    x = rgb2gray(x);
    x = im2double(x);
    [m, n] = size(x);
    c = 1;
    for i = 1 : m
        for j = 1 : n
            out(i, j) = c * (x(i,j) ^ gamma);
        end
    end
    subplot(2, 1, 1)
    imshow(x);
    title('Orignal Image');
    subplot(2, 1, 2)
    imshow(out);
    title(sprintf('Power Law gamma = %.1f', gamma));
end