function [sound_out] = VNW_simtosound2(directory1,directory2,sig_L)
currents(1,:) = dir(directory1); %directory for cell 1
currents(2,:) = dir(directory2); %directory for cell 2
i_num(1) = length(currents(1,:)); %number of files in cell 1 dir
i_num(2) = length(currents(2,:)); %number of files in cell 2 dir
i_vecs{1} = [];
i_vecs{2} = [];
for i = 1:2
for k = 1:i_num(i) %input vector files into i_vecs
if currents(i,k).bytes == 0
continue
end
vec = textscan(fopen(currents(i,k).name),'%n %n','Headerlines',2);
vec = vec{1,2};
i_vecs{i} = [i_vecs{i}, vec];
end
i_total{i} = sum(i_vecs{i},2); %sums all currents for each time point
end
i_total = cell2mat(i_total);
sound_out = [];
for k = 1:sig_L %time to repeat signal (sig_L ~seconds)
sound_out = [sound_out;i_total];
end
sound(sound_out, 48000*0.05)%play audiofile
end