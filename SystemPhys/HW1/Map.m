function [t,V,iNa,isi,iK,iK1,iKp,ib,gNa,gsi,gK,gK1,gKp,gb] = ...
    Map(TD,Ist,ton,toff)
% Author: Quan Ni
% 
% Map   Simulation of {M}embrane {a}ction {p}otential
%
% [t,V,INa,Isi,IK,IK1,IKp,Ib,gNa,gsi,gK,gK1,gKp,gb] = Map(TD,Ist,ton,toff)
%    
% Input:
%   TD   duration of the simulation (ms);
%  Ist   stimulus current strength (uA/cm^2);
%  ton   time (after abitrary zero) of onset of the stimulus (ms)
%  toff  time that the stimulus current turns off (ms);
% Output:
%    t   vector for the time variable
%    V   vector for the membrane potantial
%  INa,Isi,IK,IK1,IKp,Ib  vectors for all the currents current (uA/cm^2)
%  gNa,gsi,gK,gK1,gKp,gb  vectors of all the  conductances (mS/cm^2)
%
% $Id: Map.m,v 1.1 1997/06/27 16:35:50 quan Exp $
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global Vrest Cm;

TSmin = .1;          %  minimum time step;
TSmax = 2;            %  maximum time step;
dVmax = 5;            %  maximum dV 

% initial values at rest

[It,gt,mt,ht,jt,mNa,hNa,jNa,taumt,tauht,taujt] = VClampNa(Vrest,0);
[It,gt,mt,ht,msi,hsi,taumt,tauht] = VClampsi(Vrest,0);
[It,gt,mK,taumt,mt,ht] = VClampK(Vrest,0);
V(1) = Vrest;
t(1) = 0;
th = TSmin;             % step size
i = 1;

while (t(i) < TD)
  if (t(i) > ton & t(i) < toff)
    th = TSmin;
    Id = Ist; 
  else 
    Id = 0;
  end
  
  [iNa(i),gNa(i),mNa,hNa,jNa] = INa(V(i),th,mNa,hNa,jNa);
  [isi(i),gsi(i),msi,hsi] = Isi(V(i),th,msi,hsi);
  [iK(i),gK(i),mK] = IK(V(i),th,mK);
  [iK1(i),gK1(i),ht,tauht] = IK1(V(i));
  [iKp(i),gKp(i)] = IKp(V(i));
  [ib(i),gb(i)] = Ib(V(i));
  
  I = Id+iNa(i)+isi(i)+iK(i)+iK1(i)+iKp(i)+ib(i);
  dV = -I/Cm;
  
  V(i+1) = V(i) + dV*th;
  t(i+1) = t(i) + th;
  i = i+1;
  
  th = TSmin*dVmax/abs(dV);
  if th > TSmax
    th = TSmax;
  elseif th < TSmin
    th = TSmin;
  end
end
V(i) = [];
t(i) = [];
