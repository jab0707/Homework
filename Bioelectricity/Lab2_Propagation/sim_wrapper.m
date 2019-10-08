% Bioen 6460 - Lab: Conduction
% Wrapper for simulation code

% set parameters
p.Istim = 120; % µA/µF
p.coupling = 0.0007; % cm2/ms
p.INaScale = 1;

% run the simulation
[CV, dVdtMax] = main_LRd_strand(p, 2);
    % varargin=1 for figure
    % varargin=2 for CV and figure
    % varargin=3 for CV