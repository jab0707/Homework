clear();clf(); close all;

%Set up globals;
Constant;
tOn = 10;
Durations = [.5:.05:5];
Amplitudes = [-5:-.5:-55];

combos = cell(length(Durations),length(Amplitudes));
for i = 1:length(Durations)
    for j = 1:length(Amplitudes)
        combos{i,j} = [Durations(i),Amplitudes(j)];
        
    end
    
end

outputs(length(combos(:))).APCall = 0;
for i = 1:length(combos(:))
    outputs(i).label = [num2str(i),': Dur: ',num2str(combos{i}(1)),'s, Amp: ',num2str(combos{i}(2)),'uA/cm^2'];
    outputs(i).stimDuration = combos{i}(1);
    outputs(i).stimAmp = combos{i}(2);
    [outputs(i).t,outputs(i).V,outputs(i).INa,outputs(i).ICa,outputs(i).IK,outputs(i).IK1,outputs(i).IKp,outputs(i).Ib,outputs(i).gNa,outputs(i).gK,outputs(i).gK1,outputs(i).gKp,outputs(i).gb] = Map(400,combos{i}(2),tOn,tOn+combos{i}(1));
    if max(outputs(i).V) > 0
        outputs(i).APCall = 1;
    else
        outputs(i).APCall = 0; 
    end
end
%%
durs = [];
strs = [];
fulldurs = [];
fullstrs = [];
for i = 1:length(combos(:))
    fulldurs = [fulldurs,outputs(i).stimDuration];
    fullstrs = [fullstrs,outputs(i).stimAmp];
    if outputs(i).APCall == 1
        durs = [durs,outputs(i).stimDuration];
        strs = [strs,outputs(i).stimAmp];
        
    end
end

[durs,sIdx] = sort(durs);
strs = strs(sIdx);

figure(1);clf();scatter(durs,-strs);

%%
f = fit(keepDurs',-keepStrs','poly2');

%%
keepDurs = durs(1);
keepStrs = strs(1);

for i = 2:length(durs)
    if durs(i) ~= keepDurs(length(keepDurs))
        keepDurs = [keepDurs,durs(i)];
        keepStrs = [keepStrs,strs(i)];
    end
end

figure(1);hold on;scatter(keepDurs,-keepStrs,'ro');

%%
sodiumConcs = [1:1:200];
global Na_o Vrest;
sodiumOuts(length(sodiumConcs)).APCall = 0;
Constant;
for i = 1:length(sodiumConcs)
    sodiumOuts(i).label = [num2str(i),': NaConc ',num2str(sodiumConcs(i)),'mMol/L'];

    Na_o = sodiumConcs(i);
    Vrest = (R*T/F)*log((K_o + PNa_K*Na_o)/(K_i+PNa_K*Na_i));
    [sodiumOuts(i).t,sodiumOuts(i).V,sodiumOuts(i).INa,sodiumOuts(i).ICa,sodiumOuts(i).IK,sodiumOuts(i).IK1,sodiumOuts(i).IKp,sodiumOuts(i).Ib,sodiumOuts(i).gNa,sodiumOuts(i).gK,sodiumOuts(i).gK1,sodiumOuts(i).gKp,sodiumOuts(i).gb] = Map(400,-30,tOn,12);
    if max(sodiumOuts(i).V) > 0
        sodiumOuts(i).APCall = 1;
    else
        sodiumOuts(i).APCall = 0; 
    end
end

%%
figure(3);clf();hold on;
red = linspace(1,255,200);
for i = 1:length(sodiumConcs)
    figure(3);hold on;
    plot([1:length(sodiumOuts(i).V)],sodiumOuts(i).V,'Color',[red(i)/255,0,0]);
    waitforbuttonpress();
end
%%

thingsToPlot = [95:105];
for i = 1:length(thingsToPlot)
    t = 1:length(sodiumOuts(thingsToPlot(i)).V);
figure(i);clf();hold on;
subplot(3,2,1)
plot(t,sodiumOuts(thingsToPlot(i)).V);
set(gca,'box','off');
set(gca,'XColor',[0 0 0]);
axis([0 duration -100 100])
ylabel('mV');
text(300, 20, 'AP');
%set(gca,'AspectRatio',[3 nan]);

% Now the sodium current
subplot(3,2,3)
plot(t,sodiumOuts(thingsToPlot(i)).INa);
set(gca,'box','off');
set(gca,'XColor',[0 0 0]);
ylabel('uA/cm^2');
axis([0 duration -400 00])
text(300,-130, 'INa');
%set(gca,'AspectRatio',[3 nan]);

% And the Calcium (slow inward) current.
subplot(3,2,5)
plot(t,sodiumOuts(thingsToPlot(i)).ICa);
set(gca,'box','off');
ylabel('uA/cm^2');
axis([0 duration -6 00])
text(300, -2, 'Isi');
%set(gca,'AspectRatio',[3 nan]);

% The potassium current IK.
subplot(3,2,2)
plot(t,sodiumOuts(thingsToPlot(i)).IK);
set(gca,'box','off');
set(gca,'XColor',[0 0 0]);
axis([0 duration -1 2])
ylabel('uA/cm^2');
text(300, 0,'IK');

% The potassium current IK1.
subplot(3,2,4)
plot(t,sodiumOuts(thingsToPlot(i)).IK1);
set(gca,'box','off');
set(gca,'XColor',[0 0 0]);
axis([0 duration 0 3])
ylabel('uA/cm^2');
text(300,1, 'IK1');

% The potassium current IKp and the background current.
subplot(3,2,6)
plot(t,sodiumOuts(thingsToPlot(i)).IKp,t,sodiumOuts(thingsToPlot(i)).Ib);
set(gca,'box','off');
ylabel('uA/cm^2');
axis([0 duration -5 5])
text(300, -1.5,'IKp');
text(300, 3,'Ib');

a = 1;
end

%%
potassConcs = [1:1:100];
kOuts(length(potassConcs)).APCall = 0;
Constant;

global K_o;
for i = 1:length(potassConcs)
    kOuts(i).label = [num2str(i),': KConc ',num2str(sodiumConcs(i)),'mMol/L'];
    K_o = potassConcs(i);
    Vrest = (R*T/F)*log((K_o + PNa_K*Na_o)/(K_i+PNa_K*Na_i));
    [kOuts(i).t,kOuts(i).V,kOuts(i).INa,kOuts(i).ICa,kOuts(i).IK,kOuts(i).IK1,kOuts(i).IKp,kOuts(i).Ib,kOuts(i).gNa,kOuts(i).gK,kOuts(i).gK1,kOuts(i).gKp,kOuts(i).gb] = Map(400,-30,tOn,12);
    if max(kOuts(i).V) > 0
        kOuts(i).APCall = 1;
    else
        kOuts(i).APCall = 0; 
    end
end

%%
figure(4);clf();hold on;
red = linspace(1,255,100);
for i = 1:length(potassConcs)
    figure(4);hold on;
    plot([1:length(kOuts(i).V)],kOuts(i).V,'Color',[red(i)/255,0,0]);
end
