function [C,V] = CS6640_GC(im)
% CS6640_GC - Graph Cut segmentation
%   On input:
%       im (MxN array): input image
%   On output:
%       C (MxN array): binary classification
%       V (M*Nx6 array): eigenvectors of similarity matrix
%   Call:
%       [C,V] = CS6640_GC(im);
%   Author:
%       Jake Bergquist
%       UU
%       Fall 2018
%

pixNum = length(im(:));

simMatrix = zeros(pixNum,pixNum);

for ind1 = 1:pixNum
    for ind2 = 1:pixNum
        simMatrix(ind2,ind1) = (exp(-abs(double(im(ind1))-double(im(ind2)))));
        
    end
end

[V,d] = eigs(simMatrix);
gIdx = kmeans(V(:,1),2);
C = reshape(gIdx,size(im));

end