D = [21,10,7,1,0.8,0.7,0.07].*1e-6;%cm^2/s 
M = [18,32,180,13680,3500,6800,345000];


%y = 6pinr

%D = kT/y

%solve for r
%D = kT/6pinr
%r = kT/(6*pi*D*n)

%body temperature is ~37 celsius = ~310 Kelvin
T = 310;%K
%Boltzman's constant
k = 1.38e-23;%J/K
%Convert k to be in units of cm
%k = 1.38e-23 kg m^2/s^2 K * 100cm/m * 100 cm/m
k = k * 100 * 100;%kg cm^2 / s^2 K
%Viscocity of water at 310 K
n = 0.6913;%mPa/s
%convert to proper units
%n = 0.6931 mPa/s = 0.0006931 Pa/s = 0.0006931 kg/m s^3
% * 100cm/c = 0.06931 kg/cm s^3
n = n/1000 * 100;%kg/cm s^3

for ind = 1:length(D)
    r(ind) = (k*T)/(6*pi*n*D(ind));
    
end
%%

alpha = 0.462;
offset = 2e12;
testR = M.^(alpha);

figure(1);clf();hold on; 
scatter(M,testR/offset,'r');
scatter(M,r,'b');
set(gca,'yscale','log')
set(gca,'xscale','log')
legend({'fit data','measured data'});
xlabel('Molecular Weight (log)');
ylabel('Stokes Radius (log)');