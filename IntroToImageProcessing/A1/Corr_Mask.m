function  Corr_Mask(im,f,thres,one,two,three)
%This function performs a correlation of the given f over the image im. it
%retuns an output image with a red mask over the area that is above the
%threshold

grayIm = rgb2gray(im);
grayF = rgb2gray(f);
corr = xcorr2(grayIm,grayF);
corr = corr-min(corr(:));
corr = uint8((corr/max(corr(:)))*255);
corr_2 = normxcorr2(grayF,grayIm);
corr_2 = uint8(abs(corr_2)*255);


threshCorr2 = corr_2 > thres;

threshCorr = corr>thres;
colBuff = int64(abs(floor((size(im,2)-size(threshCorr,2))/2)));
rowBuff = int64(abs(floor((size(im,1)-size(threshCorr,1))/2)));
threshMask = threshCorr(rowBuff:size(threshCorr,1) - rowBuff,colBuff:size(threshCorr,2) - colBuff);

maskIm = im;
outlineIm = im;
[row,col] = find(threshMask == 1);
row = int64(row);
col = int64(col);
if one == 1
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
end

if two == 1
    maskIm2 = im;
    outlineIm2 = im;
    [row,col] = find(threshCorr2 == 1);
    row = int64(row);
    col = int64(col);
    for i = 1:length(row)
        maskIm2(row(i),col(i),1) = 255;
        maskIm2(row(i),col(i),2) = 0;
        maskIm2(row(i),col(i),3) = 0;

        side1R = (row(i) - rowBuff:row(i)+rowBuff);
        side1C = int64(ones(length(side1R))) * (col(i) - colBuff);
        side3C = int64(ones(length(side1R))) * (col(i) + colBuff);
        side2C = (col(i) - colBuff:col(i) + colBuff);
        side2R = int64(ones(length(side2C))) * (row(i) + rowBuff);
        side4R = int64(ones(length(side2C))) * (row(i) - rowBuff);

        for j = 1:length(side1R)
            try
               outlineIm2(side1R(j),side1C(j),1) = 255;
               outlineIm2(side1R(j),side1C(j),2) = 0;
               outlineIm2(side1R(j),side1C(j),3) = 0;

            catch
            end
            try
               outlineIm2(side1R(j),side3C(j),1) = 255;
               outlineIm2(side1R(j),side3C(j),2) = 0;
               outlineIm2(side1R(j),side3C(j),3) = 0;
            catch
            end
        end

        for j = 1:length(side2C)
            try
               outlineIm2(side2R(j),side2C(j),1) = 255;
               outlineIm2(side2R(j),side2C(j),2) = 0;
               outlineIm2(side2R(j),side2C(j),3) = 0;

            catch
            end
            try
               outlineIm2(side4R(j),side2C(j),1) = 255;
               outlineIm2(side4R(j),side2C(j),2) = 0;
               outlineIm2(side4R(j),side2C(j),3) = 0;
            catch
            end
        end

    end
end


%Method 3 using corr2 iterativly
if three == 1
    fsz1 = size(f,1);
    fsz2 = size(f,2);
    clag = size(im,2) - size(f,2);
    rlag = size(im,1) - size(f,1);

    corr3 = [];
    for i = 1:clag
        for j = 1:rlag
            corr3(j,i,1) = corr2(im(j:(j+fsz1-1),i:(i+fsz2-1),1),f(:,:,1));
            corr3(j,i,2) = corr2(im(j:(j+fsz1-1),i:(i+fsz2-1),3),f(:,:,2));
            corr3(j,i,3) = corr2(im(j:(j+fsz1-1),i:(i+fsz2-1),2),f(:,:,3));
            corr3(j,i,4) = corr2(grayIm(j:(j+fsz1-1),i:(i+fsz2-1)),grayF);
        end
    end
    corr3_4 = corr3(:,:,4);
    corr3(:,:,4) = corr3(:,:,4) - min(corr3_4(:));
    corr3_4 = corr3(:,:,4);
    corr3(:,:,4) = (corr3(:,:,4)/max(corr3_4(:)))*255;

    pad1 = int64(floor(fsz1/2));
    pad2 = int64(floor(fsz2/2));


    maskIm3 = im;
    outlineIm3 = im;
    [row,col] = find(corr3(:,:,4)>thres);
    row = int64(row);
    col = int64(col);
    for i = 1:length(row)
        maskIm3(row(i)+pad1,col(i)+pad2,1) = 255;
        maskIm3(row(i)+pad1,col(i)+pad2,2) = 0;
        maskIm3(row(i)+pad1,col(i)+pad2,3) = 0;

        side1R = (row(i)+pad1 - rowBuff:row(i)+pad1+rowBuff);
        side1C = int64(ones(length(side1R))) * (col(i)+pad2 - colBuff);
        side3C = int64(ones(length(side1R))) * (col(i)+pad2 + colBuff);
        side2C = (col(i)+pad2 - colBuff:col(i)+pad2 + colBuff);
        side2R = int64(ones(length(side2C))) * (row(i)+pad1 + rowBuff);
        side4R = int64(ones(length(side2C))) * (row(i)+pad1 - rowBuff);

        for j = 1:length(side1R)
            try
               outlineIm3(side1R(j),side1C(j),1) = 255;
               outlineIm3(side1R(j),side1C(j),2) = 0;
               outlineIm3(side1R(j),side1C(j),3) = 0;

            catch
            end
            try
               outlineIm3(side1R(j),side3C(j),1) = 255;
               outlineIm3(side1R(j),side3C(j),2) = 0;
               outlineIm3(side1R(j),side3C(j),3) = 0;
            catch
            end
        end

        for j = 1:length(side2C)
            try
               outlineIm3(side2R(j),side2C(j),1) = 255;
               outlineIm3(side2R(j),side2C(j),2) = 0;
               outlineIm3(side2R(j),side2C(j),3) = 0;

            catch
            end
            try
               outlineIm3(side4R(j),side2C(j),1) = 255;
               outlineIm3(side4R(j),side2C(j),2) = 0;
               outlineIm3(side4R(j),side2C(j),3) = 0;
            catch
            end
        end

    end
end

figure(1);clf();
imshow(im);

figure(2);clf();
imshow(f);

if one == 1
figure(3);clf();
imshow(maskIm);
figure(4);clf();
imshow(outlineIm);
end
if two == 1
figure(5);clf();
imshow(maskIm2);

figure(6);clf();
imshow(outlineIm2);
end
if three ==1
figure(8);clf();
imshow(outlineIm3);
figure(7);clf();
imshow(maskIm3);
end
end

