function[] = Restoration(imagePath)
    [f,map]=imread(imagePath);
    f = double(f);
    [m,n]=size(f);
    subplot(2, 3, 1)
    imshow(f,[]);
    title(sprintf('Blurring Image'),'FontSize',8);
    
    d=40;
    h=zeros(2*d+1,2*d+1);
    index = 2*d+1;
    for i=1:2*d+1
        h( i, index)= 1/(2*d);
        index = index -1;
    end
    
    fe=zeros(m+2*d,n+2*d);
    fe(1:m,1:n)=f;
    
    he=zeros(m+2*d,n+2*d);
    he( 1:2*d+1,1:2*d+1)=h;
    n=3*rand(m+2*d,n+2*d);

    F_fe=fftshift(fft2(fe));
    F_he=fftshift(fft2(he));
    gn=ifft2(F_fe.*F_he)+n;
    F_gn=fftshift(fft2(gn));

    % k=0.0 and d=40
    K = 0.00;
    f_hat = ((F_he.^2)./(F_he.^2+K)).*F_fe./F_he;
    f_hat=real( ifft2(f_hat));
    subplot(2, 3, 2)
    imshow( abs(f_hat), []);
    title(sprintf('K=0'),'FontSize',8);
    
    %k=0.0001 and d=40
    K = 0.0001;
    f_hat = ((F_he.^2)./(F_he.^2+K)).*F_fe./F_he;
    f_hat=real( ifft2(f_hat));
    subplot(2, 3, 3)
    imshow( abs(f_hat), []);
    title(sprintf('K=0.0001'),'FontSize',8);
    
    %k=0.0005 and d=40
    K = 0.0005;
    f_hat = ((F_he.^2)./(F_he.^2+K)).*F_fe./F_he;
    f_hat=real( ifft2(f_hat));
    subplot(2, 3, 4)
    imshow( abs(f_hat), []);
    title(sprintf('K=0.0005'),'FontSize',8);

    %k=0.001 and d=40
    K = 0.001;
    f_hat = ((F_he.^2)./(F_he.^2+K)).*F_fe./F_he;
    f_hat=real( ifft2(f_hat));
    subplot(2, 3, 5)
    imshow( abs(f_hat), []);
    title(sprintf('K=0.001'),'FontSize',8);
    
    %k=0.1 and d=40
    K = 0.1;
    f_hat = ((F_he.^2)./(F_he.^2+K)).*F_fe./F_he;
    f_hat=real( ifft2(f_hat));
    subplot(2, 3, 6)
    imshow( abs(f_hat), []);
    title(sprintf('K=0.1'),'FontSize',8);

end