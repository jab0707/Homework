function [xp,yp] = CS6640_transform2D(x,y,q)
% CS6640_transform2D - produce transformed points
% CS6640_transform2D - produce transformed points
% from given points and quadratic coeffients
% On input:
%   x (float): x value
%   y (float): y value
%   q (1x12 vector): quadratic coefficients
% On output:
%   xp (float): x value of transformed point
%   yp (float): y value of transformed point
% Call:
%   [xp,yp] = CS6640_transform2D(3,3,q);
% Author:
%   Jake Bergquist
%   UU
%   Fall 2018
%

xp = [1,x,y,x*y,x^2,y^2,0,0,0,0,0,0] * q;
yp = [0,0,0,0,0,0,1,x,y,x*y,x^2,y^2] * q;

end