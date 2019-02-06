function [I,gK,minf,taum,m,h] = VClampK(V,t)
% VClampK    Time-dependent potassium current (IK) under voltage clamp
%   [I,minf,taum,m,h] = VClampK(V,t)
%   I   potassium current
% minf   steady-state activation variable
% taum   time constant of m gate
%    m   activation gate
%    h   inactivation gate
%    V   membrane potential (mV)
%    t   time (msec)
% Reference: QN:Luo91
% Note: the formulation of IK follows Luo-Rudy 91's model, it assumes absense 
%  of Ca channels, which was included in Luo-Rudy 94's model (its
%  formulation are included as comments.

% Constants
global R T F K_o K_i Na_o Na_i PNa_K;
GK_ = 0.282*sqrt(K_o/5.4);         % millisiemens/uF
EK = (R*T/F)*log((K_o+PNa_K*Na_o)/(K_i+PNa_K*Na_i));        % mV

m0 = 0;
numTimeStep = length(V);

for i=1:numTimeStep
%  am(i) = 0.0005*exp(0.083*(V(i)+50))/(1+exp(0.057*(V(i)+50)));
%  bm(i) = 0.0013*exp(-0.06*(V(i)+20))/(1+exp(-0.04*(V(i)+20))); 
 
  am(i) = 7.19*10^(-5)*(V(i)+30)/(1-exp(-0.148*(V(i)+30)));
  bm(i) = 1.31*10^(-4)*(V(i)+30)/(-1+exp(0.0687*(V(i)+30))); 

  minf(i) = am(i)/(am(i)+bm(i));
  taum(i) = 1/(am(i)+bm(i));
  m(i) = minf(i) - (minf(i)-m0).*exp(-t(i)/taum(i));

  h(i) = 1/(1+exp((V(i)-56.26)/32.1));
  
  gK(i) = GK_*m(i)*m(i)*h(i); 
  I(i) = gK(i)*(V(i)-EK);
end
