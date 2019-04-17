%%
%Convert files for pfeifer
clear
close all
rawFiles = dir('RawData/');

for i = 1:length(rawFiles)
    
    if any(strfind(rawFiles(i).name,'.csv'))
        ts.potvals = csvread([rawFiles(i).folder,'/',rawFiles(i).name],1,1);
        ts.potvals = ts.potvals';
        save(['Convert/',rawFiles(i).name(1:end-3),'mat'],'ts');
    end
    
end