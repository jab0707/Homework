% The constants are followed those of used in Luo-Rudy 91's model
% Note: in this model Na_i = 10 mmol/L as in their 
%       94's model. GNa_ = 23 millisiemens/uF instead of 16.
%
% Reference: QN:Luo94a

% $Id: Constant.m,v 1.1 1997/06/27 19:32:54 quan Exp quan $

global K_o K_i Na_i Na_o Ca_i Ca_o;
global R T F;
global PK PNa_K;
global Cm;
global Vrest;
global Ggap;

% Cell Geometry;
Length = 100;                       % um
Radius = 11;                        % um
Vcell = pi*Radius^2*Length;         % uL, cell volume
Ageo = 2*pi*Radius^2 + 2*pi*Radius*Length;    % cm^2, geometric membrane area
Acap = 2*Ageo;                      % cm^2, capacitive membrane area
Vmyo = Vcell*.68;                   % uL, myoplasma volume
Vmito = Vcell*.26;                  % uL, mitochondria volume
Vsr = Vcell*.06;                    % uL, sarcoplasmic reticulum volume
Vjsr = Vsr*0.08;                    % uL, junctional SR volume
Vnsr = Vsr*0.92;                    % uL, network SR volume

% Standard ionic concentrations for ventricular cells
K_o = 5.4;                  % mmol/L
K_i = 145;                  % mmol/L
Na_o = 120;                 % mmol/L
Na_i = 10;                  % mmol/L
Ca_o = 1.8;                 % mmol/L
Ca_i = 0.12*10^(-3);        % mmol/L

% Physic constants
F = 96.5;                   % Faraday constant, coulombs/mmol
R = 8.314;                  % gas constant, J/K
T = 273+37;                 % absolute temperature, K 

% Cell constant
PK = 1.66*10^(-6);                 % permability of K 
PNa_K = 0.01833;                   % Normal permability ratio of Na to K
%PNa_K = 0.07833;                   % Altered permability ratio of Na to K
PCa_K = 0.9;                  %%%%%% need to be varified
Cm = 1;                            % membrane capacitance, uF/cm^2;

% membrane potential at rest   %%%%% need work
Vrest = (R*T/F)*log((K_o + PNa_K*Na_o)/(K_i+PNa_K*Na_i));  % mV

%  conductance of gap junctions (mS/cm^2)   50 pS per channels x 39 channels
Ggap = 1000*1000*50*10^(-12)/Ageo;
