clear, clf;
Constant;

i = 1;
for numGgap = 300:5:400
  Ggap = 1000*numGgap*50*10^(-12)/(0.767*10^(-4));   % longitudinal
  [t,VA,iNaA,isiA,iKA,iK1A,iKpA,ibA,VB,iNaB,isiB,iKB,iK1B,iKpB,ibB] ...
      = Coupling(450,-30,20,22,5.4,0,0,0,5.4);
  
  dVA = diff(VA);
  dt = diff(t);
  dVAdt = dVA./dt;
  [dVAdtmaxx, dVAdtmaxI] = max(dVAdt);
  
  dVB = diff(VB);
  dt = diff(t);
  dVBdt = dVB./dt;
  [dVBdtmaxx, dVBdtmaxI] = max(dVBdt);
  
  GGAP(i) = Ggap;
  Velocity(i)  = 0.1/(t(dVBdtmaxI)-t(dVAdtmaxI));
  dVAdtmax(i) = dVAdtmaxx;
  dVBdtmax(i) = dVBdtmaxx;
  i = i+1;
end;
subplot(2,1,1),
plot(300:5:400,Velocity,'*');
ylabel('Velocity (m/s)');
Ggap = 1000*50*340*10^(-12)/(0.767*10^(-4));   % longitudinal
xlabel('Number of Gap Junctions');

[t,VA,iNaA,isiA,iKA,iK1A,iKpA,ibA,VB,iNaB,isiB,iKB,iK1B,iKpB,ibB] ...
    = Coupling(450,-30,20,22,5.4,0,0,0,5.4);

subplot(2,1,2)
plot(t,VA,'r-',t,VB,'b-');
ylabel('V(mV)');
xlabel('Time (ms)');

% subplot(2,1,2),
%plot(120:1:140,dVAdtmax,'r*',120:1:140,dVBdtmax,'yo');
% ylabel('(dV/dt)max (m/s)');
