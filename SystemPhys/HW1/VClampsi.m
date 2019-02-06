function [I,g,m,h,minf,hinf,taum,tauh] = VClampsi(V,t)
% VClampsi    Slow inward current under voltage clamp
%   [I,g,m,h,minf,hinf,taum,tauh] = Isi(V,t)
%    I   slow inward current
%    g   conductance 
% minf   steady-state activation variable
% taum   time constant of m gate
%    m   activation gate
%    h   inactivation gate
%    V   membrane potential (mV)
%    t   time (msec)
% Reference: QN:Luo91

%%global Ca_i;
global Ca_i Ca_o;
Gsi_ = 0.09;

m0 = 0;
h0 = 1;

numTimeStep = length(V);

for i=1:numTimeStep
  am(i) = 0.095*exp(-0.01*(V(i)-5))/(1+exp(-0.072*(V(i)-5)));
  bm(i) = 0.07*exp(-0.017*(V(i)+44))/(1+exp(0.05*(V(i)+44))); 
  minf(i) = am(i)/(am(i)+bm(i));
  taum(i) = 1/(am(i)+bm(i));
  m(i) = minf(i) - (minf(i)-m0).*exp(-t(i)/taum(i));
  
  ah(i) = 0.012*exp(-0.008*(V(i)+28))/(1+exp(0.15*(V(i)+28)));
  bh(i) = 0.0065*exp(-0.02*(V(i)+30))/(1+exp(-0.2*(V(i)+30))); 
  hinf(i) = ah(i)/(ah(i)+bh(i));
  tauh(i) = 1/(ah(i)+bh(i));
  h(i) = hinf(i) - (hinf(i)-h0).*exp(-t(i)/tauh(i));

  g(i) = Gsi_*m(i)*h(i); 
%%  Esi = 7.7 - 13.0287*log(Ca_i);
  Esi = 7.7 - 13.0287*log(Ca_i/Ca_o);
  I(i) = g(i)*(V(i)-Esi);
end