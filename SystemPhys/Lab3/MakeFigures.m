%
%

clear
close all
%%
QRSStart = 124;
QRSEnd = 584;
Ton = 970;
Toff = 1658;

%%

limFile = 'LimbLeadsBreathHold30sec-pf';

load([limFile,'-lts.mat']);
limbLeads(1).ts = ts;
limbLeads(1).selfFrames = ts.selframes;
limbLeads(1).potvals = ts.potvals;
limbLeads(1).spl(1,:) = spline(1:length(ts.potvals(1,:)),ts.potvals(1,:),linspace(1,length(ts.potvals(1,:)),2000));
limbLeads(1).spl(2,:) = spline(1:length(ts.potvals(2,:)),ts.potvals(2,:),linspace(1,length(ts.potvals(2,:)),2000));
limbLeads(1).spl(3,:) = spline(1:length(ts.potvals(3,:)),ts.potvals(3,:),linspace(1,length(ts.potvals(3,:)),2000));
beatCollection(1,:,:) = ts.potvals';

for i = 1:25
    load([limFile,'-b',num2str(i),'-lts.mat']);
    limbLeads(i+1).ts = ts;
    limbLeads(i+1).selfFrames = ts.selframes;
    limbLeads(i+1).potvals = ts.potvals;
    limbLeads(i+1).spl(1,:) = spline(1:length(ts.potvals(1,:)),ts.potvals(1,:),linspace(1,length(ts.potvals(1,:)),2000));
    limbLeads(i+1).spl(2,:) = spline(1:length(ts.potvals(2,:)),ts.potvals(2,:),linspace(1,length(ts.potvals(2,:)),2000));
    limbLeads(i+1).spl(3,:) = spline(1:length(ts.potvals(3,:)),ts.potvals(3,:),linspace(1,length(ts.potvals(3,:)),2000));
    beatCollection(i+1,:,:) = ts.potvals';
end

lead1Averaged = mean(beatCollection(:,:,1),1);
lead2Averaged = mean(beatCollection(:,:,2),1);
lead3Averaged = mean(beatCollection(:,:,3),1);
%%
limb5beats = zeros(3,limbLeads(5).selfFrames(2));
for i = 1:5
    
    limb5beats(:,limbLeads(i).selfFrames(1):limbLeads(i).selfFrames(2)) = limbLeads(i).potvals;
    
end

%%

figure('DefaultAxesFontSize',18);clf();

subplot(311);

