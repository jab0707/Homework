function [I,gNa,mm,hh,jj] = INa(V,th,m,h,j)
% INa    the fast sodium current in mammalian ventricular cells 
%
%   [I,gNa,mm,hh,jj] = INa(V,th,m,h,j)
%
%          I   current sodium current
%        gNa   current sodium conductance
%   mm,hh,jj   updated gate variables for next time step
%          V   current membrane potential (mV)
%         th   time step(msec)
%      m,h,j   current values for m,h,j
%
% Reference: QN:Luo94a

global R T F Na_o Na_i;
ENa = (R*T/F)*log(Na_o/Na_i);       % Nernst potential of Na, mV
GNa_ = 16;                          % mS/cm^2
%GNa_ = 2;                          % Reduced value mS/cm^2

gNa = GNa_*m^3*h*j;
I = gNa*(V-ENa);

if V >= -40
  ah = 0;
  aj = 0;
  bh = 1/(0.13*(1+exp((V+10.66)/(-11.1))));
  bj = 0.3*exp(-2.535*10^(-7)*V)/(1+exp(-0.1*(V+32)));
else
  ah = 0.135*exp((80+V)/(-6.8));
  aj = (-1.2714*10^5*exp(0.2444*V)-3.474*10^(-5)*exp(-0.04391*V))...
      *(V+37.78)/(1+exp(0.311*(V+79.23)));
  bh = 3.56*exp(0.079*V)+3.1*10^5*exp(0.35*V);
  bj = 0.1212*exp(-0.01052*V)/(1+exp(-0.1378*(V+40.14)));
end

am = 0.32*(V+47.13)/(1-exp(-0.1*(V+47.13)));
bm = 0.08*exp(-V/11); 

minf = am/(am+bm);
hinf = ah/(ah+bh);
jinf = aj/(aj+bj);

taum = 1/(am+bm);
tauh = 1/(ah+bh);
tauj = 1/(aj+bj);

%dm = (minf-m)/taum;                  % Euler's method
%dh = (hinf-h)/tauh;
%dj = (jinf-j)/tauj;
%mm = m + dm*th;
%hh = h + dh*th;
%jj = j + dj*th;

mm = minf - (minf-m)*exp(-th/taum);     % the hybrid method
hh = hinf - (hinf-h)*exp(-th/tauh);
jj = jinf - (jinf-j)*exp(-th/tauj);
