function D = H1Inpaint(D0,M,sigma,lambda,iter)


D0 = uint8(D0.*(abs(M-1)));
D = D0;


s = size(D,1);

I = zeros(s,s);

%Set up the filter for the inv Lap
L = zeros(s,s);
for u = 0:s-1
      for v = 0:s-1
          L(u+1,v+1) = -2*(cos(2*pi*u/s)+cos(2*pi*v/s))...
	   +4;
      end
end

for it = 1:iter
Df = fftn(D);

IestF = Df./(L.*(lambda/sigma)+1);

D = real(ifftn(IestF));

D = uint8(D.*M);
D = D+D0;

end







end