plot(limb5beats(1,limbLeads(1).selfFrames(1)-500:end)','r','LineWidth',2);
title('Lead I');xlabel('Time (1/5 ms)');ylabel('Voltage (mV)');
subplot(312);

plot(limb5beats(2,limbLeads(1).selfFrames(1)-500:end)','g','LineWidth',2);
title('Lead II');xlabel('Time (1/5 ms)');ylabel('Voltage (mV)');
subplot(313);

plot(limb5beats(3,limbLeads(1).selfFrames(1)-500:end)','b','LineWidth',2);
title('Lead III');xlabel('Time (1/5 ms)');ylabel('Voltage (mV)');

%%


figure('DefaultAxesFontSize',18);
subplot(311);

plot(beatCollection(:,:,1)');
title('Lead I');xlabel('Time (1/5 ms)');ylabel('Voltage (mV)');
subplot(312);

plot(beatCollection(:,:,2)');
title('Lead II');xlabel('Time (1/5 ms)');ylabel('Voltage (mV)');
subplot(313);

plot(beatCollection(:,:,3)');
title('Lead III');xlabel('Time (1/5 ms)');ylabel('Voltage (mV)');

figure('DefaultAxesFontSize',18);
subplot(311);

plot(lead1Averaged','r','LineWidth',2);
title('Lead I Averaged');xlabel('Time (1/5 ms)');ylabel('Voltage (mV)');
subplot(312);

plot(lead2Averaged','g','LineWidth',2);
title('Lead II Averaged');xlabel('Time (1/5 ms)');ylabel('Voltage (mV)');
subplot(313);

plot(lead3Averaged','b','LineWidth',2);
title('Lead III Averaged');xlabel('Time (1/5 ms)');ylabel('Voltage (mV)');



%%


L1Unit = [1,0];
L2Unit = [cos(pi/3),-sin(pi/3)];
L3Unit = [-cos(pi/3),-sin(pi/3)];
yUnit = [0,-1];
Hvect = zeros(2,1716);
xAngle = zeros(1,1716);
yAngle = xAngle;
for i = 1:1716
    Hvect(1,i) = lead1Averaged(i);
    Hvect(2,i) = (lead1Averaged(i) - 2*lead2Averaged(i))/sqrt(3);
    xAngle(i) = atan2(norm(cross([L1Unit,0],[Hvect(:,i)',0])),dot([L1Unit,0],[Hvect(:,i)',0]));
    yAngle(i) = atan2(norm(cross([yUnit,0],[Hvect(:,i)',0])),dot([yUnit,0],[Hvect(:,i)',0]));
end



%%
figure('DefaultAxesFontSize',18);clf();hold on;
c = 'b';
for i = 1:1716
if i > QRSStart && i <= QRSEnd
c = 'r';
elseif i >QRSEnd && i <= Ton
c = 'g';
elseif i > Ton && i <= Toff
c = 'c';
elseif i > Toff && i <= 1617
c = 'b';
end
quiver(.5,-.5,Hvect(1,i),Hvect(2,i),c,'AutoScaleFactor',0.99);
scatter(Hvect(1,i)'+.5,Hvect(2,i)'-.5,c)
end
xlabel('X component (mV)');ylabel('Y component (mV)');
title('Heart Vectors from Limb Leads and resultant trajectory');
%%

figure('DefaultAxesFontSize',18);clf();hold on;
c = 'b';
subplot(221)
for i = 1:1716
if i == QRSStart-1
    
    subplot(222);
    hold on;
    c = 'r';
elseif i ==QRSEnd+1 
    title('QRS');xlabel('X component (mV)');ylabel('Y component (mV)');
    subplot(223);
    hold on;
    c = 'g';
elseif i == Ton
    title('ST segment');xlabel('X component (mV)');ylabel('Y component (mV)');
    subplot(224);
    hold on;
    c = 'c';
elseif i == Toff+1
    title('T wave');xlabel('X component (mV)');ylabel('Y component (mV)');
    subplot(221);
    hold on;
    c = 'b';
end
scatter(Hvect(1,i)',Hvect(2,i)',c)
end
title('Pre and Post beat');xlabel('X component (mV)');ylabel('Y component (mV)');
%%
clear;close all;
frankFile = 'FrankLeadsBreathHold30sec-pf';
load([frankFile,'-fts.mat']);
figure(1);clf();plot(ts.potvals');
 k = waitforbuttonpress();
for i = 1:9
    load([frankFile,'-b',num2str(i),'-fts.mat']);
    figure(1);clf();plot(ts.potvals');
    title(i);
    k = waitforbuttonpress();
end



%%

include = [1:29];
frankFile = 'FrankLeadsBreathHold30sec-pf';
load([frankFile,'-fts.mat']);
frankLeads(1).ts = ts;
frankLeads(1).selfFrames = ts.selframes;
frankLeads(1).potvals = ts.potvals;
frankLeads(1).spl(1,:) = spline(1:length(ts.potvals(1,:)),ts.potvals(1,:),linspace(1,length(ts.potvals(1,:)),2000));
frankLeads(1).spl(2,:) = spline(1:length(ts.potvals(2,:)),ts.potvals(2,:),linspace(1,length(ts.potvals(2,:)),2000));
frankLeads(1).spl(3,:) = spline(1:length(ts.potvals(3,:)),ts.potvals(3,:),linspace(1,length(ts.potvals(3,:)),2000));
frankBeatCollection(1,:,:) = ts.potvals';

for ind = 1:length(include)
    i = include(ind);
    load([frankFile,'-b',num2str(i),'-fts.mat']);
    frankLeads(ind+1).ts = ts;
    frankLeads(ind+1).selfFrames = ts.selframes;
    frankLeads(ind+1).potvals = ts.potvals;
    frankLeads(ind+1).spl(1,:) = spline(1:length(ts.potvals(1,:)),ts.potvals(1,:),linspace(1,length(ts.potvals(1,:)),2000));
    frankLeads(ind+1).spl(2,:) = spline(1:length(ts.potvals(2,:)),ts.potvals(2,:),linspace(1,length(ts.potvals(2,:)),2000));
    frankLeads(ind+1).spl(3,:) = spline(1:length(ts.potvals(3,:)),ts.potvals(3,:),linspace(1,length(ts.potvals(3,:)),2000));
    frankBeatCollection(ind+1,1:length(ts.potvals(1,:)),:) = ts.potvals';
end


classes = kmeans(frankBeatCollection(:,:,1),2);
cl1 = find(classes == 1);
cl2 = find(classes == 2);
figure(1);subplot(211);plot(frankBeatCollection(cl1,:,1)');title('cl1');subplot(212)
plot(frankBeatCollection(cl2,:,1)');title('cl2');

%%
cltouse = cl1;
f1Averaged = mean(frankBeatCollection(cltouse,:,1),1);
f2Averaged = mean(frankBeatCollection(cltouse,:,2),1);
f3Averaged = mean(frankBeatCollection(cltouse,:,3),1);
%%

f5beats = zeros(3,100);
for i = 8:11
    
    f5beats(:,frankLeads(i).selfFrames(1):frankLeads(i).selfFrames(2)) = frankLeads(i).potvals;
    
end
figure('DefaultAxesFontSize',18);clf();subplot(311);plot(f5beats(1,50000:end)','r','LineWidth',2);title('Frank X lead');xlabel('Time 1/5 ms');ylabel('Voltage (mV)');
subplot(312);plot(f5beats(2,50000:end)','g','LineWidth',2);title('Frank Y lead');xlabel('Time 1/5 ms');ylabel('Voltage (mV)');
subplot(313);plot(f5beats(3,50000:end)','b','LineWidth',2);title('Frank Z lead');xlabel('Time 1/5 ms');ylabel('Voltage (mV)');

%%
figure('DefaultAxesFontSize',18);clf();

subplot(311);

plot(f5beats(1,50000:end)','r','LineWidth',2);
title('Frank X lead');xlabel('Time (1/5 ms)');ylabel('Voltage (mV)');
subplot(312);

plot(f5beats(2,50000:end)','g','LineWidth',2);
title('Frank Y lead');xlabel('Time (1/5 ms)');ylabel('Voltage (mV)');
subplot(313);

plot(f5beats(3,50000:end)','b','LineWidth',2);
title('Frank Z lead');xlabel('Time (1/5 ms)');ylabel('Voltage (mV)');


%%
figure('DefaultAxesFontSize',18);
subplot(311);

plot(frankBeatCollection(cltouse,:,1)');
title('Frank X lead');xlabel('Time (1/5 ms)');ylabel('Voltage (mV)');
subplot(312);

plot(frankBeatCollection(cltouse,:,2)');
title('Frank Y lead');xlabel('Time (1/5 ms)');ylabel('Voltage (mV)');
subplot(313);

plot(frankBeatCollection(cltouse,:,3)');
title('Frank Z lead');xlabel('Time (1/5 ms)');ylabel('Voltage (mV)');

figure('DefaultAxesFontSize',18);
subplot(311);

plot(f1Averaged','r','LineWidth',2);
title('X Averaged');xlabel('Time (1/5 ms)');ylabel('Voltage (mV)');
subplot(312);

plot(f2Averaged','g','LineWidth',2);
title('Y Averaged');xlabel('Time (1/5 ms)');ylabel('Voltage (mV)');
subplot(313);

plot(f3Averaged','b','LineWidth',2);
title('Z Averaged');xlabel('Time (1/5 ms)');ylabel('Voltage (mV)');

%%
fQRSon = 97;
fQRSoff = 596;
fTon = 944;
fToff = 1550;
frankVector = [f1Averaged;f2Averaged;f3Averaged];

%%
figure('DefaultAxesFontSize',18);hold on;
subplot(221)
pcshow(frankVector(:,1:fQRSon-1)','b','MarkerSize',25);
pcshow(frankVector(:,fToff+1:end)','b','MarkerSize',25);
xlabel('X component (mV)');ylabel('Y component (mV)');zlabel('Z component(mV)');
title('Pre and Post beat')
subplot(222)
pcshow(frankVector(:,fQRSon:fQRSoff)','r','MarkerSize',25);
xlabel('X component (mV)');ylabel('Y component (mV)');zlabel('Z component(mV)');
title('QRS')
subplot(223)
pcshow(frankVector(:,fQRSoff+1:fTon-1)','g','MarkerSize',25);
xlabel('X component (mV)');ylabel('Y component (mV)');zlabel('Z component(mV)');
title('ST segment')
subplot(224)
pcshow(frankVector(:,fTon:fToff)','c','MarkerSize',25);
xlabel('X component (mV)');ylabel('Y component (mV)');zlabel('Z component(mV)');
title('T wave')
%%
figure('DefaultAxesFontSize',18);hold on;
pcshow(frankVector(:,1:fQRSon-1)','b','MarkerSize',25);
pcshow(frankVector(:,fToff+1:end)','b','MarkerSize',25);

pcshow(frankVector(:,fQRSon:fQRSoff)','r','MarkerSize',25);

pcshow(frankVector(:,fQRSoff+1:fTon-1)','g','MarkerSize',25);

pcshow(frankVector(:,fTon:fToff)','c','MarkerSize',25);
xlabel('X component (mV)');ylabel('Y component (mV)');zlabel('Z component(mV)');
title('Frank Vector Loop')

%%
%Frontal
figure('DefaultAxesFontSize',18);clf();hold on;
c = 'b';
subplot(221)
for i = 1:length(frankVector)
if i == fQRSOn-1
    
    subplot(222);
    hold on;
    c = 'r';
elseif i ==fQRSoff+1 
    title('QRS');xlabel('X component (mV)');ylabel('Y component (mV)');
    subplot(223);
    hold on;
    c = 'g';
elseif i == fTon
    title('ST segment');xlabel('X component (mV)');ylabel('Y component (mV)');
    subplot(224);
    hold on;
    c = 'c';
elseif i == fToff+1
    title('T wave');xlabel('X component (mV)');ylabel('Y component (mV)');
    subplot(221);
    hold on;
    c = 'b';
end
scatter(frankVector(1,i)',frankVector(2,i)',c)
end
title('Pre and Post beat');xlabel('X component (mV)');ylabel('Y component (mV)');
%%

%%
%coronal
figure('DefaultAxesFontSize',18);clf();hold on;
c = 'b';
subplot(221)
for i = 1:length(frankVector)
if i == fQRSOn-1
    
    subplot(222);
    hold on;
    c = 'r';
elseif i ==fQRSoff+1 
    title('QRS');xlabel('X component (mV)');ylabel('Z component (mV)');
    subplot(223);
    hold on;
    c = 'g';
elseif i == fTon
    title('ST segment');xlabel('X component (mV)');ylabel('Z component (mV)');
    subplot(224);
    hold on;
    c = 'c';
elseif i == fToff+1
    title('T wave');xlabel('X component (mV)');ylabel('Z component (mV)');
    subplot(221);
    hold on;
    c = 'b';
end
scatter(frankVector(1,i)',frankVector(3,i)',c)
end
title('Pre and Post beat');xlabel('X component (mV)');ylabel('Z component (mV)');
%%
figure('DefaultAxesFontSize',18);clf();hold on;
c = 'b';
subplot(221)
for i = 1:length(frankVector)
if i == fQRSOn-1
    
    subplot(222);
    hold on;
    c = 'r';
elseif i ==fQRSoff+1 
    title('QRS');xlabel('Y component (mV)');ylabel('Z component (mV)');
    subplot(223);
    hold on;
    c = 'g';
elseif i == fTon
    title('ST segment');xlabel('Y component (mV)');ylabel('Z component (mV)');
    subplot(224);
    hold on;
    c = 'c';
elseif i == fToff+1
    title('T wave');xlabel('Y component (mV)');ylabel('Z component (mV)');
    subplot(221);
    hold on;
    c = 'b';
end
scatter(frankVector(2,i)',frankVector(3,i)',c)
end
title('Pre and Post beat');xlabel('Y component (mV)');ylabel('Z component (mV)');

%%
figure(8);
clf();hold on;
pcshow(frankVector(:,1:fQRSOn-1)','b','MarkerSize',5);
pcshow(frankVector(:,fQRSOn:fQRSoff)','r','MarkerSize',5);
pcshow(frankVector(:,fQRSoff+1:fTon-1)','g','MarkerSize',5);
pcshow(frankVector(:,fTon:fToff)','c','MarkerSize',5);
pcshow(frankVector(:,fToff+1:end)','b','MarkerSize',5);
xlabel('X component (mV)');ylabel('Y component (mV)');zlabel('Z component (mV)')

%%

%percordials time
clear;close all;
precordName = 'ecg12lead_';

for lead = 1:6
    load([precordName,num2str(lead),'-pf-pts.mat']);
    percordLeads(lead).signals(1).ts = ts;
    percordLeads(lead).signals(1).selfFrames = ts.selframes;
    percordLeads(lead).signals(1).potvals = ts.potvals;
    percordLeads(lead).signals(1).spl(1,:) = spline(1:length(ts.potvals(1,:)),ts.potvals(1,:),linspace(1,length(ts.potvals(1,:)),2000));
    load([precordName,num2str(lead),'-pf-ext.mat']);
    percordLeads(lead).L1ref = ts;
    
    for b = 1:20   
        try
            load([precordName,num2str(lead),'-pf-b',num2str(b),'-pts.mat']);
            percordLeads(lead).signals(b+1).ts = ts;
            percordLeads(lead).signals(b+1).selfFrames = ts.selframes;
            percordLeads(lead).signals(b+1).potvals = ts.potvals;
            percordLeads(lead).signals(b+1).spl(1,:) = spline(1:length(ts.potvals(1,:)),ts.potvals(1,:),linspace(1,length(ts.potvals(1,:)),2000));

            
            
        catch
        end
    
    end
    collectBeats = zeros(1,2000);
    for b = 1:length(percordLeads(lead).signals)
        collectBeats(b,1:length(percordLeads(lead).signals(b).potvals)) = percordLeads(lead).signals(b).potvals;
    end
    percordLeads(lead).collected = collectBeats;
end
%%
%signal averaging

for lead = 1:6
    
    classes = kmeans(percordLeads(lead).collected,2);
    cl1 = find(classes == 1);
    cl2 = find(classes == 2);
    figure(lead);clf();subplot(211);plot(percordLeads(lead).collected(cl1,:)');title('cl1');subplot(212)
    plot(percordLeads(lead).collected(cl2,:)');title('cl2');
    
    choice = input('Which class to use?: ');
    
    if choice == 1
        cltouse = cl1;
    elseif choice == 2
        cltouse = cl2;
    else
        cltouse = 1:size(percordLeads(lead).collected,1);
    end
    
    percordLeads(lead).aveBeat = mean(percordLeads(lead).collected(cltouse,:),1);

end
%%
figure('DefaultAxesFontSize',18);clf();

for lead = 1:6
    
    subplot(6,1,lead);
    plot(percordLeads(lead).aveBeat','k','LineWidth',2);
    title(['V',num2str(lead)]);xlabel('Time (1/5 ms)');ylabel('Voltage (mV)');
    
end
%%
%using V1 and V6 to get the coronal plane
V1V6 = [percordLeads(6).aveBeat;percordLeads(1).aveBeat];
QRSon = 68;
QRSoff = 555;
Ton = 961;
Toff = 1615;

figure('DefaultAxesFontSize',18);clf();
hold on;
subplot(221);
scatter(V1V6(1,1:QRSon-1),V1V6(2,1:QRSon-1),'b');
%scatter(V1V6(1,Toff+1:end-400),V1V6(2,Toff+1:end-400),'b');
title('Pre and Post beat');xlabel('V6 X component (mV)');ylabel('V1 Z component (mV)');
subplot(222);
scatter(V1V6(1,QRSon:QRSoff),V1V6(2,QRSon:QRSoff),'r');
title('QRS');xlabel('V6 X component (mV)');ylabel('V1 Z component (mV)');
subplot(223);
scatter(V1V6(1,QRSoff+1:Ton-1),V1V6(2,QRSoff+1:Ton-1),'g');
title('ST Segment');xlabel('V6 X component (mV)');ylabel('V1 Z component (mV)');
subplot(224);
scatter(V1V6(1,Ton:Toff),V1V6(2,Ton:Toff),'c');
title('T wave');xlabel('V6 X component (mV)');ylabel('V1 Z component (mV)');

%%
QRSon = 125;
QRSoff = 228;
Ton = 343;
Toff = 521;
load('torso-geom.mat')
load('aligned-sitting.mat')
load('aligned-right.mat')
load('aligned-lying.mat')
load('aligned-left.mat')
run1.potvals = run1.potvals/1000;
run2.potvals = run2.potvals/1000;
run3.potvals = run3.potvals/1000;
run4.potvals = run4.potvals/1000;

xNodes = [53,137];
zNodes = [5,89];
yNodes = [85,96];

xVectorRun1 = run1.potvals(xNodes(2),:) - run1.potvals(xNodes(1),:);
yVectorRun1 = run1.potvals(yNodes(2),:) - run1.potvals(yNodes(1),:);
zVectorRun1 = run1.potvals(zNodes(2),:) - run1.potvals(zNodes(1),:);
Run1Vector = [xVectorRun1;yVectorRun1;zVectorRun1];


xVectorRun2 = run2.potvals(xNodes(2),:) - run2.potvals(xNodes(1),:);
yVectorRun2 = run2.potvals(yNodes(2),:) - run2.potvals(yNodes(1),:);
zVectorRun2 = run2.potvals(zNodes(2),:) - run2.potvals(zNodes(1),:);
Run2Vector = [xVectorRun2;yVectorRun2;zVectorRun2];

xVectorRun3 = run3.potvals(xNodes(2),:) - run3.potvals(xNodes(1),:);
yVectorRun3 = run3.potvals(yNodes(2),:) - run3.potvals(yNodes(1),:);
zVectorRun3 = run3.potvals(zNodes(2),:) - run3.potvals(zNodes(1),:);
Run3Vector = [xVectorRun3;yVectorRun3;zVectorRun3];

xVectorRun4 = run4.potvals(xNodes(2),:) - run4.potvals(xNodes(1),:);
yVectorRun4 = run4.potvals(yNodes(2),:) - run4.potvals(yNodes(1),:);
zVectorRun4 = run4.potvals(zNodes(2),:) - run4.potvals(zNodes(1),:);
Run4Vector = [xVectorRun4;yVectorRun4;zVectorRun4];

figure('DefaultAxesFontSize',18);clf();hold on;
subplot(221)
pcshow(Run1Vector(:,1:QRSon-1)','b','MarkerSize',25);
pcshow(Run1Vector(:,Toff+1:end)','b','MarkerSize',25);
xlabel('X component (mV)');ylabel('Y component (mV)');zlabel('Z component(mV)');
title('Pre and Post beat')
subplot(222)
pcshow(Run1Vector(:,QRSon:QRSoff)','r','MarkerSize',25);
xlabel('X component (mV)');ylabel('Y component (mV)');zlabel('Z component(mV)');
title('QRS')
subplot(223)
pcshow(Run1Vector(:,QRSoff+1:Ton-1)','g','MarkerSize',25);
xlabel('X component (mV)');ylabel('Y component (mV)');zlabel('Z component(mV)');
title('ST segment')
subplot(224)
pcshow(Run1Vector(:,Ton:Toff)','c','MarkerSize',25);
xlabel('X component (mV)');ylabel('Y component (mV)');zlabel('Z component(mV)');
title('T wave')
    
%%
figure('DefaultAxesFontSize',18);clf();hold on;
subplot(221)
pcshow(Run2Vector(:,1:QRSon-1)','b','MarkerSize',25);
pcshow(Run2Vector(:,Toff+1:end)','b','MarkerSize',25);
xlabel('X component (mV)');ylabel('Y component (mV)');zlabel('Z component(mV)');
title('Pre and Post beat')
subplot(222)
pcshow(Run2Vector(:,QRSon:QRSoff)','r','MarkerSize',25);
xlabel('X component (mV)');ylabel('Y component (mV)');zlabel('Z component(mV)');
title('QRS')
subplot(223)
pcshow(Run2Vector(:,QRSoff+1:Ton-1)','g','MarkerSize',25);
xlabel('X component (mV)');ylabel('Y component (mV)');zlabel('Z component(mV)');
title('ST segment')
subplot(224)
pcshow(Run2Vector(:,Ton:Toff)','c','MarkerSize',25);
xlabel('X component (mV)');ylabel('Y component (mV)');zlabel('Z component(mV)');
title('T wave')

%%
figure('DefaultAxesFontSize',18);clf();hold on;
subplot(221)
pcshow(Run3Vector(:,1:QRSon-1)','b','MarkerSize',25);
pcshow(Run3Vector(:,Toff+1:end)','b','MarkerSize',25);
xlabel('X component (mV)');ylabel('Y component (mV)');zlabel('Z component(mV)');
title('Pre and Post beat')
subplot(222)
pcshow(Run3Vector(:,QRSon:QRSoff)','r','MarkerSize',25);
xlabel('X component (mV)');ylabel('Y component (mV)');zlabel('Z component(mV)');
title('QRS')
subplot(223)
pcshow(Run3Vector(:,QRSoff+1:Ton-1)','g','MarkerSize',25);
xlabel('X component (mV)');ylabel('Y component (mV)');zlabel('Z component(mV)');
title('ST segment')
subplot(224)
pcshow(Run3Vector(:,Ton:Toff)','c','MarkerSize',25);
xlabel('X component (mV)');ylabel('Y component (mV)');zlabel('Z component(mV)');
title('T wave')

%%
figure('DefaultAxesFontSize',18);clf();hold on;
subplot(221)
pcshow(Run4Vector(:,1:QRSon-1)','b','MarkerSize',25);
pcshow(Run4Vector(:,Toff+1:end)','b','MarkerSize',25);
xlabel('X component (mV)');ylabel('Y component (mV)');zlabel('Z component(mV)');
title('Pre and Post beat')
subplot(222)
pcshow(Run4Vector(:,QRSon:QRSoff)','r','MarkerSize',25);
xlabel('X component (mV)');ylabel('Y component (mV)');zlabel('Z component(mV)');
title('QRS')
subplot(223)
pcshow(Run4Vector(:,QRSoff+1:Ton-1)','g','MarkerSize',25);
xlabel('X component (mV)');ylabel('Y component (mV)');zlabel('Z component(mV)');
title('ST segment')
subplot(224)
pcshow(Run4Vector(:,Ton:Toff)','c','MarkerSize',25);
xlabel('X component (mV)');ylabel('Y component (mV)');zlabel('Z component(mV)');
title('T wave')
