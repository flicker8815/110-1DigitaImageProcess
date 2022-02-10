function[] = LowPassFilter(imagePath, radius)
    img = imread(imagePath);
    img = double(img);
    [M ,N] = size(img);
    %539    540
    x = 0 : N - 1;
    y = 0 : M - 1;
   
    subplot(2, 3, 1)
    imshow(img, []);
    title(sprintf('Origin Image'), 'FontSize', 8);
      
    FFT2 = fft2(img);
    FFTShiftImg = fftshift(FFT2);
    LogImg = log(1 + abs(FFTShiftImg));
    subplot(2, 3, 2)
    imshow(LogImg, []);
    title(sprintf('Origin Image in Frequency Domain'), 'FontSize', 8);
     
    [X ,Y] = meshgrid(x,y);
    CFx = 0.5 * N;
    CFy = 0.5 * M;
    CF = (radius - sqrt((X - CFx).^2 + (Y - CFy).^2)) / radius;
    
    for i = 1 : M
        for j = 1 : N
            if (CF(i,j) < 0)
                CF(i,j) = 0;
            end
        end
    end

    subplot(2,3,3);
    imshow(CF);
    title(sprintf('Cone Filter Radis = %d', radius), 'FontSize', 8);
    
    FFTShiftImg2 = fftshift(fft2(img));
    CF2 = fftshift(fft2(CF)); 
    
    FilterImage = FFTShiftImg2 .* CF;
    result = ifftshift(FilterImage);
    result = ifft2(result);
    
    subplot(2,3,4);
    imshow(abs(result) / 255);
    title(sprintf('Cones Filter Result'), 'FontSize', 8);
    
    tx = -(N / 2) : N / 2 - 1;
    ty = -(M / 2) : M / 2 - 1;
    [tX ,tY] = meshgrid(tx,ty);
    CO2 = ((tX.* tY).* 0 + 1) .* CF;

    subplot(2,3,5);
    mesh(tX, tY, CO2, 'FaceColor', 'Flat')
    title(sprintf('Cones Filter 3D visualization'), 'FontSize', 8);
    xlim([-300 300]) 
    ylim([-300 300])
    
    subplot(2,3,6);
    imshow(log(1 + abs(CF2)), []);
    title(sprintf('Cone Filter in frequency domain'), 'FontSize',8);
end
