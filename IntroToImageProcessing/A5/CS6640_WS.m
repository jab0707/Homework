function WS = CS6640_WS(im)
% CS6640_WS - watershed (returns largest spread region)
% On input:
%   im (MxN array): input image
% On output:
%   WS (MxN array): labeled watershed regions
% Call:
%   WS = CS6640_WS(im);
% Author:
%   Jake Bergquist
%   UU
%   Fall 2018

im = double(im)*-1;
dirIm = zeros(size(im));
padIm = (zeros((size(im)+2)));
padIm(2:end-1,2:end-1) = im;
for m = 2:size(padIm,1)-1
    for n = 2:size(padIm,2)-1
        px1 = padIm(m-1,n-1);
        px2 = padIm(m-1,n);
        px3 = padIm(m-1,n+1);
        px4 = padIm(m,n-1);
        px5 = padIm(m,n);
        px6 = padIm(m,n+1);
        px7 = padIm(m+1,n-1);
        px8 = padIm(m+1,n);
        px9 = padIm(m+1,n+1);
        
        [val,idx] = min([px1,px2,px3,px4,px5,px6,px7,px8,px9]);
        if (val == px5)
            idx = 5;
        end
        dirIm(m-1,n-1) = idx;
    end
end

binIm = (dirIm == 5);
labels = bwlabel(binIm);


for pixel = 1:length(binIm(:))
    foundLabel = 0;
    if (labels((pixel)) ~=0)
        foundLabel = 1;
    end
    pixelTrail = [(pixel)];
    currentPix = (pixel);
    while foundLabel ~= 1
        dir = dirIm(currentPix);
        if (dir == 5)
            foundLabel =1;
        else
            pixelTrail = [pixelTrail,currentPix];
            if (dir == 1)
                currentPix = currentPix-size(dirIm,1)-1;
            elseif (dir == 2)
                currentPix = currentPix-1;
            elseif (dir == 3)
                currentPix = currentPix+size(dirIm,1)-1;
           elseif (dir == 4)
                currentPix = currentPix-size(dirIm,1);
            elseif (dir == 6)
                currentPix = currentPix+size(dirIm,1);
            elseif (dir == 7)
                currentPix = currentPix-size(dirIm,1)+1;
            elseif (dir == 8)
                currentPix = currentPix+1;
            elseif (dir == 9)
                currentPix = currentPix+size(dirIm,1)+1;
            end
        end
    end
    labels(pixelTrail) = labels(currentPix);
end
WS = labels;
end

