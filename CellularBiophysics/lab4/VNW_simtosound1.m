function [sound_out] = VNW_simtosound1(directory, sig_L)
currents = dir(directory); %directory with only transmembrane i files
i_num = length(currents(:)); %number of files in directory
i_vecs = [];
for k = 1:i_num %input vector files into i_vecs
if currents(k).bytes == 0
continue
end
vec = textscan(fopen(currents(k).name),'%n %n','Headerlines',2);
vec = vec{1,2};
i_vecs = [i_vecs, vec];
end
i_total = sum(i_vecs,2); %sums all currents for each time point
sound_out = [];
for k = 1:sig_L %time to repeat signal (sig_L ~seconds)
sound_out = [sound_out;i_total];
end
sound(sound_out, 48000*0.05)%play audiofile
end