
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
figure(1);plot(x,vMx./50,'b');
hold on;
plot(x(1:end-1),Ii./(max(abs(Ii))),'g','linewidth',2)
plot(x(1:end-2),Im./(max(abs(Im))),'r')
plot(x(1:end-1),Ie./(max(abs(Ie))),'k')


%%
%2)
rheobase = 10;%uA/cm2
durations = [1,3];
strengths = [29.346,14.015];
tc = 2.4;

t = [.1:.1:3];
Str = rheobase./(1-exp(-t/tc));
figure(1);clf();
plot(t,Str)