function [I,g,mm,hh] = Isi(V,th,m,h)
% Isi_step    the slow inward current
%
%   [I,g,mm,hh] = Isi(V,th,m,h)
%
%        I   current slow inward current
%        g   current conductance 
%    mm,hh   updated gate variable for next time step
%        V   current membrane potential (mV)
%       th   time step (msec)
%      m,h   current values for gate vaiables m and h

%%global Ca_i;
global Ca_i Ca_o;
Gsi_ = 0.09;

%%Esi = 7.7 - 13.0287*log(Ca_i);
Esi = 7.7 - 13.0287*log(Ca_i/Ca_o);
g = Gsi_*m*h; 
I = g*(V-Esi);

am = 0.095*exp(-0.01*(V-5))/(1+exp(-0.072*(V-5)));
bm = 0.07*exp(-0.017*(V+44))/(1+exp(0.05*(V+44))); 
minf = am/(am+bm);
taum = 1/(am+bm);
  
ah = 0.012*exp(-0.008*(V+28))/(1+exp(0.15*(V+28)));
bh = 0.0065*exp(-0.02*(V+30))/(1+exp(-0.2*(V+30))); 
hinf = ah/(ah+bh);
tauh = 1/(ah+bh);

%dm = (minf-m)/taum;
%dh = (hinf-h)/tauh;
%mm = m + dm*th;
%hh = h + dh*th;

mm = minf - (minf-m)*exp(-th/taum);
hh = hinf - (hinf-h)*exp(-th/tauh);

dCa_i = -10^(-4)*I + 0.07*(10^(-4)-Ca_i);
Ca_i = Ca_i + dCa_i*th;
