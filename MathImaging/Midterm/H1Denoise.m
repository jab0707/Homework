close all;
clear all;

s = 128;

I = zeros(s,s);
I(s/4:s/4+s/2,s/4:s/4+s/2) = 1;

D = I + 0.25*randn(size(I));
imagesc(D);
figure(1);
%Set up the filter for the inv Lap
L = zeros(s,s);
for u = 0:s-1
      for v = 0:s-1
          L(u+1,v+1) = -2*(cos(2*pi*u/s)+cos(2*pi*v/s))...
	   +4;
      end
end

sigma = sqrt(0.25);
lambda = 10;

Df = fftn(D);

IestF = Df./(L.*(lambda/sigma)+1);

Iest = real(ifftn(IestF));

figure(2); imagesc(Iest)




