clear
close all

files = dir('.');

start = 8;
fileChange = [235];
counter = 1;
j = 1;
c = 'rgbkycrgbkycrgbkycrgbkycrgbkycrgbkycrgbkycrgbkycrgbkyc';
figure(1);clf();hold on;
load(files(start).name);
prevName = ts.label;
for i = start:length(files)
    if ~any(strfind(files(i).name,'itg'))&&~any(strfind(files(i).name,'ari'))
    if any(strfind(files(i).name,'-fp'))
        load(files(i).name)
        if ~strcmp(prevName,ts.label)
            forceCurves(j).label = prevName;
            j = j+1;
            counter = 1;
        end

        forceCurves(j).signals(counter).potvals = ts.potvals;
        forceCurves(j).signals(counter).fids = ts.fids;
        forceCurves(j).signals(counter).label = ts.label;
        forceCurves(j).signals(counter).selfframes = ts.selframes;
        counter = counter + 1;

        plot(ts.potvals(1,:)',c(j));
        prevName = ts.label;
    end
    end
end
forceCurves(j).label = prevName;

%%
%Sample rate is 1 kHz, thus each point describes 1 ms
%
%
%The runs are out of order

for i = 1:length(forceCurves)
    startTimes = zeros(length(forceCurves(i).signals),1);
    for j = 1:length(forceCurves(i).signals)
        startTimes(j) = forceCurves(i).signals(j).selfframes(1);
    end
    [~,sIdx] = sort(startTimes);
    forceCurves(i).signals(:) = forceCurves(i).signals(sIdx);
end
%%


for i = 1:length(forceCurves)
    
    forceCurves(i).heartRate= getHR(forceCurves(i).signals);
    forceCurves(i).medBPM = median(forceCurves(i).heartRate);
    forceCurves(i).meanBPM = mean(forceCurves(i).heartRate);
    [forceCurves(i).forces,forceCurves(i).contractForces,forceCurves(i).T] = getForce(forceCurves(i).signals);
    forceCurves(i).medCF = median(forceCurves(i).contractForces);
    forceCurves(i).meanCF = mean(forceCurves(i).contractForces);
end







%%



prevName = forceCurves(1).label;
figure(1);clf();hold on;title(prevName(1:end-1));

j = 1;
for i = 1:length(forceCurves)
    
        
        if ~strcmp(prevName(1:end-1),forceCurves(i).label(1:end-1))
            
            j = j+1;
            figure(j);clf();hold on;title(forceCurves(i).label(1:end-1));
        end
        for k = 1:length(forceCurves(i).signals)
            plot(forceCurves(i).signals(k).potvals(1,:)');
            
        end
        prevName = forceCurves(i).label;
 end

%%
%clustering

for i = 1:length(forceCurves)
    feature = [];
    for j = 1:length(forceCurves(i).signals)
        forceCurves(i).signals(j).spl = spline(1:length(forceCurves(i).signals(j).potvals(1,:)),forceCurves(i).signals(j).potvals(1,:),linspace(1,length(forceCurves(i).signals(j).potvals(1,:)),1500));
        feature(j,:) = forceCurves(i).signals(j).spl;
    end
    try
    class = kmeans(feature,2);
    forceCurves(i).clustering = class;
    catch
    end
end
        


%%

for i = 1:length(forceCurves)
    class1 = find(forceCurves(i).clustering == 1);
    signalsToAverage =[];
    for j = 1:length(class1)
        signalsToAverage(j,:) = forceCurves(i).signals(class1(j)).spl;
    end
    forceCurves(i).c1BeatMean = mean(signalsToAverage,1);
    forceCurves(i).c1BeatMed = median(signalsToAverage,1);
end

%%
%
experimentOrder = [9,18:20,15:17,30,31,1,2,13,14,10:12,25,21:23,3:5,26,6:8,27,24];
runningOffset = 0;
F = [];
t = [];

transitions = [];
for i = 1:length(experimentOrder)
    F = [F,forceCurves(experimentOrder(i)).contractForces];
    t = [t,forceCurves(experimentOrder(i)).T + runningOffset];
    runningOffset = runningOffset + max(t);
    transitions = [transitions,length(t)];
    labels(i,1) =  {forceCurves(experimentOrder(i)).label};
end

segments = [2,5,8,10,12,14,17,18,21,24,25,28,29];
figure(1);clf();hold on;
plot(1:length(F),F);
scatter(transitions(segments),F(transitions(segments)),'ro')
%%

function HR = getHR(signals)

dT = zeros(1,length(signals)-1);
QRSTimes = zeros(1,length(signals));
fids = [signals(1).fids.type];
idxs = {signals(1).fids.value};
idxs = double(floor(idxs{find(fids ==2)}));
QRSTimes(1) = idxs + signals(1).selfframes(1);

for i = 2:length(signals)
    fids = [signals(i).fids.type];
    idxs = {signals(i).fids.value};
    idxs = idxs{find(fids ==2)};
    idxs = double(floor(idxs(1)));
    QRSTimes(i) = idxs + signals(i).selfframes(1);
    dT(i-1) = QRSTimes(i) - QRSTimes(i-1);
    
end
%1 beat everey dt mS, thus bpm is 60000ms/dT
HR = 60000./dT;

end

function [forces,contractForce,T] = getForce(signals)
T = zeros(1,length(signals));
contractForce = T;
starlingData = load('starlingData.mat');
for ind = 1:length(signals)
    forceSignal = signals(ind).potvals(1,:)*starlingData.m;
    contractForce(ind) = abs(max(forceSignal)-min(forceSignal));
    T(ind) = signals(ind).selfframes(1);
    forces(ind) = {contractForce};
    
end


end


