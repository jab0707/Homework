function [I,gK1,hinf,tauh] = IK1(V)
% IK1    Time-independent potassium current
%
%   [I,gK1,hinf,tauh] = IK1(V)
%
%   I   potassium current
% hinf   steady-state activation variable
% tauh   time constant of m gate
%    V   membrane potential (mV)

% $Id: IK1.m,v 1.1 1997/06/27 17:35:22 quan Exp $

global R T F K_o K_i;

GK1_ = 0.6047*sqrt(K_o/5.4);
EK1 = (R*T/F)*log(K_o/K_i);

numTimeStep = length(V);

for i=1:numTimeStep
  ah(i) = 1.02/(1+exp(0.2385*(V(i)-EK1-59.215)));
  bh(i) = (0.49124*exp(0.08032*(V(i)-EK1+5.476)) + ...
      exp(0.06175*(V(i)-EK1-594.31)))/ ...
      (1+exp(-0.5143*(V(i)-EK1+4.753)));

  hinf(i) = ah(i)/(ah(i)+bh(i));
  tauh(i) = 1/(ah(i)+bh(i));

  gK1(i) = GK1_*hinf(i); 
  I(i) = gK1(i)*(V(i)-EK1);
end
