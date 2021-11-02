function[] = HistogramEqualization(fileName)
    f =imread(fileName);
    f = rgb2gray(f);
    cnt = zeros(256,1);
    pr = zeros(256,1);
    [r c] = size(f);
    for ii=1:r
        for jj=1:c
             pos=f(ii,jj);
             cnt(pos+1,1)=cnt(pos+1)+1; %for histogram
             pr(pos+1,1)=cnt(pos+1,1)/(r*c); %for probability
        end
    end
    subplot(2,2,1),imshow(f),title('Origin Image');
    subplot(2,2,2),stem(cnt);
   
    %%

    %pr=cnt/(r*c);
    cnts=zeros(256,1);
    sk=zeros(256,1);
    sum=0;
    for i=1:size(pr)
        sum=sum+cnt(i);
            s=sum/(r*c);
            sk(i,1)=round(s*255);
        
    end
    %%
    for k=1:256
        m=sk(k,1);
       %m=uint16(m);
       cnts(m+1,1)=cnts(m+1,1)+cnt(k,1);
    end
    %subplot(2,1,2),imshow(cnt);
    hnew=uint8(zeros(r,c));
    for i=1:r
        for j=1:c
            hnew(i,j)=sk(f(i,j)+1,1);
        end
    end

    subplot(2,2,3),imshow(hnew),title('HistogramEqualization Result');
    subplot(2,2,4),stem(cnts),title('');
    set(gca,'XTick',0:51:256);
    set(gca,'XTickLabel',{'0','0.2','0.4','0.6','0.8','1'});
    axis([0 256 0 30000]);
end