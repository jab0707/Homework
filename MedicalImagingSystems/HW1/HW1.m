%Script to generate figures shown in HW 1
%Author: Jake Bergquist
%Aug 27 2019
clear
close all
clf

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
title('Matlab Drawn Triangle')

%%
%plotblem 2

f_handle = fopen('Prob2.raw');%access the file location
raw_signal = fread(f_handle,[288,192],'float',0,'b');
%read in both the real and imaginary components at once
fclose(f_handle);
%Need to parse the input to be the complex matrix
raw_signal = [raw_signal(1:2:end,:) + raw_signal(2:2:end,:)*1i];
%Every second entry int he raw file is the previous entry's complex value

%Plotting the magintue of the signal as a surface
figure(1);clf();
surf((log(abs(raw_signal)))')%during all visualizations the data is transposed
axis('equal')
axis('tight')
%%
%Showing the magnitude of the signal as grayscale
figure(2);clf()
imshow(rescale(log(abs(raw_signal)))');
axis('equal')
axis('tight')


%%
%reconstructing the image using inverse transform
MRI_Image = ifftshift(abs(ifft2(raw_signal)));

%Reconstructing using the forward transform
MRI_Image_Forward_FT = ifftshift(abs(fft2(raw_signal)));
figure(4);
subplot(121);
imagesc(MRI_Image')
axis('equal')
axis('tight')
title('Inverse Reconstruction')
colormap(gray);
subplot(122);
imagesc(MRI_Image')
axis('equal');
axis('tight')
title('Forward Reconstruction')
colormap(gray);



%%
%problem 3




Segmented_MRI = rescale(MRI_Image);
%The image needs to be scaled between 0 to 255 so I can hilight the ROIs

close all
figure(1);
imshow(Segmented_MRI')
axis('equal')
axis('tight')
impixelinfo%adds tool to the figure to inspect pixel locations and values

%%
%selecting background section. We will grab a section of the background
%outside of the head in the top corner near the origin. The first 20 x 20
%patch of any of the corners will do

background = MRI_Image(1:20,1:20);
backgroundSegment = Segmented_MRI(1:20,1:20);%For vis purposes
Segmented_MRI(1:20,1:20) = 255;%Outline the backgound ROI
Segmented_MRI(2:19,2:19) = backgroundSegment(2:19,2:19);

%three regions of interest are chosen from the white matter
r1_coords = [50,50,54,54];
r1_vals = MRI_Image(r1_coords(1):r1_coords(3),r1_coords(2):r1_coords(4));
r1_vals_segment = Segmented_MRI(r1_coords(1):r1_coords(3),r1_coords(2):r1_coords(4));%For vis purposes
Segmented_MRI(r1_coords(1):r1_coords(3),r1_coords(2):r1_coords(4),1) = 0;%Color the ROI Black
%replace the center to make a black box outlining the ROI
Segmented_MRI(r1_coords(1)+1:r1_coords(3)-1,r1_coords(2)+1:r1_coords(4)-1) = r1_vals_segment(2:end-1,2:end-1);



r2_coords =[45,120,49,124];% [120,45,124,49];
r2_vals = MRI_Image(r2_coords(1):r2_coords(3),r2_coords(2):r2_coords(4));
r2_vals_segment = Segmented_MRI(r2_coords(1):r2_coords(3),r2_coords(2):r2_coords(4));%For vis purposes
Segmented_MRI(r2_coords(1):r2_coords(3),r2_coords(2):r2_coords(4),1) = 0;%Color the ROI Black
%replace the center to make a black box outlining the ROI
Segmented_MRI(r2_coords(1)+1:r2_coords(3)-1,r2_coords(2)+1:r2_coords(4)-1) = r2_vals_segment(2:end-1,2:end-1);

r3_coords =[100,125,104,129];% [125,100,129,104];
r3_vals = MRI_Image(r3_coords(1):r3_coords(3),r3_coords(2):r3_coords(4));
r3_vals_segment = Segmented_MRI(r3_coords(1):r3_coords(3),r3_coords(2):r3_coords(4));%For vis purposes
Segmented_MRI(r3_coords(1):r3_coords(3),r3_coords(2):r3_coords(4),1) = 0;%Color the ROI Black
%replace the center to make a black box outlining the ROI
Segmented_MRI(r3_coords(1)+1:r3_coords(3)-1,r3_coords(2)+1:r3_coords(4)-1) = r3_vals_segment(2:end-1,2:end-1);
h = figure(1);
imshow(Segmented_MRI');
axis('equal')
axis('tight')


%Calculate SNR
background_STD = std2(background);

snr_1 = mean(r1_vals(:))/background_STD;
snr_2 = mean(r2_vals(:))/background_STD;
snr_3 = mean(r3_vals(:))/background_STD;
mean_snr = mean([snr_1,snr_2,snr_3]);


%%
%problem 4

%The center 50% would be the center 72x96
center_raw = raw_signal(37:36+72,49:48+96);
MRI_Image_center_subset = ifftshift(abs(ifft2(center_raw)));


everyOther_raw = raw_signal(1:2:end,1:2:end);
MRI_Image_everyOther_subset = ifftshift(abs(ifft2(everyOther_raw)));


figure(1);
subplot(121);
imagesc(MRI_Image_center_subset')
axis('equal')
axis('tight')
title('Inner 50%');
colormap(gray);
subplot(122);
imagesc(MRI_Image_everyOther_subset')
axis('equal');
axis('tight')
title('Every Other');
colormap(gray);


%%
%Problem 5


close all;
%kernal a
averaging_kernal = ones(3,3)/9;

%kernal b
%orientation flipped due to matlab conventions
vertical_edge_detector = zeros(3,3);
vertical_edge_detector(:,3) = 1;
vertical_edge_detector(:,1) = -1;

%kernal c
%orientation flipped due to matlab conventions
horizontal_edge_detector = zeros(3,3);
horizontal_edge_detector(1,:) = 1;
horizontal_edge_detector(3,:) = -1;



conv1_results = conv2(MRI_Image,averaging_kernal,'same');
%I use the same argument to not get increased image size
%It does however leave in zero padded edges in the calculation but the
%edges are all background and I do not mind as much there

conv2_results = conv2(MRI_Image,vertical_edge_detector,'same');

conv3_results = conv2(MRI_Image,horizontal_edge_detector,'same');

figure(1);
subplot(2,2,1);
imagesc(MRI_Image')
axis('equal')
axis('tight')
colormap(gray);
title('Original')
subplot(222);
imagesc(conv1_results')
axis('equal')
axis('tight')
colormap(gray);
title('3x3 Average')
subplot(223);
imagesc(conv2_results')
axis('equal')
axis('tight')
colormap(gray);
title('Vertical edge detector')
subplot(224);
imagesc(conv3_results')
axis('equal')
axis('tight')
colormap(gray);
title('Horizontal edge detector')

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
