function [phi,tr] = CS6640_level_set(im,max_iter,del_t,r0,c0)
% CS6640_level_set - level set of image
% On input:
%   im (MxN array): gray level or binary image
%   max_iter (int): maximum number of iterations
%   del_t (float): time step
%   r0 (int): row center of circular level set function
%   c0 (int): column center of circular level set function
% On output:
%   phi (MxN array): final phi array
%   tr (qx1 vector): sum(sum(abs(phi_(n+1) - phi_n)))
% Call:
%   [phi,tr] = CS6640_level_set(im,300,0.1,25,25);
% Author:
%   Jake Bergquist
%   UU
%   Fall 2018
%
radius = -3;
[gradXIm,gradYIm] = gradient(double(im));
gradIm = sqrt(gradXIm.^2+gradYIm.^2);
fIm = exp(-gradIm);
[M,N] = size(im);
pis = zeros(size(im));
for r = 1:M
    for c = 1:N
        pis(r,c) = sqrt((r-r0)^2+(c-c0)^2)+radius;
    end
end


tr = zeros(max_iter,1);
for iter = 1:max_iter
    oldPis = pis;
    for r = 2:M-1%avoid edges
        for c = 2:N-1
            f = fIm(r,c);
            dxp = pis(r+1,c) - pis(r,c);
            dxn = pis(r,c) - pis(r-1,c);
            dyp = pis(r,c+1) - pis(r,c);
            dyn = pis(r,c) - pis(r,c-1);
            grPpos = sqrt(max(dxn,0)^2 + min(dxp,0)^2 + max(dyn,0)^2 + min(dyp,0)^2);
            grPneg = sqrt(max(dxp,0)^2 + min(dxn,0)^2 + max(dyp,0)^2 + min(dyn,0)^2);
            pis(r,c) = pis(r,c) - del_t*(max(f,0)*(grPpos) + min(f,0)*grPneg);
            
        end
    end
    tr(iter) = sum(sum(abs(pis - oldPis)));
    
end
phi = pis;
end