% Filename: Coupling_demo.m
% Author: Quan Ni and Rob MacLeod
% 
% Contains a sample of example for running the cardiac cell coupling
% simulation code.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear, clf;
Constant;

%Ggap = 1000*50*340*10^(-12)/(0.767*10^(-4));   % failure case 1
%Ggap = 1000*50*70*10^(-12)/(0.767*10^(-4));   % good coupling with delay
Ggap = 1000*50*120*10^(-12)/(0.767*10^(-4));   % good coupling with delay
%Ggap = 1000*50*340*10^(-12)/(0.767*10^(-4));   % failure unless IstA increased
%Ggap = 1000*50*40*10^(-12)/(0.767*10^(-4));   % failure case 2

TD=450;
IstA = -30;
tonA = 20;
toffA = 22;
KoA = 5.4;
IstB = 0;
tonB = 0;
toffB = 0;
KoB = 5.4;

[t,VA,iNaA,isiA,iKA,iK1A,iKpA,ibA,VB,iNaB,isiB,iKB,iK1B,iKpB,ibB] ...
    = Coupling(TD,IstA,tonA,toffA,KoA,IstB,tonB,toffB,KoB);

figure(1),
subplot(3,1,1)
plot(t,VA,'r-',t,VB,'b-');
axis([0 TD -100 100]);
ylabel('Vm(mV)');
subplot(3, 1, 2);
plot(t, (VA-VB)*Ggap);
axis([0 TD -5 10]);
ylabel('Igap(uA)');
xlabel('Time (ms)');
subplot(3,1,3);
plot(t, iNaA,'r-', t, iNaB,'b-');
axis([0 TD -400 0]);
ylabel('INaA and INaB(uA)');
xlabel('Time (ms)');

