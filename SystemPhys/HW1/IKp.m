function [I,gKp] = IKp(V)
% IKp    Plateau potassium current
%   I = IKp(V)
%    I   potassium current
%  gKp   conductance
%    V   membrane potential (mV)
% Reference: QN:Luo94a

global R T F K_o K_i;
GKp_ = 0.0183;
EKp = (R*T/F)*log(K_o/K_i);

numTimeStep = length(V);

for i=1:numTimeStep
  Kp = 1/(1+exp((7.488-V(i))/5.98));
  gKp(i) = GKp_*Kp;
  I(i) = gKp(i)*(V(i)-EKp);
end
