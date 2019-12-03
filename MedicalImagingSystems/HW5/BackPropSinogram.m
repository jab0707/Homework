function [Btheta] = BackPropSinogram(Rtheta,theta,interp)
%Input: Rtheta: the inogram projection at theta
%       Theta: the angle of the current projection
%       Interp: The interpolation method fromt eh fit function
%               Default: 'linearinterp'
%Assume image center is at the origin
%Assume Rtheta has an odd number of measurements

if ~exist(interp)
    interp = 'linearinter';
end


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
    %Both version produce the same output
%    [X,Y] = meshgrid([-floor(length(Rtheta)/2):floor(length(Rtheta)/2)],[floor(length(Rtheta)/2):-1:-floor(length(Rtheta)/2)]);
%    sf = fit([X(:),Y(:)],reshape(repmat(Rtheta,1,size(X,2)),[length(Rtheta)*size(X,2),1]),interp);
%    Btheta = sf(Y.*sin(pi/2-theta) + X.*cos(pi/2-theta),Y.*sin(theta) + X.*cos(theta));
%    Btheta(isnan(Btheta)) = 0;
end

