function [t,VA,iNaA,isiA,iKA,iK1A,iKpA,ibA,VB,iNaB,isiB,iKB,iK1B,iKpB,ibB] ...
    = Coupling(TD,IstA,tonA,toffA,KoA,IstB,tonB,toffB,KoB)
% Coupling   Coupling of two cells by electrotonic interaction
%
%   [t,VA,iNaA,isiA,iKA,iK1A,iKpA,ibA,VB,iNaB,isiB,iKB,iK1B,iKpB,ibB] ...
%       = Coupling(TD,IstA,tonA,toffA,KoA,IstB,tonB,toffB,KoB)
%
%    t   time variable
%   VA   membrane potantial of the first cell (A) (mV)
%  INaA,IsiA,IKA,IK1A,IKpA,IbA   currents of the first cells (A) (uA/cm^2)
%   VB   membrane potantial of the second cell (B) (mV)
%  INaB,IsiB,IKB,IK1B,IKpB,IbB   currents of the second cells (B) (uA/cm^2)
%    TD   duration of the simulation  (ms);
%  IstA   stimulus current for cell A  (uA/cm^2);
%  tonA   onset of the stimulus of cell A (ms);
% toffA   offset of the stimulus current of cell A (ms);
%   KoA   extracellular concentration of cell A (mM)
%  IstB   stimulus current for cell B  (uA/cm^2);
%  tonB   onset of the stimulus of cell B (ms);
% toffB   offset of the stimulus current of cell B (ms);
%   KoB   extracellular concentration of cell B (mM)

global K_o Vrest Cm Ggap;

TSmin = 0.1;          %  minimum time step;
TSmax = 1;            %  maximum time step;
dVmax = 5;            %  maximum dV 

% initial value at rest
% % Physic constants
% F = 96.5;                   % Faraday constant, coulombs/mmol
% R = 8.314;                  % gas constant, J/K
% T = 273+37;                 % absolute temperature, K 
% % Cell constant
% PK = 1.66*10^(-6);                 % permability of K 
% PNa_K = 0.01833;                   % permability ratio of Na to K
% PCa_K = 0.9;                  %%%%%% need to be varified
% Cm = 1;                            % membrane capacitance, uF/cm^2;
% K_i = 145;                  % mmol/L
% Na_o = 140;                 % mmol/L
% Na_i = 10;                  % mmol/L

% Cell A
K_o = KoA;
Vrest = -84;
[It,gt,mt,ht,jt,mNaA,hNaA,jNaA,taumt,tauht,taujt] = VClampNa(Vrest,0);
[It,gt,mt,ht,msiA,hsiA,taumt,tauht] = VClampsi(Vrest,0);
[It,gt,mKA,taumt,mt,ht] = VClampK(Vrest,0);
VA(1) = Vrest;

% Cell B
K_o = KoB;
%Vrest = -84;
Vrest = -78.2;
%Vrest = (R*T/F)*log((K_o + PNa_K*Na_o)/(K_i+PNa_K*Na_i));  % mV
fprintf(' Vrest is %f\n', Vrest);
[It,gt,mt,ht,jt,mNaB,hNaB,jNaB,taumt,tauht,taujt] = VClampNa(Vrest,0);
[It,gt,mt,ht,msiB,hsiB,taumt,tauht] = VClampsi(Vrest,0);
[It,gt,mKB,taumt,mt,ht] = VClampK(Vrest,0);
VB(1) = Vrest;

t(1) = 0;
th = TSmin;             % step size
i = 1;

while (t(i) < TD)
  if (t(i) > tonA & t(i) < toffA)
    th = TSmin;
    IdA = IstA;
  else 
    IdA = 0;
  end
  if (t(i) > tonB & t(i) < toffB)
    th = TSmin;
    IdB = IstB;
  else 
    IdB = 0;
  end
  
  K_o = KoA;
  [iNaA(i),gNaA(i),mNaA,hNaA,jNaA] = INa(VA(i),th,mNaA,hNaA,jNaA);
  [isiA(i),gsiA(i),msiA,hsiA] = Isi(VA(i),th,msiA,hsiA);
  [iKA(i),gKA(i),mKA] = IK(VA(i),th,mKA);
  [iK1A(i),gK1A(i),ht,tauht] = IK1(VA(i));
  [iKpA(i),gKpA(i)] = IKp(VA(i));
  [ibA(i),gbA(i)] = Ib(VA(i));

  K_o = KoB;
  [iNaB(i),gNaB(i),mNaB,hNaB,jNaB] = INa(VB(i),th,mNaB,hNaB,jNaB);
  [isiB(i),gsiB(i),msiB,hsiB] = Isi(VB(i),th,msiB,hsiB);
  [iKB(i),gKB(i),mKB] = IK(VB(i),th,mKB);
  [iK1B(i),gK1B(i),ht,tauht] = IK1(VB(i));
  [iKpB(i),gKpB(i)] = IKp(VB(i));
  [ibB(i),gbB(i)] = Ib(VB(i));

  Igap = Ggap*(VA(i)-VB(i));
  IA = IdA+iNaA(i)+isiA(i)+iKA(i)+iK1A(i)+iKpA(i)+ibA(i)+Igap;
  dVA = -IA/Cm;

  IB = IdB+iNaB(i)+isiB(i)+iKB(i)+iK1B(i)+iKpB(i)+ibB(i)-Igap; 
  dVB = -IB/Cm;
%  dVB = -IB/(1.5*Cm);

  VA(i+1) = VA(i) + dVA*th;
  VB(i+1) = VB(i) + dVB*th;
  t(i+1) = t(i) + th;
  i = i+1;
  
  th = TSmin*dVmax/abs(dVA);
  if th > TSmax
    th = TSmax;
  elseif th < TSmin
    th = TSmin;
  end
end
VA(i) = [];
VB(i) = [];
t(i) = [];
