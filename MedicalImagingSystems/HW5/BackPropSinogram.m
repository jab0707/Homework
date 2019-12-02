function [Btheta] = BackPropSinogram(Rtheta,theta,interp)
%BACKPROPSINOGRAM Summary of this function goes here
%   Detailed explanation goes here

%Assume image center is at the origin
%Assume Rtheta has an odd number of measurements

%Handle the easy/edge cases first (where sin(theta) or cos(theta) would be
%zero

    imageLim = floor(length(Rtheta)/2);
    [X,Y] = meshgrid([-imageLim:imageLim],[imageLim:-1:-imageLim]);
    RotCoords1 = Y.*sin(theta) + X.*cos(theta);
    RotCoords2 = Y.*sin(pi/2-theta) + X.*cos(pi/2-theta);
    Val = repmat(Rtheta,1,size(X,2));
    sf = fit([X(:),Y(:)],Val(:),interp);
    Btheta = sf(RotCoords2,RotCoords1);
    Btheta(isnan(Btheta)) = 0;
    
    %Below is the minimum line version of above
    %I chose to go with what is above because it is easier to read
%    [X,Y] = meshgrid([-floor(length(Rtheta)/2):floor(length(Rtheta)/2)],[floor(length(Rtheta)/2):-1:-floor(length(Rtheta)/2)]);
%    sf = fit([X(:),Y(:)],reshape(repmat(Rtheta,1,size(X,2)),[length(Rtheta)*size(X,2),1]),interp);
%    Btheta = sf(Y.*sin(pi/2-theta) + X.*cos(pi/2-theta),Y.*sin(theta) + X.*cos(theta));
%    Btheta(isnan(Btheta)) = 0;
end

