%
%

files = dir('Recordings');
cd Recordings;
for ind = 1:length(files)
    if ~strcmp(files(ind).name,'.')&&~strcmp(files(ind).name,'..')&&~strcmp(files(ind).name,'Converted')
        
        currWav = audioread(files(ind).name);
        ts.potvals = currWav';
        save(string(['Converted\PreProcessed\',files(ind).name(1:end-4),'.mat']),'ts');
    end
    
end