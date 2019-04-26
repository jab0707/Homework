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