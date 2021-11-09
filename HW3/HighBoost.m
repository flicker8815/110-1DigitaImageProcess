function[] = HighBoost(imagePath)

    x = imread(imagePath);
    x2 = single(imread(imagePath));

    subplot(2, 3, 1)
    imshow(x2,[]);
    title(sprintf('Origin image [0 255]'));
    
    f1=fspecial('gaussian',[31 31],5);
    blur = imfilter(x, f1);
    blur2=imfilter(x2,f1);
    subplot(2, 3, 2)
    imshow(blur,[]);
    title(sprintf('Blurred image [0 255]'));
    
    subplot(2, 3, 3)
    mask = x -blur;
    mask2=x2-blur2;
    imshow(mask2, []);
    title(sprintf('mask [-255 255]'));

    subplot(2, 3, 4) 
    imshow(x + mask);
    title(sprintf('k=1 [0 255]'));
    
    subplot(2, 3, 6) 
    imshow(x+4.5*(mask));
    title(sprintf('k=4.5 Higt Boost image [0 255]'));
    
end

