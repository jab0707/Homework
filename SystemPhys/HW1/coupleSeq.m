clear, clf;
Constant;

Ggap = 1000*300*50*10^(-12)/(0.767*10^(-4));   % longitudinal
[t,VA,iNaA,isiA,iKA,iK1A,iKpA,ibA,VB,iNaB,isiB,iKB,iK1B,iKpB,ibB] ...
    = Coupling(450,-30,20,22,5.4,0,0,0,5.4);
subplot(3,1,1),
plot(t,VA,'r-',t,VB,'b-');
ylabel('V (mV)');
xlabel('T (ms)');
axis([0 450 -100 100]);

dVA = diff(VA);
dt = diff(t);
dVAdt = dVA./dt;
[dVAdtmax, dVAdtmaxI] = max(dVAdt);

dVB = diff(VB);
dt = diff(t);
dVBdt = dVB./dt;
[dVBdtmBx, dVBdtmaxI] = max(dVBdt);
Marker = sprintf('%.1f',t(dVBdtmaxI)-t(dVAdtmaxI));
text(t(dVBdtmaxI),80,Marker);
line([t(dVBdtmaxI) t(dVBdtmaxI)],[70,75]);
text(300,20,'300');

Ggap = 1000*150*50*10^(-12)/(0.767*10^(-4));   % longitudinal
[t,VA,iNaA,isiA,iKA,iK1A,iKpA,ibA,VB,iNaB,isiB,iKB,iK1B,iKpB,ibB] ...
    = Coupling(450,-30,20,22,5.4,0,0,0,5.4);
subplot(3,1,2),
plot(t,VA,'r-',t,VB,'b-');
ylabel('V (mV)');
xlabel('T (ms)');
axis([0 450 -100 100]);

dVA = diff(VA);
dt = diff(t);
dVAdt = dVA./dt;
[dVAdtmax, dVAdtmaxI] = max(dVAdt);

dVB = diff(VB);
dt = diff(t);
dVBdt = dVB./dt;
[dVBdtmBx, dVBdtmaxI] = max(dVBdt);
Marker = sprintf('%.1f',t(dVBdtmaxI)-t(dVAdtmaxI));
text(t(dVBdtmaxI),80,Marker);
line([t(dVBdtmaxI) t(dVBdtmaxI)],[70,75]);
text(300,20,'150');

Ggap = 1000*100*50*10^(-12)/(0.767*10^(-4));   % longitudinal
[t,VA,iNaA,isiA,iKA,iK1A,iKpA,ibA,VB,iNaB,isiB,iKB,iK1B,iKpB,ibB] ...
    = Coupling(450,-30,20,22,5.4,0,0,0,5.4);
subplot(3,1,3),
plot(t,VA,'r-',t,VB,'b-');
ylabel('V (mV)');
xlabel('T (ms)');
axis([0 450 -100 100]);

dVA = diff(VA);
dt = diff(t);
dVAdt = dVA./dt;
[dVAdtmax, dVAdtmaxI] = max(dVAdt);

dVB = diff(VB);
dt = diff(t);
dVBdt = dVB./dt;
[dVBdtmBx, dVBdtmaxI] = max(dVBdt);
Marker = sprintf('%.1f',t(dVBdtmaxI)-t(dVAdtmaxI));
text(t(dVBdtmaxI),80,Marker);
line([t(dVBdtmaxI) t(dVBdtmaxI)],[70,75]);
text(300,20,'100');
