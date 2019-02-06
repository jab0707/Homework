function [I,gb] = Ib(V)
% Ib    Background current
%   I = Ib(V)
%    I   current
%   gb   conductance;
%    V   membrane potential (mV)

Gb_ = 0.03921;
Eb = -59.87;

numTimeStep = length(V);

for i=1:numTimeStep
  gb(i) = Gb_;
  I(i) = Gb_*(V(i)-Eb);
end
