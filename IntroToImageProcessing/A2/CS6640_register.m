function [imr,q,A] = CS6640_register(im,s,cpts)
% CS6640_register - produce registered image and
% transform
% On input:
%   im (MxN array): input image
%   s (int): transform switch: if 1, then quadratic,
%    else affine
%   cpts (2kx2 array): k corresponding points (evens are one set;
%   odds the other)
% On output:
%   imr (MxN array): registered image
%   q (1x12 vector): quadratic coefficients
%   A (3x3 array): affinetransform
% Call:
%   [imr,q,A] = CS6640_register(im,1);
% Author:
%   Jake Bergquist
%   UU
%   2018


corrPts = length(cpts);
if corrPts ~= 12
    error('Please only enter 6 pairs of correspondence points');
end
ptMatrix = zeros(corrPts,12);
ptMatrix(1:corrPts/2,1) = 1;
ptMatrix((corrPts/2)+1:end,7) = 1;
transPtMatrix = zeros(corrPts,1);
counter = 1;
for pt = 1:2:corrPts
    im1pt = cpts(pt,:);
    x1 = im1pt(1);%The column (x value)
    y1 = im1pt(2);%The row (y value)
    im2pt = cpts(pt+1,:);
    x2 = im2pt(1);
    y2 = im2pt(2);
    ptMatrix(counter,2:6) = [x1,y1,x1*y1,x1^2,y1^2];
    ptMatrix(counter+(corrPts/2),8:12) = [x1,y1,x1*y1,x1^2,y1^2];
    transPtMatrix(counter) = x2;
    transPtMatrix(counter+6)=y2;
    counter = counter+1;
end
q = inv(ptMatrix)*transPtMatrix;%



% for affine [x',y'] = A*[x;y;1] where A = [a11 a12 a13;
%                                           a21 a22 a23;
%                                           0   0   1;
%Thus to calculate the A matrix from a given correspondence of
%[x,y] and [x1,y1] we would re arrange to an equation like so:
%[x1 y1 1  0  0  0 * [a11  = [x'1
% x1 y2 1  0  0  0    a12     x'2
% x3 y3 1  0  0  0    a13     x'3
% 0  0  0  x1 y1 1    a21     y'1
% 0  0  0  x2 y2 1    a22     y'2
% 0  0  0  x3 y3 1]   a23]    y'3]
%thus:  X          * a     =  X'
%thus a = X'*inv(X)\
cpts = cpts(1:6,:);%Grab half of the corr pts to use for affine, only need three
corrPts = length(cpts);

ptMatrix = zeros(corrPts,6);
ptMatrix(1:corrPts/2,3) = 1;
ptMatrix((corrPts/2)+1:end,6) = 1;
transPtMatrix = zeros(corrPts,1);
counter = 1;
for pt = 1:2:corrPts
    im1pt = cpts(pt,:);
    x1 = im1pt(1);%The column (x value)
    y1 = im1pt(2);%The row (y value)
    im2pt = cpts(pt+1,:);
    x2 = im2pt(1);
    y2 = im2pt(2);
    ptMatrix(counter,1:2) = [x1,y1];
    ptMatrix(counter+(corrPts/2),4:5) = [x1,y1];
    transPtMatrix(counter) = x2;
    transPtMatrix(counter+3)=y2;
    counter = counter+1;
end
Aterms = inv(ptMatrix)*transPtMatrix;%
A = [Aterms(1:3)';Aterms(4:6)';0,0,1];


%%%%%%%%%%%%%%%%%%%%%%%%%
newX = zeros(size(im(:)));
newY = zeros(size(im(:)));
oldX = zeros(size(im(:)));
oldY =zeros(size(im(:)));
origGrayValue = zeros(size(im(:)));
counter = 1;
if s == 1%if quadratic do the quadratic transform
    for r = 1:size(im,1)
        for c = 1:size(im,2)
            newX(counter) = [1,c,r,c*r,c^2,r^2,0,0,0,0,0,0]*q;
            newY(counter) = [0,0,0,0,0,0,1,c,r,c*r,c^2,r^2]*q;
            oldX(counter) = c;
            oldY(counter) = r;
            origGrayValue(counter) = im(r,c);
            counter = counter +1;
        end   
    end
else%Otherwise do the Affine
    for r = 1:size(im,1)
        for c = 1:size(im,2)
            newXY = A*[c;r;1];
            newX(counter) = newXY(1);
            newY(counter) = newXY(2);
            oldX(counter) = c;
            oldY(counter) = r;
            origGrayValue(counter) = im(r,c);
            counter = counter +1;
        end   
    end
end


    

remappedData = griddata(oldX,oldY,origGrayValue,newX,newY);

nanIdx = find(isnan(remappedData));
for nId = 1:length(nanIdx)
    remappedData(nanIdx(nId)) = 0;%remappedData(nanIdx(nId)+1);
end

imr = zeros(size(im));
counter = 1;
for r = 1:size(imr,1)
    for c = 1:size(imr,2)
        imr(r,c) = remappedData(counter);
        counter = counter + 1;
    end
end

imr = uint8(imr);

end