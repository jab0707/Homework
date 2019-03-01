clear
close all
%%

files = dir('.');

start = 10;
fileChange = [235];
counter = 1;
j = 1;
c = 'rgbkycrgbkycrgbkycrgbkycrgbkycrgbkycrgbkycrgbkycrgbkyc';
figure(1);clf();hold on;
load(files(start).name);
prevName = ts.label;
for i = start:3:length(files)
    if any(strfind(files(i).name,'-cs'))
        load(files(i).name)
        if ~strcmp(prevName,ts.label)
            drugCurves(j).label = prevName;
            j = j+1;
            counter = 1;
        end

        drugCurves(j).signals(counter).potvals = ts.potvals;
        drugCurves(j).signals(counter).fids = ts.fids;
        drugCurves(j).signals(counter).label = ts.label;
        drugCurves(j).signals(counter).selfframes = ts.selframes;
        counter = counter + 1;

        plot(ts.potvals(1,:)',c(j));
        prevName = ts.label;
    end
end
drugCurves(j).label = prevName;

%%
%Sample rate is 1 kHz, thus each point describes 1 ms
%
%
%The runs are out of order

for i = 1:length(drugCurves)
    startTimes = zeros(length(drugCurves(i).signals),1);
    for j = 1:length(drugCurves(i).signals)
        startTimes(j) = drugCurves(i).signals(j).selfframes(1);
    end
    [~,sIdx] = sort(startTimes);
    drugCurves(i).signals(:) = drugCurves(i).signals(sIdx);
end
%%


for i = 1:length(drugCurves)
    
    drugCurves(i).heartRate= getHR(drugCurves(i).signals);
    drugCurves(i).medBPM = median(drugCurves(i).heartRate);
    drugCurves(i).meanBPM = mean(drugCurves(i).heartRate);
    %drugCurves(i).QRSInt = getQRSInt(drugCurves(i).signals);
    %drugCurves(i).Tpeak = getTpeak(drugCurves(i).signals);
    %drugCurves(i).Tint = getTint(drugCurves(i).signals);
    
end







%%



prevName = drugCurves(1).label;
figure(1);clf();hold on;title(prevName(1:end-1));

j = 1;
for i = 1:length(drugCurves)
    
        
        if ~strcmp(prevName(1:end-1),drugCurves(i).label(1:end-1))
            
            j = j+1;
            figure(j);clf();hold on;title(drugCurves(i).label(1:end-1));
        end
        for k = 1:length(drugCurves(i).signals)
            plot(drugCurves(i).signals(k).potvals(1,:)');
            
        end
        prevName = drugCurves(i).label;
 end

%%
%clustering

for i = 1:length(drugCurves)
    feature = [];
    for j = 1:length(drugCurves(i).signals)
        drugCurves(i).signals(j).spl = spline(1:length(drugCurves(i).signals(j).potvals(1,:)),drugCurves(i).signals(j).potvals(1,:),linspace(1,length(drugCurves(i).signals(j).potvals(1,:)),1500));
        feature(j,:) = drugCurves(i).signals(j).spl;
    end
    
    class = kmeans(feature,2);
    drugCurves(i).clustering = class;
   
end
        


%%

for i = 1:length(drugCurves)
    class1 = find(drugCurves(i).clustering == 1);
    signalsToAverage =[];
    for j = 1:length(class1)
        signalsToAverage(j,:) = drugCurves(i).signals(class1(j)).spl;
    end
    drugCurves(i).c1BeatMean = mean(signalsToAverage,1);
    drugCurves(i).c1BeatMed = median(signalsToAverage,1);
end

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




