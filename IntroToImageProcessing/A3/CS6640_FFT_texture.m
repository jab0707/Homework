function T = CS6640_FFT_texture(im)
% CS6640_FFT_texture - compute FFT texture parameters
% On input:
%   im (MxN array): input image
% On output:
%   T (M*Nx25 array): texture parameters
%   each texture parameter is a column vector in T
% Call:
%   T = CS6640_FFT_texture(im);
% Author:
% 	Jake Bergquist
%   UU
%   Fall 2018


%Step 1 we have to pad our image to allow the 5x5 window to pass over every
%ixel, by padding by two we can center the starting pixel on the edges of
%the images
%Pad with zeros

[sz1,sz2] = size(im);
padIm = uint8(zeros(sz1+4,sz2+4));
padIm(3:2+sz1,3:2+sz2) = im;
%Initilize the T matrix
T = zeros(sz1*sz2,25);
for r = 3:sz1+2%For each row
    for c = 3:sz2+2%For each column
        window = padIm(r-2:r+2,c-2:c+2);%Grab the 5x5 window
        ftWindow = fft(window);%FFT it
        pwrSpect = zeros(5,5);
        for ind = 1:25%Get the powerspectrum for this window
            pwrSpect(ind) = ftWindow(ind) * conj(ftWindow(ind));
        end
        index = sub2ind([sz1,sz2],r-2,c-2);
        T(index,:) = pwrSpect(:);%Record that spectrum as the feature vector
    end
end

end