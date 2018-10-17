function T = CS6640_FFT_angular(im)
% CS6640_FFT_angular - compute FFT angular texture parameters
% On input:
%   im (MxN array): input image
% On output:
%   T (M*Nx8 array): texture parameters
%   each texture parameter is a column vector in T
% Call:
%   T = CS6640_FFT_angular(im);
% Author:
%   Jake Bergquist
%   UU
%   Fall 2018
%
L = 11;
[q1,q2,q3,q4,q5,q6,q7,q8] = calculate_quadrant_indicies(L);


%Step 1 we have to pad our image to allow the LxL window to pass over every
%ixel, by padding by two we can center the starting pixel on the edges of
%the images
%Pad with zeros
startPos = ceil(L/2);
[sz1,sz2] = size(im);
padIm = uint8(zeros(sz1+L-1,sz2+L-1));
padIm(startPos:startPos-1+sz1,startPos:startPos-1+sz2) = im;
%Initilize the T matrix
T = zeros(sz1*sz2,8);


for r = startPos:sz1+startPos-1%For each row
    for c = startPos:sz2+startPos-1%For each column
        window = padIm(r-startPos+1:r+startPos-1,c-startPos+1:c+startPos-1);%Grab the LxL window
        ftWindow = fft(window);%FFT it
        pwrSpect = zeros(L,L);
        for ind = 1:L*L%Get the powerspectrum for this window
            pwrSpect(ind) = ftWindow(ind) * conj(ftWindow(ind));
        end
        features = zeros(8,1);
        features(1) = sum(pwrSpect(q1));
        features(2) = sum(pwrSpect(q2));
        features(3) = sum(pwrSpect(q3));
        features(4) = sum(pwrSpect(q4));
        features(5) = sum(pwrSpect(q5));
        features(6) = sum(pwrSpect(q6));
        features(7) = sum(pwrSpect(q7));
        features(8) = sum(pwrSpect(q8));
        
        index = sub2ind([sz1,sz2],r-startPos+1,c-startPos+1);
        T(index,:) = features;%Record that spectrum as the feature vector
    end
end




end


function [q1,q2,q3,q4,q5,q6,q7,q8] = calculate_quadrant_indicies(L)
%Calculates the indicies for the 8 quadrands of a L x L square matrix
%Each quarant is separated by 45 degrees. Overlap (such as the center) go
%to each quadrant they overlap with. Assumes odd L

boxSz = ceil(L/2);

indMatrix = 1:L*L;
indMatrix = reshape(indMatrix,[L,L]);

qMatrix1 = fliplr(eye(boxSz));
for r = 1:boxSz
    for c = 1:boxSz
        if c+r > boxSz
            qMatrix1(r,c) = qMatrix1(r,c) + 1;
        end
    end
end
qMatrix2 = abs(qMatrix1 - 1);
qMatrix3 = fliplr(qMatrix2);
qMatrix1(qMatrix1 > 1) = 1;
qMatrix4 = fliplr(qMatrix1);

m = zeros(L,L);
m1 = m;m1(1:boxSz,boxSz:end) = qMatrix1;%0-45
m2 = m;m2(1:boxSz,boxSz:end) = qMatrix2;%45-90
m3 = m;m3(1:boxSz,1:boxSz) = qMatrix3;%90-135
m4 = m;m4(1:boxSz,1:boxSz) = qMatrix4;%135-180
m5 = m;m5(boxSz:end,1:boxSz) = qMatrix2;%180-125
m6 = m;m6(boxSz:end,1:boxSz) = qMatrix1;%125-270
m7 = m;m7(boxSz:end,boxSz:end) = qMatrix4;%270-315
m8 = m;m8(boxSz:end,boxSz:end) = qMatrix3;%315-360

q1 = indMatrix.*m1;
q1 = q1(:);
q1(q1 == 0) = [];
q2 = indMatrix.*m2;
q2 = q2(:);
q2(q2 == 0) = [];
q3 = indMatrix.*m3;
q3 = q3(:);
q3(q3 == 0) = [];
q4 = indMatrix.*m4;
q4 = q4(:);
q4(q4 == 0) = [];
q5 = indMatrix.*m5;
q5 = q5(:);
q5(q5 == 0) = [];
q6 = indMatrix.*m6;
q6 = q6(:);
q6(q6 == 0) = [];
q7 = indMatrix.*m7;
q7 = q7(:);
q7(q7 == 0) = [];
q8 = indMatrix.*m8;
q8 = q8(:);
q8(q8 == 0) = [];



end