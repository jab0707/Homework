% %%
% %Convert files
% clear
% close all
% rawFiles = dir('Data/Part_I');
% 
% for i = 1:length(rawFiles)
%     
%     if any(strfind(rawFiles(i).name,'.csv'))
%         ts.potvals = csvread([rawFiles(i).folder,'/',rawFiles(i).name],1,1);
%         ts.potvals = ts.potvals';
%         save(['Convert/T1_',rawFiles(i).name(1:end-3),'mat'],'ts');
%     end
%     
% end
% 
% rawFiles = dir('Data/Part_II');
% 
% for i = 1:length(rawFiles)
%     
%     if any(strfind(rawFiles(i).name,'.csv'))
%         ts.potvals = csvread([rawFiles(i).folder,'/',rawFiles(i).name],1,1);
%         ts.potvals = ts.potvals';
%         save(['Convert/T2_',rawFiles(i).name(1:end-3),'mat'],'ts');
%     end
%     
% end
%%
%Calibration curve #1
clear;
close all

%%
files = dir ('Convert');
c1 = 1;
c2 = 1;
for i = 1:length(files)
    
    if any(strfind(files(i).name,'T1'))
        load(files(i).name);
        T1(c1).signal = ts.potvals;
        T1(c1).signal(isnan(T1(c1).signal)) = [];
        T1(c1).name = files(i).name(1:end-4);
        c1 = c1+1;
    end
    
    if any(strfind(files(i).name,'T2'))
        load(files(i).name);
        T2(c2).signal = ts.potvals;
        T2(c2).signal(isnan(T2(c2).signal)) = [];
        T2(c2).name = files(i).name(1:end-4);
        c2 = c2 + 1;
    end
    
end

%%
%The first 12 are processing

for i =1:12
    
    cal1(i,1) = max(T1(i).signal);
    cal1(i,2) = min(T1(i).signal);
    cal1(i,3) = str2double(T1(i).name(4:end-2));
    cal1(i,4) = cal1(i,1)-cal1(i,2);
    
    
    cal2(i,1) = max(T2(i).signal);
    cal2(i,2) = min(T2(i).signal);
    cal2(i,3) = str2double(T2(i).name(4:end-2));
    cal2(i,4) = cal2(i,1)-cal2(i,2);
end

[~,ind] = sort(cal1(:,3));
cal1(:,:) = cal1(ind,:);

slope1 =mean(cal1(:,4)./cal1(:,3));

for i = 1:length(T1)
     T1(i).v_signal = -(T1(i).signal-mean(T1(i).signal(1:3)))/slope1;
end



[~,ind] = sort(cal2(:,3));
cal2(:,:) = cal2(ind,:);

slope2 = mean(cal2(:,4)./cal2(:,3));

for i = 1:length(T2)
     T2(i).v_signal = -(T2(i).signal-mean(T2(i).signal(1:3)))/slope2;

end

%%

figure('DefaultAxesFontSize',18);clf();hold on;plot(T1(13).v_signal,'b','linewidth',2);
title('Spirometry Trial');xlabel('Time (ms)');ylabel('Volume (mL)');
figure('DefaultAxesFontSize',18);clf();hold on;plot(T1(14).v_signal,'b','linewidth',2);
title('Spirometry Trial');xlabel('Time (ms)');ylabel('Volume (mL)');
figure('DefaultAxesFontSize',18);clf();hold on;plot(T1(15).v_signal,'b','linewidth',2);
title('Spirometry Trial');xlabel('Time (ms)');ylabel('Volume (mL)');
figure('DefaultAxesFontSize',18);clf();hold on;plot(T1(16).v_signal,'b','linewidth',2);
title('Spirometry Trial');xlabel('Time (ms)');ylabel('Volume (mL)');
%%
[maxes,maxInds] = findpeaks(T1(13).v_signal,'MinPeakProminence',50,'MinPeakDistance',500);
mins = -findpeaks(-T1(13).v_signal,'MinPeakProminence',50,'MinPeakDistance',500);

restInspire = (mean(maxes(1:3)));
restExpire = (mean(mins(1:4)));

tidalVolume = restInspire - restExpire;

InspiratoryReserve = maxes(4) - restInspire;

InspiratoryCapacity = maxes(4) - restExpire;

