function T = CS6640_FFT_radial(im)
% CS6640_FFT_radial - compute FFT radial texture parameters
% On input:
%   im (MxN array): input image
% On output:
%   T (M*Nx10 array): texture parameters
%   each texture parameter is a column vector in T
% Call:
%   T = CS6640_FFT_radial(im);
%   Author:
%   Jake Bergquist
%   UU
%   Fall 2018
%



%I could calculate the ring indicies in a smart way but it is
%computationally more efficient to just initilize them here and reference
%them]
a = 1:19*19;
a = reshape(a,19,19);
r1 = 181;
r2 = a(9:11,9:11);
r3 = a(8:12,8:12);
r4 = a(7:13,7:13);
r5 = a(6:14,6:14);
r6 = a(5:15,5:15);
r7 = a(4:16,4:16);
r8 = a(3:17,3:17);
r9 = a(2:18,2:18);
r10 = a;%Now we have squares,remove the previous square from each for rings
r10 = setdiff(r10,r9);
r9 = setdiff(r9,r8);
r8 = setdiff(r8,r7);
r7 = setdiff(r7,r6);
r6 = setdiff(r6,r5);
r5 = setdiff(r5,r4);
r4 = setdiff(r4,r3);
r3 = setdiff(r3,r2);
r2 = setdiff(r2,r1);

%Step 1 we have to pad our image to allow the 19*19 window to pass over 
%every ixel, by padding by two we can center the starting pixel on the 
%edges of the images
%Pad with zeros

[sz1,sz2] = size(im);
padIm = uint8(zeros(sz1+18,sz2+18));
padIm(10:9+sz1,10:9+sz2) = im;
%Initilize the T matrix
T = zeros(sz1*sz2,10);
for r = 10:sz1+9%For each row
    for c = 10:sz2+9%For each column
        window = padIm(r-9:r+9,c-9:c+9);%Grab the 19x19 window
        ftWindow = fft(window);%FFT it
        pwrSpect = zeros(19,19);
        for ind = 1:19*19%Get the powerspectrum for this window
            pwrSpect(ind) = ftWindow(ind) * conj(ftWindow(ind));
        end
        features = zeros(10,1);
        features(1) = pwrSpect(r1);
        features(2) = sum(pwrSpect(r2));
        features(3) = sum(pwrSpect(r3));
        features(4) = sum(pwrSpect(r4));
        features(5) = sum(pwrSpect(r5));
        features(6) = sum(pwrSpect(r6));
        features(7) = sum(pwrSpect(r7));
        features(8) = sum(pwrSpect(r8));
        features(9) = sum(pwrSpect(r9));
        features(10) = sum(pwrSpect(r10));
        index = sub2ind([sz1,sz2],r-9,c-9);
        T(index,:) = features;%Record that spectrum as the feature vector
    end
end


end