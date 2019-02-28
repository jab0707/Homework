clear();fclose('all');
files = dir('JakeBram_DreamTeam_ECG/');
addpath('JakeBram_DreamTeam_ECG/');
for f = 11
    inFile = fopen(files(f).name,'rt');
    ln = fgetl(inFile);
    %The first line is the headder
    out.labels = ln;
    ln = fgetl(inFile);
    out.t = [];
    out.ch1 = [];
    out.ch2 = [];
    while ischar(ln)%While we still have lines to read
        if ~isempty(ln)%if we are not on an empty line
            ln = lower(ln);%Get it all in lower case
            ln = split(ln,',');
            vals = zeros(1,length(ln));
            for i =1:length(ln)
                vals(i) = str2double(ln{i});
            end
            
            out.t = [out.t;vals(1)];
            out.ch1 = [out.ch1;vals(2)];
            if length(vals) ==3
                out.ch2 = [out.ch2;vals(3)];
            end
            
            
        end
        ln = fgetl(inFile);
    end
    
    save(['Conv1/',files(f).name(1:end-3),'mat'],'out');
    fclose(inFile);
    
end
%%
clear;
%files = dir('Conv1/');
cd Conv1/

% for f = 4:length(files)
%     
%     load(files(f).name);
%     
%     ts.potvals = out.ch2';
%     clipIdxs = find(~isfinite(ts.potvals));
%     ts.potvals(clipIdxs) =  [];
%     ts.numleads = 1;
%     ts.numframes = size(ts.potvals,2);
%     ts.label = files(f).name(1:end-4);
%     ts.audit = '';
%     ts.filename = files(f).name;
%     ts.leadinfo = 0;
%     ts.unit = '';
%     save(['PotValOnly/',files(f).name],'ts');
% end
