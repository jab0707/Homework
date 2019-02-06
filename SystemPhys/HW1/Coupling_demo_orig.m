clear, clf;
Constant;

% Ggap = 1000*50*340*10^(-12)/(0.767*10^(-4));   % failure

% Ggap = 1000*50*70*10^(-12)/(0.767*10^(-4));   % delay
Ggap = 1000*50*40*10^(-12)/(0.767*10^(-4));   % longitudinal

[t,VA,iNaA,isiA,iKA,iK1A,iKpA,ibA,VB,iNaB,isiB,iKB,iK1B,iKpB,ibB] ...
    = Coupling(450,-30,20,22,5.4,0,0,0,5.4);

figure(1),
subplot(2,1,1)
plot(t,VA,'r-',t,VB,'b-');
ylabel('V(mV)');
subplot(2,1,2)
plot(t,(VA-VB)*Ggap);
ylabel('I(uA)');
xlabel('Time (ms)');

%hold on;

%Vrest = -84;
%K_o = 5.4;
%[t,V,INa,Isi,IK,IK1,IKp,Ib,gNa,gsi,gK,gK1,gKp,gb] = ...
%    Map(450,-30,20,22);
%plot(t,V,'r-');

%Vrest = -78.2;
%K_o = 7;
%[t,V,INa,Isi,IK,IK1,IKp,Ib,gNa,gsi,gK,gK1,gKp,gb] = ...
%    Map(450,-30,20,22);
%plot(t,V,'y:');

%text(345,-70,'7');
%text(350,-63,'7c');
%text(355,-55,'5.4c');
%text(370,-47,'5.4');
%xlabel('Time (ms)');
%ylabel('V (mV)');
%grid;
%print -deps ../text/figure/Coupling.ps
