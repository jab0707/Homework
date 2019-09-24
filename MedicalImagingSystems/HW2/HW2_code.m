%Code for generating figures in HW2
%Jake Bergquist
%Fall 2019


%Q4

TE = [10 20 30 50 100 250];
tumor = [1213.4 1099.3 994.7 783.2 447.6 70.9];
background = [448.1 306.7 239.1 119.0 1.1 30.4];

figure(1);clf();hold on;plot(TE,tumor,'r','linewidth',2);plot(TE,background,'b','linewidth',2)
figure(2);clf();hold on;plot(log(TE),log(tumor),'r','linewidth',2);plot(log(TE),log(background),'b','linewidth',2)

coeffs_tumor = polyfit(TE,log(tumor),1);

T2_tumor = -1/coeffs_tumor(1);
IndependedntIntensity_Tumor = exp(coeffs_tumor(2));
figure(1);clf();hold on;plot(TE,tumor,'r','linewidth',2);plot(TE,IndependedntIntensity_Tumor*exp(-TE/T2_tumor),'b','linewidth',2)
figure(2);clf();hold on;plot(TE,log(tumor),'r','linewidth',2);plot(TE,coeffs_tumor(1).*TE+coeffs_tumor(2),'b','linewidth',2);

coeffs_background = polyfit(TE,log(background),1);

T2_background = -1/coeffs_background(1);
IndependedntIntensity_background = exp(coeffs_background(2));
figure(3);clf();hold on;plot(TE,background,'r','linewidth',2);plot(TE,IndependedntIntensity_background*exp(-TE/T2_tumor),'b','linewidth',2)
figure(4);clf();hold on;plot(TE,log(background),'r','linewidth',2);plot(TE,coeffs_background(1).*TE+coeffs_background(2),'b','linewidth',2);


%q5

TI = [50 100 200 400 800 1600];
tissue1 = [889 684 461 99.4 385 780];
tissue2 = [261 217 108 118 254 339];

objFunc = @(param) LongMagIntensity(TI,tissue1,param);

optParams = fminsearch(objFunc,[500,500]);

[costTissue1, T1_tissue1,M0_tissue1] = FitParameters(TI,tissue1,0.001,0.001);




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