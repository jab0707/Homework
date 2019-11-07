%Q1

dC = -(0.004 * 6.023e23)/1000;
dX = 100;%cm
D = 5.5e-6;%cm^2/s
phi = -D*(dC/dX);
d = 1e-3;%cm
r = d/2;
area = pi * r^2;%cm^2
flow = phi*area;
timeToDiffuse = 3000000/flow;
%Q2
u = 0;
m = 10^9;
v = 1e-4;
G = 10^-6;
t = 80;
convection = (exp(-(u-t*v)^2/(4*G*t))*m)/...
    (2*sqrt(pi)*sqrt(G*t));

%Q3
k = 1.38e-23;%m^2 kg/K s
T = 293;%K
g = 9.8;%m/s^2
Ddiff = 19.3*1000 - 1000;%
lambda = 0.009;%m
r = ((3*k*T)/(4*g*pi*Ddiff*lambda))^(1/3);
d = 2*r;
fprintf('Diameter: %d',d);

%Q4
k = 1.38e-23;%m^2 kg/K s
T = 292;%k
f = 1e-12;%kg m/s^2
x0 = 4e-8;%m
D = 6e-11;%m/s

tnoforce = x0^2/(2*D);

%Now with force
%With the force
t1 = 2*(x0^2/(2*D))*...
    ((k*T)/(f*x0))^2*(exp(-(f*x0)/(k*T))...
    - 1 + (f*x0)/(k*T));
%f = -f;%either works
x0 = -x0;
%Against the force
t2 = 2*(x0^2/(2*D))*...
    ((k*T)/(f*x0))^2*(exp(-(f*x0)/(k*T))...
    - 1 + (f*x0)/(k*T));

