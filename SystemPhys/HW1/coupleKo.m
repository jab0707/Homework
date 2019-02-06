clear, clf;
Constant;

[t,VA,iNaA,isiA,iKA,iK1A,iKpA,ibA,VB,iNaB,isiB,iKB,iK1B,iKpB,ibB] ...
    = Coupling(450,-30,20,22,5.4,-30,20,22,7);

I = Ggap*(VA-VB);
subplot(2,1,2),
plot(t,I),
ylabel('I (uA/cm^2)');
xlabel('Time (ms)');

subplot(2,1,1),
plot(t,VA,'r-',t,VB,'y:');
hold on;

Vrest = -84;
K_o = 5.4;
[t,V,INa,Isi,IK,IK1,IKp,Ib,gNa,gsi,gK,gK1,gKp,gb] = ...
    Map(450,-30,20,22);
plot(t,V,'r-');

Vrest = -78.2;
K_o = 7;
[t,V,INa,Isi,IK,IK1,IKp,Ib,gNa,gsi,gK,gK1,gKp,gb] = ...
    Map(450,-30,20,22);
plot(t,V,'y:');

text(345,-70,'7');
text(350,-63,'7c');
text(355,-55,'5.4c');
text(370,-47,'5.4');
ylabel('V (mV)');
% print -deps ../text/figure/coupleKo.ps
