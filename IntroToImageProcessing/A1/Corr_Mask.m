function  Corr_Mask(im,f,thres)
%This function performs a correlation of the given f over the image im. it
%retuns an output image with a red mask over the area that is above the
%threshold

grayIm = rgb2gray(im);
grayF = rgb2gray(f);
corr = xcorr2(grayIm,grayF);
corr = uint8((corr/max(corr(:)))*255);

threshCorr = corr>thres;
colBuff = int64(abs(floor((size(im,2)-size(threshCorr,2))/2)));
rowBuff = int64(abs(floor((size(im,1)-size(threshCorr,1))/2)));
threshMask = threshCorr(rowBuff:size(threshCorr,1) - rowBuff,colBuff:size(threshCorr,2) - colBuff);

maskIm = im;
outlineIm = im;
[row,col] = find(threshMask == 1);
row = int64(row);
col = int64(col);
for i = 1:length(row)
    maskIm(row(i),col(i),1) = 255;
    maskIm(row(i),col(i),2) = 0;
    maskIm(row(i),col(i),3) = 0;
    
    side1R = (row(i) - rowBuff:row(i)+rowBuff);
    side1C = int64(ones(length(side1R))) * (col(i) - colBuff);
    side3C = int64(ones(length(side1R))) * (col(i) + colBuff);
    side2C = (col(i) - colBuff:col(i) + colBuff);
    side2R = int64(ones(length(side2C))) * (row(i) + rowBuff);
    side4R = int64(ones(length(side2C))) * (row(i) - rowBuff);
    
    for j = 1:length(side1R)
        try
           outlineIm(side1R(j),side1C(j),1) = 255;
           outlineIm(side1R(j),side1C(j),2) = 0;
           outlineIm(side1R(j),side1C(j),3) = 0;
           
        catch
        end
        try
           outlineIm(side1R(j),side3C(j),1) = 255;
           outlineIm(side1R(j),side3C(j),2) = 0;
           outlineIm(side1R(j),side3C(j),3) = 0;
        catch
        end
    end
    
    for j = 1:length(side2C)
        try
           outlineIm(side2R(j),side2C(j),1) = 255;
           outlineIm(side2R(j),side2C(j),2) = 0;
           outlineIm(side2R(j),side2C(j),3) = 0;
           
        catch
        end
        try
           outlineIm(side4R(j),side2C(j),1) = 255;
           outlineIm(side4R(j),side2C(j),2) = 0;
           outlineIm(side4R(j),side2C(j),3) = 0;
        catch
        end
    end
    
end
figure(1);clf();
imshow(im);

figure(2);clf();
imshow(f);

figure(3);clf();
imshow(maskIm);

figure(4);clf();
imshow(outlineIm);


end

