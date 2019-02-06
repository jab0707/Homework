% Map_demo
% Author: Quan Ni and Rob MacLeod
% A script to run the Map program, which computes the Luo-Rudy 1991
% version of the cardiac action potential.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear,clf;
% Set some global parameters that the simulation needs.
Constant;
% Set the resting potential.
Vrest = -83;

% Duration of the simulation
duration = 400;

% Pick one of the case below and experiment!

% Full AP--the "normal" case.
[t,V,INa,ICa,IK,IK1,IKp,Ib,gNa,gK,gK1,gKp,gb] = Map(duration,-30,10,12);

% Now some plots to show the results.

% Plot the Action Potential
figure(1),
subplot(3,1,1)
plot(t,V);
set(gca,'box','off');
set(gca,'XColor',[0 0 0]);
axis([0 duration -100 100])
ylabel('mV');
text(300, 20, 'AP');
%set(gca,'AspectRatio',[3 nan]);

% Now the sodium current
subplot(3,1,2)
%plot(t(1:50),INa(1:50)); % Hi-res version
plot(t,INa);
set(gca,'box','off');
set(gca,'XColor',[0 0 0]);
ylabel('uA/cm^2');
axis([0 duration -100 00])
text(300,-30, 'INa');
%set(gca,'AspectRatio',[3 nan]);

% And the Calcium (slow inward) current.
subplot(3,1,3)
plot(t,ICa);
set(gca,'box','off');
ylabel('uA/cm^2');
axis([0 duration -6 00])
text(300, -2, 'Isi');
%set(gca,'AspectRatio',[3 nan]);

;
