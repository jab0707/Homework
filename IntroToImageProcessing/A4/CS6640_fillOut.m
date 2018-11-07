function fIm = CS6640_fillOut(im,sz)

fIm = zeros(size(im));
padIm = zeros((size(im)+[4,4]));
padIm(3:end-2,3:end-2) = im;
[sz1,sz2] = size(im);

for r = 3:sz1+2
    for c = 3:sz2+2
        val = sum(sum(padIm(r-2:r+2,c-2:c+2)));
        if val>255
            val = 255;
        end
        fIm(r-2,c-2) = val;
    end
end


end