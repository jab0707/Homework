function outIm = maskMap(im,mask,color,marker)
%MASKMAP Summary of this function goes here
%   Detailed explanation goes here

if size(im,3) ~= 3
    tempIm(:,:,1) = im;
    tempIm(:,:,2) = im;
    tempIm(:,:,3) = im;
    im = tempIm;
    clear('tempIm');
end
outIm = im;
for ind = 1:length(mask)
    if size(mask,2) == 1 || size(mask,1) == 1
        [id1,id2] = ind2sub([size(im,1),size(im,2)],mask(ind));
    else
        id2 = mask(ind,1);
        id1 = mask(ind,2);
    end
    if marker == 1
        outIm = insertMarker(outIm,[id2,id1],'o','color','r','size',3);
        outIm = insertMarker(outIm,[id2,id1],'o','color','r','size',4);
        outIm = insertMarker(outIm,[id2,id1],'o','color','r','size',5);
        outIm = insertMarker(outIm,[id2,id1],'o','color','r','size',6);
        outIm = insertMarker(outIm,[id2,id1],'o','color','r','size',7);
    end
    
    if color == 1
        outIm(id1,id2,1) = 255;
        outIm(id1,id2,2) = 0;
        outIm(id1,id2,3) = 0;
    elseif color == 2
        outIm(id1,id2,2) = 255;
        outIm(id1,id2,1) = 0;
        outIm(id1,id2,3) = 0;
    else
        outIm(id1,id2,3) = 255;
        outIm(id1,id2,2) = 0;
        outIm(id1,id2,1) = 0;
    end
    
end


end