VitalCapacity = maxes(4) - mins(5);

ExpiratoryReserve = VitalCapacity - InspiratoryCapacity;

FEOV = T1(13).v_signal(maxInds(4)) - min(T1(13).v_signal(maxInds(4):maxInds(4)+1000));


%%
close all
highO2 = [98,101,3,32,91,51,11;99,103,9,39,83,54,9;99,101,12,40,79,62,11;99,104,18,40,76,67,9;99,104,27,43,73,68,7;99,101,34,45,71,68,7;99,106,40,48,69,67,7;99,99,50,46,68,67,NaN;99,101,53,53,66,66,NaN;99,106,53,53,65,65,NaN;99,106,59,59,64,64,NaN;99,105,62,62,62,62,NaN];

RoomAir = [97,120,0,0,21,21,NaN;98,120,2,35,19,15,13;98,112,3,37,18,12,11;95,116,4,37,16,11,12;95,120,5,37,14,10,13;91,112,6,33,12,9,14;89,120,6,31,10,7,15];

o2Peaks = findpeaks(T2(13).v_signal,'MinPeakProminence',40,'MinPeakDistance',400);
o2Mins = -findpeaks(-T2(13).v_signal,'MinPeakProminence',40,'MinPeakDistance',400);
o2Tidal = o2Peaks - o2Mins;
figure('DefaultAxesFontSize',18);clf();hold on;plot(o2Tidal,'b','linewidth',2);
title('High O2 Tidal Volume');xlabel('Time');ylabel('Volume (mL)');


roomPeaks = findpeaks(T2(14).v_signal,'MinPeakProminence',40,'MinPeakDistance',400);
roomMins = -findpeaks(-T2(14).v_signal,'MinPeakProminence',40,'MinPeakDistance',400);
roomTidal = roomPeaks - roomMins;

figure('DefaultAxesFontSize',18);clf();hold on;plot(roomTidal,'b','linewidth',2);
title('CO2 Scrub Tidal Volume');xlabel('Time');ylabel('Volume (mL)');


o2Time = 0:30:30*11;
figure('DefaultAxesFontSize',18);clf();hold on;
subplot(3,2,1);
plot(o2Time,highO2(:,1),'b','linewidth',2);
title('A');xlabel('Time (s)');ylabel('SPO2');

subplot(3,2,2);hold on;
plot(o2Time,highO2(:,2),'b','linewidth',2);
title('B');xlabel('Time (s)');ylabel('HR');

subplot(3,2,3);hold on;
plot(o2Time,highO2(:,3),'b','linewidth',2);
plot(o2Time,highO2(:,4),'g','linewidth',2);
title('C');xlabel('Time (s)');ylabel('CO2 Concentration');

subplot(3,2,4);hold on;
plot(o2Time,highO2(:,5),'b','linewidth',2);
plot(o2Time,highO2(:,6),'g','linewidth',2);
title('D');xlabel('Time (s)');ylabel('O2 Concentration');

subplot(3,2,5);hold on;
plot(o2Time,highO2(:,7),'b','linewidth',2);
title('E');xlabel('Time (s)');ylabel('Breath Rate');


rTime = 0:30:30*6;
figure('DefaultAxesFontSize',18);clf();hold on;
subplot(3,2,1);
plot(rTime,RoomAir(:,1),'b','linewidth',2);
title('A');xlabel('Time (s)');ylabel('SPO2');

subplot(3,2,2);hold on;
plot(rTime,RoomAir(:,2),'b','linewidth',2);
title('B');xlabel('Time (s)');ylabel('HR');

subplot(3,2,3);hold on;
plot(rTime,RoomAir(:,3),'b','linewidth',2);
plot(rTime,RoomAir(:,4),'g','linewidth',2);
title('C');xlabel('Time (s)');ylabel('CO2 Concentration');

subplot(3,2,4);hold on;
plot(rTime,RoomAir(:,5),'b','linewidth',2);
plot(rTime,RoomAir(:,6),'g','linewidth',2);
title('D');xlabel('Time (s)');ylabel('O2 Concentration');

subplot(3,2,5);hold on;
plot(rTime,RoomAir(:,7),'b','linewidth',2);
title('E');xlabel('Time (s)');ylabel('Breath Rate');