clear
close all

%%

files = dir('.');
c = 'rgbk';
figure(1);clf();hold on;
j= 1;
counter = 1;

frankCurves(1).label = 'base';
frankCurves(2).label = '2mm';
frankCurves(3).label = '4mm';
frankCurves(4).label = '6mm';
start = 11;
end1 = 137;
fileChange = [end1,end1+21,end1 + 42];

%%
for i = start:3:212
if any(i == fileChange)
j = j+1;
counter = 1;
end
load(files(i).name)
frankCurves(j).signals(counter).potvals = ts.potvals;
frankCurves(j).signals(counter).fids = ts.fids;
frankCurves(j).signals(counter).label = ts.label;
frankCurves(j).signals(counter).selfframes = ts.selframes;
counter = counter + 1;
plot(ts.potvals',c(j));
end
%%
load('baselineforceprobe.mat');
base.potVals = out.ch1;
load('paperclip98.mat');
p98.potVals = out.ch1;
load('paperclip104.mat');
p104.potVals = out.ch1;
load('paperclip202.mat');
p202.potVals = out.ch1;
clear('out');

%f = m a, a = -9.8m/s^2 m is in g, thus f is in mN, or convert to kg to get
%N
mean98 = mean(p98.potVals);
mean104 = mean(p104.potVals);
mean202 = mean(p202.potVals);

masses = [0,0.098,0.104,0.202];
forces = 9.8*masses;

dV =[0, abs([mean98,mean104,mean202] - mean(base.potVals))];
%Do a quick linear regression to get the slope of this dV to force
%relationship
m = dV'\forces';
xs = [0:.1:1.5];
ys = m*xs;

figure(1);clf();hold on;scatter(dV,forces,'ro');
scatter(xs,ys,'bx');
hold off;

%%
%Now lets calculate the force curves of the heart

for i = 4:4
    for j = 1:length(frankCurves(i).signals)
            frankCurves(i).signals(j).force = abs(frankCurves(i).signals(j).potvals - mean(base.potVals)) * m;
            figure(1);clf();plot(frankCurves(i).signals(j).force');
            
            frankCurves(i).signals(j).good = input('Is good? 0/1: ');
            
            
    end
end

%%
%fids 25 26 27
fids = [frankCurves(1).signals(42).fids.type];

baseIdx = [frankCurves(1).signals(42).fids(1:10).value];
baseIdx = int64(baseIdx(find(fids ==26)));
peakIdx = [frankCurves(1).signals(42).fids(1:10).value];
peakIdx = int64(peakIdx(find(fids ==25)));
peaks = [];
baselines = [];
baselines(1) = frankCurves(1).signals(42).force(1,baseIdx-5);
peaks(1) = frankCurves(1).signals(42).force(1,peakIdx);

for i = 1:41
    baselines = [baselines,min(frankCurves(1).signals(i).force(1,:))];
    peaks = [peaks,max(frankCurves(1).signals(i).force(1,:))];
end
for i = 2:4
    for j = 1:length(frankCurves(i).signals)
            fids = [frankCurves(i).signals(j).fids.type];

            baseIdx = {frankCurves(i).signals(j).fids.value};
            baseIdx = int64(baseIdx{find(fids ==26)});
            peakIdx = {frankCurves(i).signals(j).fids.value};
            peakIdx = int64(peakIdx{find(fids ==25)});
            baselist(i-1,j) =frankCurves(i).signals(j).force(1,baseIdx-5);
            peaklist(i-1,j) = frankCurves(i).signals(j).force(1,peakIdx);
            
    end
end
%%

%The third (6mm) set was poorly autofiducilized, so Im gonna do this
%manually

for i = 1:13
    baselist(3,i) = min(frankCurves(4).signals(i).force(1,:));
    peaklist(3,i) = max(frankCurves(4).signals(i).force(1,:));
end

peaks = [peaks,peaklist(1,1:7),peaklist(2,1:7),peaklist(3,1:13)];
baselines = [baselines,baselist(1,1:7),baselist(2,1:7),baselist(3,1:13)];
figure(1);clf()
scatter(peaks,baselines,'b');title('FrankStarling');



%%

