function T = CS6640_Laws(im)
% CS6640_Laws - compute texture parameters
% On input:
%    im (MxN array): input image
% On output:
%    T (M*Nx10 array): texture parameters
%      each texture parameter is a column vector in T
% Call:
%   T = CS6640_Laws(im);
% Author:
%    Jake Bergquist
%    UU
%    Fall 2018

%Laws matricies
L7 = [1 6 15 20 15 6 1];
E7 = [-1 -4 -5 0 5 4 1];
S7 = [-1 -2 1 4 1 -2 -1];
W7 = [-1 0 3 0 -3 0 1];
R7 = [1 -2 -1 4 -1 -2 1];
O7 = [-1 6 -15 20 -15 6 -1];

%{
fileters to generate

i. L7,L7
ii. L7,E7
iii. L7,S7
iv. L7,W7
v. L7,R7
vi. L7,O7
vii. E7,E7
viii. W7,R7
ix. W7, O7
x. mean
%}

%Generate the filters via multiplying
f1 = L7' * L7;
f2 = L7' * E7;
f3 = L7' * S7;
f4 = L7' * W7;
f5 = L7' * R7;
f6 = L7' * O7;
f7 = E7' * E7;
f8 = W7' * R7;
f9 = W7' * O7;
f10 = fspecial('average',7);%make an averaging filter to go with these
filters = {f1,f2,f3,f4,f5,f6,f7,f8,f9,f10};
origSz1 = size(im,1);
origSz2 = size(im,2);
grayIm = rgb2gray(im);
T = zeros(origSz1*origSz2,10);
for filt = 1:10%For each filter, conv2 over the image, trip back to size, 
               %mean filter, trim, and store in texture
   convIm = conv2(grayIm,filters{filt});
   convIm = abs(convIm(4:end-3,4:end-3));
   convIm = conv2(convIm,filters{10});
   convIm = abs(convIm(4:end-3,4:end-3));
   T(:,filt) = convIm(:);
end
end