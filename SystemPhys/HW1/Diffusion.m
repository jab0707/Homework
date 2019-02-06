% Diffusion   Diffusion of ions across membrane 

Constant;
V = -200:200;       % transmembrane potential;

% for single ion;
JK = NernstPlanck(V,1,K_i,K_o,PK);
JNa = NernstPlanck(V,1,Na_i,Na_o,PK*PNa_K);
JCa = NernstPlanck(V,2,Ca_i,Ca_o,PK*PCa_K);

figure(1),
subplot(1,3,1),
plot(V,JK);
axis square,grid,
title('Potassium Flux');
xlabel('Membrane Potential (mV)');
ylabel('Flux (mA/cm^2)');
subplot(1,3,2),
plot(V,JNa);
axis square,grid,
title('Sodium Flux');
subplot(1,3,3),
plot(V,JCa);
axis square,grid,
title('Calcium Flux');

%print -f1 -deps ../text/figure/IVCurve1.ps

figure(2),
JK1 = NernstPlanck(V,1,K_i,K_o,PK);
JK2 = NernstPlanck(V,1,K_i,72.7,PK);
JK3 = NernstPlanck(V,1,K_i,145,PK);
JK4 = NernstPlanck(V,1,K_i,290,PK);

plot(V,JK1+JNa,'r-',V,JK2+JNa,'g.',V,JK3+JNa,'y-.',V,JK4+JNa,'r--')
xlabel('Membrane Potential (mV)');
ylabel('Transmembrane Current (mA/cm^2)');
legend('r-','K_o = 5.4','g.','K_o = 72.5','y-.','K_o = 145','r--','K_o = 290');
grid,

%print -f2 -deps ../text/figure/IVCurve2.ps
