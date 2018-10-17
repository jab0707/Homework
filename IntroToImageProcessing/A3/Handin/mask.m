function maskIm = mask(im,mappingIdx)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes her

cmap = [0,0,255;
    0,255,0;
    255,0,0;
    255,128,0;
    0,255,255;
    255,0,255;
    255,0,127;];

if size(im,3) == 1
    im(:,:,2) = im(:,:,1);
    im(:,:,3) = im(:,:,1);
end
[sz1,sz2,sz3] = size(im);

for linIdx = 1:length(mappingIdx)
    if (mappingIdx(linIdx) > 0)
        [r,c] = ind2sub([sz1,sz2],linIdx);
        im(r,c,:) = cmap(mappingIdx(linIdx),:);
    end
    
end
maskIm = uint8(im);
end

