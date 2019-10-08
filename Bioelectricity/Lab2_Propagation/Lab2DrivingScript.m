%Lab 2 Driving Script
clear
close all
clc
%Simulation parameters:
simParams = [120,120,120,120,120,120,120,110,100,90,80,120,120,120,120,120,120;...
            7e-5,1e-4,2e-4,7e-4,1e-3,2e-3,3e-3,7e-4,7e-4,7e-4,7e-4,7e-4,7e-4,7e-4,7e-4,7e-4,7e-4;...
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 0.75, 0.5, 0.4, 0.3, 0.25]';
        

%Preallocate for speed
CV{length(simParams)} = [];
dVdtMax{length(simParams)} = [];
TMPs{length(simParams)}=[];
parfor ind = 1:length(simParams)
    % set parameters
    figure(ind);plot(rand(25));drawnow();
    fprintf(sprintf('Setting Parameter Set %d\n',ind));
    Pstruct = setPstruct(simParams(ind,:));

    % run the simulation
    fprintf(sprintf('Running Simulation for Parameter Set %d\n',ind));
    %The original function was modified to also pass the TMP values for
    %plotting later
    [CV{ind}, dVdtMax{ind},TMPs{ind}] = main_LRd_strand(Pstruct, 2);
    fprintf(sprintf('Finished Simulation For Parameter Set %d\n',ind));
    
end
%%

%The plot functionality was pulled out of the original function in order to
%levarage parfor while also plotting everything. To do so the following
%variables were also pulled out"
Time = 200; N = 1;Tmesh=800;
tp=linspace(0,Time*N,Tmesh*N);
Xsize=1;Xmesh=50;%% 1 cm=100 cells; default Xmesh: 50
x = linspace(0,Xsize,Xmesh);
[Xp,Tp]=meshgrid(tp,x);

for ind = 1:length(simParams)
    figure(ind);clf();
    h=mesh(Tp',Xp',TMPs{ind});
    ylabel(['Time [ms]'],'FontSize',10)
    xlabel(['Fiber [cm]'],'FontSize',10)
    view(-37,70)
    zlabel('V_m (mV)','FontSize',10)
    set(gca,'FontSize',10)
    axis tight
    box off
    grid off
    set(gca,'fontsize',18)
end


function Pstruct = setPstruct(simParams)
Pstruct.Istim = simParams(1);
Pstruct.coupling = simParams(2);
Pstruct.INaScale = simParams(3);

end