% Map_demo
% Author: Quan Ni and Rob MacLeod
% A script to run the Map program, which computes the Luo-Rudy 1991
% version of the cardiac action potential.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear,clf;
% Set the resting potential.
% Note: fixing this will blunt the effect of the changes in extracellular
% potassiumm.  It is not clear to me why it is here actually...
%Vrest = -83;
% Duration of the simulation
duration = 400;

% Pick one of the case below and experiment!

% Full AP--the "normal" case.
% Set some global parameters that the simulation needs.
% Note: always call Constant before running a new simulation.
Constant;
[t,V,INa,ICa,IK,IK1,IKp,Ib,gNa,gK,gK1,gKp,gb] = Map(duration,-30,10,12);
% Now some plots to show the results.

% Plot the Action Potential
figure(2),
subplot(3,2,1)
plot(t,V);
set(gca,'box','off');
set(gca,'XColor',[0 0 0]);
axis([0 duration -100 100])
ylabel('mV');
text(300, 20, 'AP');
%set(gca,'AspectRatio',[3 nan]);

% Now the sodium current
subplot(3,2,3)
plot(t,INa);
set(gca,'box','off');
set(gca,'XColor',[0 0 0]);
ylabel('uA/cm^2');
axis([0 duration -400 00])
text(300,-130, 'INa');
%set(gca,'AspectRatio',[3 nan]);

% And the Calcium (slow inward) current.
subplot(3,2,5)
plot(t,ICa);
set(gca,'box','off');
ylabel('uA/cm^2');
axis([0 duration -6 00])
text(300, -2, 'Isi');
%set(gca,'AspectRatio',[3 nan]);

% The potassium current IK.
subplot(3,2,2)
plot(t,IK);
set(gca,'box','off');
set(gca,'XColor',[0 0 0]);
axis([0 duration -1 2])
ylabel('uA/cm^2');
text(300, 0,'IK');

% The potassium current IK1.
subplot(3,2,4)
plot(t,IK1);
set(gca,'box','off');
set(gca,'XColor',[0 0 0]);
axis([0 duration 0 3])
ylabel('uA/cm^2');
text(300,1, 'IK1');

% The potassium current IKp and the background current.
subplot(3,2,6)
plot(t,IKp,t,Ib);
set(gca,'box','off');
ylabel('uA/cm^2');
axis([0 duration -5 5])
text(300, -1.5,'IKp');
text(300, 3,'Ib');
