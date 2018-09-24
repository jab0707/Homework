function H_im = CS6640_Harris(im)
% CS6640_Harris - compute Harris operator at each pixel
% On input:
%   im (MxN array): graylevel image
% On output:
%   H_im (MxN array): Harris value (normalized)
% Call:
%   H = CS6640_Harris(im);
% Author:
%   Jake Bergquist
%   UU
%   Fall 2018

%Harris operator 
%H = [ dxx(r,c), dxy(r,c); dyx(r,c), dyy(r,c)]
%Now compute the Harris value at this pixel: det(H) - 0.05*trace(H)^2
if size(im,3) == 1%If we have a rgb, make it gray
    grayIm = im;
else
    grayIm = rgb2gray(im);
end
%Compute the hessian
grayIm = double(grayIm);
[dx,dy] = gradient(grayIm);
[dxx,dxy] = gradient(dx);
[dyx,dyy] = gradient(dy);

H_im = grayIm;%Initilize this to be the same size
for r = 1:size(H_im,1)%For eahc row and column cimpute the Harris value
    for c = 1:size(H_im,2)
        H =[ dxx(r,c), dxy(r,c); dyx(r,c), dyy(r,c)];
        H_im(r,c) = det(H) - 0.05*trace(H)^2;
    end
end

%Normalize
H_im = H_im - min(H_im(:));
H_im = H_im/max(H_im(:));%Normalize to be from 0 to 1
H_im = H_im *255;%Now normalize to be from 0 to 255 so that it makes sense to plot as an image
H_im = uint8(H_im);
end