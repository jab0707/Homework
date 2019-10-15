% APL Oct 2013; Bioen 6460 - Lab: Conduction
% Wrapper for simulation code - basic version

% set parameters
p.Istim = 120; % µA/µF
p.coupling = 0.0007; % cm2/ms
p.INaScale = 1;
tic
% run the simulation
main_LRd_strand_basic(p);
toc