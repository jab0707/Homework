function X = CS6640_FFT_shape(Z,w)
% CS6640_FFT_shape - compute Fourier shape descriptors for a curve
% On input:
%   Z (Nx2 array): input curve (should be closed)
%   w (int): distance along curve to determine angles
% On output:
%   X ((N/2-1)x1 vector): the Fourier coefficients for the curve
% Call:
%   X = CS6640_FFT_shape(curve,2);
% Author:
%   Jake Bergquist
%   UU
%   Fall 2018
%

startingTheta = 0;
steps = floor(size(Z,1)/w);
thetas = zeros(1,steps);
phis= thetas;
psis = thetas;
thetas(1) = startingTheta;
for step = 1:steps-1
    stepToIndex = step+w;
    if (stepToIndex > size(Z,1))
        stepToIndex = stepToIndex - size(Z,1);
    end
    thetas(step+1) = atan2(Z(stepToIndex,2) - Z(step,2), Z(stepToIndex,1) - Z(step));
    phis(step+1) = wrapTo2Pi(thetas(step+1)-thetas(step));
    psis(step+1) = mod( phis(step+1) + ((2*pi)/steps)*step  ,pi);
        
end
psis(1) = mod( phis(1) + ((2*pi)/steps)  ,pi);


fftpsis = fft(psis);

X = fftpsis(2:(floor(steps/2)));

for ind = 1:length(X)
    X(ind) = X(ind) * conj(X(ind));
end

end