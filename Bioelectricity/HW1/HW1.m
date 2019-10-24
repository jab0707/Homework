
%1)
clear;close all
re = 1;
ri = 1;
x = [-4:.1:4];
vMx = 50*tanh(x);
dvMx = diff(vMx);
ddvMx = diff(dvMx);
I = 0;%No stimulation
Ii = (-1/(ri+re))*(dvMx-I*re);
Im = (1/(ri+re))*(ddvMx-I*re);
Ie = (dvMx+Ii.*ri)./re;
figure(1);
plot(x,vMx./50,'b','linewidth',3);
xlabel('Distance (mm)');
ylabel('Vm');

figure(2);
plot(x(1:end-1),Ii./(max(abs(Ii))),'g','linewidth',3)
xlabel('Distance (mm)');
ylabel('Ii');

figure(3);clf();
hold on;
plot(x(1:end-2),Im./(max(abs(Im))),'r','linewidth',3)
plot(x,vMx./50,'b','linewidth',3)
xlabel('Distance (mm)');
ylabel('Im and Vm');

figure(4);plot(x(1:end-1),Ie./(max(abs(Ie))),'k','linewidth',3)
xlabel('Distance (mm)');
ylabel('Ie');

%
%2)
rheobase = 10;%uA/cm2
durations = [1,3];
strengths = [29.346,14.015];
tc = 2.4;

t = [.1:.1:3];
Str = rheobase./(1-exp(-t/tc));
StrReq = rheobase./(1-exp(-0.2/tc));
figure(5);
hold on;
plot(t,Str,'linewidth',3)
scatter(durations,strengths,'ro','filled')
scatter(0.2,StrReq,'ko','filled');
xlabel('Duration (ms)');
ylabel('Strength (\mu A/cm^2)')


