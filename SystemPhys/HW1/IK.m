function [I,gK,mm] = IK(V,th,m)
% IK    Time-dependent potassium current
%
%   [I,gK,mm,hh] = IK(V,th,m)
%
%        I   current time-dependent potassium current
%       gK   current conductance 
%       mm   updated gate variable for next time step
%        V   current membrane potential (mV)
%       th   time step (msec)
%        m   current values for gate vaiables m

% $Id: IK.m,v 1.1 1997/06/27 17:27:17 quan Exp $

global R T F K_o K_i Na_o Na_i PNa_K;
GK_ = 0.282*sqrt(K_o/5.4);         % millisiemens/uF
EK = (R*T/F)*log((K_o+PNa_K*Na_o)/(K_i+PNa_K*Na_i));        % mV

if V > -100
  if ((V+77)<10^(-6))      % singularity
    h = 0.7;
  else
    h = 2.837*(exp(0.04*(V+77))-1)/((V+77)*exp(0.04*(V+35)));
  end
else
  h = 1;
end

gK = GK_*m*h; 
I = gK*(V-EK);

am = 0.0005*exp(0.083*(V+50))/(1+exp(0.057*(V+50)));
bm = 0.0013*exp(-0.06*(V+20))/(1+exp(-0.04*(V+20))); 
 
minf = am/(am+bm);
taum = 1/(am+bm);

%dm = (minf-m)/taum;
%mm = m + dm*th;

mm = minf - (minf-m)*exp(-th/taum);
