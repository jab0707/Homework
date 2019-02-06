function [I,gNa,m,h,j,minf,hinf,jinf,taum,tauh,tauj] = VClampNa(V,t)
% VClampNa   Fast sodium current under voltage clamp
%   [I,gNa,minf,hinf,jinf,taum,tauh,tauj] = VClampNa(V,t)
%    I   sodium current
%  gNa   sodium conductance
%    m   activation variable
%    h   inactivation variable
%    j   slow inactivation variable
% minf   steady-state activation variable
% hinf   steady-state inactivation variable
% jinf   steady-state slow inactivation variable
% taum   time constant of m gate
% tauh   time constant of h gate
% tauj   time constant of j gate
%    V   membrane potential (mV)
%    t   time (msec)
% Reference: QN:Luo91

% under voltage clamp, a's and b's are constants for each V

global R T F Na_o Na_i;
ENa = (R*T/F)*log(Na_o/Na_i);       % Nernst potential of Na, mV
GNa_ = 16;                               % millisiemens/uF

m0 = 0;
h0 = 1;
j0 = 1;

numTimeStep = length(V);

for i=1:numTimeStep
  if V(i) >= -40
    ah = 0;
    aj = 0;
    bh = 1/(0.13*(1+exp((V(i)+10.66)/(-11.1))));
    bj = 0.3*exp(-2.535*10^(-7)*V(i))/(1+exp(-0.1*(V(i)+32)));
  else
    ah = 0.135*exp((80+V(i))/(-6.8));
    aj = (-1.2714*10^5*exp(0.2444*V(i))-3.474*10^(-5)*exp(-0.04391*V(i)))...
	*(V(i)+37.78)/(1+exp(0.311*(V(i)+79.23)));
    bh = 3.56*exp(0.079*V(i))+3.1*10^5*exp(0.35*V(i));
    bj = 0.1212*exp(-0.01052*V(i))/(1+exp(-0.1378*(V(i)+40.14)));
  end

  am = 0.32*(V(i)+47.13)/(1-exp(-0.1*(V(i)+47.13)));
  bm = 0.08*exp(-V(i)/11); 

  minf(i) = am/(am+bm);
  hinf(i) = ah/(ah+bh);
  jinf(i) = aj/(aj+bj);

  taum(i) = 1/(am+bm);
  tauh(i) = 1/(ah+bh);
  tauj(i) = 1/(aj+bj);

  m(i) = minf(i) - (minf(i)-m0)*exp(-t(i)/taum(i));
  h(i) = hinf(i) - (hinf(i)-h0)*exp(-t(i)/tauh(i));
  j(i) = jinf(i) - (jinf(i)-j0)*exp(-t(i)/tauj(i));
  gNa(i) = GNa_*m(i)^3*h(i)*j(i);
  I(i) = gNa(i)*(V(i)-ENa);
end

