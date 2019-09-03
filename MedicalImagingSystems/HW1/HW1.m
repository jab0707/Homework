%Script to generate figures shown in HW 1
%Author: Jake Bergquist
%Aug 27 2019


%Problem 1

%Initilize matrices containing the x anbd y coordinates for each pixel
fig_yvals = zeros(256,256);
fig_xvals = fig_yvals;
for ind = 1:256
    fig_yvals(ind,:) = -ones(1,256)*ind;
    fig_xvals(:,ind) = ones(1,256)*ind;
end

%functions to define the lines defined at the end of the script
figTriangle = ((fig_yvals >= line1(fig_xvals)) +...
              (fig_yvals <= line2(fig_xvals)) +...
              (fig_yvals <= line3(fig_xvals))) == 3;
          
figure(1);
imshow(figTriangle);


%plotblem 2

f_handle = fopen('Prob2.raw');
raw_signal = fread(f_handle,[144,192]);
fclose(f_handle);
figure(1);clf();
surf(raw_signal)
set(gca, 'ZScale', 'log')

figure(2);clf()
imshow(rescale(raw_signal));










function y = line1(x)
%v1 v2 line (line 1)
%y = -174
y = -174*ones(size(x));
end

function y = line2(x)
%v1 v3 line (line 2)
%y = (138/80)x - 256.8
y = (138/80).*x - 256.8;
end

function y = line3(x)
%v2 v3 line (line3)
%y = -(138/80)x + 184.8
y = -(138/80).*x + 184.8;
end
