%Code for generating figures in HW2
%Jake Bergquist
%Fall 2019
%Q2
C2 = exp(-5/5);
C1 = 5*(1-C2);
alps = [0:.01:3.14];
Mzs = C1*sin(alps)./(1-C2*cos(alps));
figure(1);clf();plot(alps,Mzs,'linewidth',2);hold on;
scatter(pi/2,C1*sin(pi/2)/(1-C2*cos(pi/2)),'ro');
scatter(acos(C2),C1*sin(acos(C2))/(1-C2*cos(acos(C2))),'bo');
ylabel('Observed M_z');
xlabel('Aplha Values');
set(gca,'fontsize',18)
%Q4

TE = [10 20 30 50 100 250];
tumor = [1213.4 1099.3 994.7 783.2 447.6 70.9];
background = [448.1 306.7 239.1 119.0 1.1 30.4];

%Fit the tumor unknowns
coeffs_tumor = polyfit(TE,log(tumor),1);
T2_tumor = -1/coeffs_tumor(1);
IndependedntIntensity_Tumor = exp(coeffs_tumor(2));
%visualize both linearlize dand original
figure(1);clf();hold on;plot(TE,tumor,'r','linewidth',2);
plot([10:1:250],IndependedntIntensity_Tumor*exp(-[10:1:250]/T2_tumor),'b','linewidth',2)
xlabel('TE (msec)');ylabel('intensity');set(gca,'fontsize',18);
figure(2);clf();hold on;plot(TE,log(tumor),'r','linewidth',2);
plot([10:1:250],coeffs_tumor(1).*[10:1:250]+coeffs_tumor(2),'b','linewidth',2);
xlabel('TE (msec)');ylabel('intensity');set(gca,'fontsize',18);

%Fit for background
coeffs_background = polyfit(TE,log(background),1);

T2_background = -1/coeffs_background(1);
IndependedntIntensity_background = exp(coeffs_background(2));
%visualize both linearlize dand original
figure(3);clf();hold on;plot(TE,background,'r','linewidth',2);
plot([10:1:250],IndependedntIntensity_background*exp(-[10:1:250]/T2_background),'b','linewidth',2)
xlabel('TE (msec)');ylabel('intensity');set(gca,'fontsize',18);
figure(4);clf();hold on;plot(TE,log(background),'r','linewidth',2);
plot([10:1:250],coeffs_background(1).*[10:1:250]+coeffs_background(2),'b','linewidth',2);
xlabel('TE (msec)');ylabel('intensity');set(gca,'fontsize',18);


%Q5
TI = [50 100 200 400 800 1600];
tissue1 = [-889 -684 -461 99.4 385 780];
tissue2 = [-261 -217 -108 118 254 339];

objFunc_tiss1 = @(param) LongMagIntensity(TI,tissue1,param);
optParams_tiss1 = fminsearch(objFunc_tiss1,[100,100]);
figure(1);clf();hold on;
plot(TI,tissue1,'r','linewidth',2);
plot([50:1600],optParams_tiss1(1).*(1-2*exp(-[50:1600]/optParams_tiss1(2))),'b','linewidth',2);
xlabel('TI (msec)');ylabel('intensity');set(gca,'fontsize',18);

objFunc_tiss2 = @(param) LongMagIntensity(TI,tissue2,param);
optParams_tiss2 = fminsearch(objFunc_tiss2,[100,100]);
figure(2);clf();hold on;
plot(TI,tissue2,'r','linewidth',2);
plot([50:1600],optParams_tiss2(1).*(1-2*exp(-[50:1600]/optParams_tiss2(2))),'b','linewidth',2);
xlabel('TI (msec)');ylabel('intensity');set(gca,'fontsize',18);

function cost = LongMagIntensity(TI,m,param)
    M0 = param(1);
    T1 = param(2);
    cost = sum((m - M0 * (1 - 2*exp(-TI/T1))).^2);

end


function [cost,T1,M0] = FitParameters(TI,m,M0eps,T1eps)

M0_initial = 0;
T1_initial = 0;
M0 = 0;
T1 = 0;

for i = 1:1000
    
    c2 = (1-2*exp(-TI/T1));
    M0 = M0 - M0eps * (2*m/c2);
    
    c3 = m - M0;
    T1 = T1 - T1eps*(TI/log((c3.*M0.*TI)/(2.*m.*TI)));
    
    cost(i) = sum(m - M0*(1-2*exp(-TI/T1)));
    
    
end


end