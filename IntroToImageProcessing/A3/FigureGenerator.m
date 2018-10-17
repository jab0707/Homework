%This function was used to generate all figures for this assignment

warning("This function will clear the work space and close all figures")
fprintf("\nPress any key to continue\n");
pause;
clear
close all

%Load up the video
vidObj = VideoReader('video/video.avi');
vidObj.CurrentTime = 0;
numFrames = vidObj.Framerate * vidObj.Duration;%Extract the number of frames in out video
frames = cell(numFrames,1);%Initilize empty cell array to hold all of our frames
for frameInd = 1:numFrames%For each frame, extract it from the video
frames{frameInd} = readFrame(vidObj);
end

%Take the 3rd frame for all examples
im = frames{3};
figNum = 1;
figure(figNum);
clf;
imshow(im);
title('Figure 1: Frame 3 of Video');
figNum = figNum+1;
gIm = rgb2gray(im);
figure(figNum);clf();
imshow(gIm);
title('Figure 1.1: Frame 3 in grayscale');
figNum = figNum+1;

%Now we do our first anaysis with the FFT textures.
T = CS6640_FFT_texture(gIm);
groups1 = kmeans(T,5);%Lets try 5 textures first
groups1Mask = mask(gIm,groups1);

%For our groups the mask function uses these colors. We need a figure to
%identify them.
vals = [1,1,1,1,1,1,1];
labels = categorical({'Group 1','Group 2','Group 3','Group 4','Group 5','Group 6','Group 7'});
cmap = [0,0,255;
    0,255,0;
    255,0,0;
    255,128,0;
    0,255,255;
    255,0,255;
    255,0,127;]/255;
figure(figNum);clf();
hold on;
for i = 1:length(vals)
    b = bar(labels(i),vals(i),"FaceColor",cmap(i,:),"BarWidth",1);
end
set(gca,'YTickLabel',[]);
title('Figure1.1, Group Coloring');
hold off;
figNum = figNum+1;

figure(figNum);clf();
imshow(groups1Mask);
title('Figure 2: 5 groups, FFT texture');
figNum = figNum+1;


groups2 = kmeans(T,3);%Lets try 3 textures first
groups2Mask = mask(gIm,groups2);

figure(figNum);clf();
imshow(groups2Mask);
title('Figure 3: 3 groups, FFT texture');
figNum = figNum+1;

groups3 = kmeans(T,7);%Lets try 7 textures first
groups3Mask = mask(gIm,groups3);

figure(figNum);clf();
imshow(groups3Mask);
title('Figure 4: 7 groups, FFT texture');
figNum = figNum+1;


%-------------------------------------------------------------------------
%On to the ring based textures

ringT = CS6640_FFT_radial(gIm);

rings1 = kmeans(ringT,5);
rings1Mask = mask(gIm,rings1);

figure(figNum);clf();
imshow(rings1Mask);
title('Figure 5: 5 groups, radial FFT');
figNum = figNum+1;

rings2 = kmeans(ringT,7);
rings2Mask = mask(gIm,rings2);

figure(figNum);clf();
imshow(rings2Mask);
title('Figure 6: 7 groups, radial FFT');
figNum = figNum+1;

%Lets look just at groups 3 and 4 from that one
rings2_1 = and(rings2 > 2,rings2 < 5).*rings2;

rings2_1Mask = mask(gIm,rings2_1);

figure(figNum);clf();
imshow(rings2_1Mask);
title('Figure 7: 7 groups, g3 and g4 shown, radial FFT');
figNum = figNum+1;


%------------------------------------------------------------------------
%Now angular

angleT_L5 = CS6640_FFT_angular(gIm);%This with L = 5;
%To change L I went and changed it on line 15

angle1 = kmeans(angleT_L5,5);

angle1Mask = mask(gIm,angle1);

figure(figNum);clf();
imshow(angle1Mask);
title('Figure 9: 5 groups, angular FFT, L = 5');
figNum = figNum+1;

%Now change L, must have break point enabled here
angleT_L10 = CS6640_FFT_angular(gIm);%This with L = 9, must go change;
%To change L I went and changed it on line 15, L must be odd

angle2 = kmeans(angleT_L10,5);

angle2Mask = mask(gIm,angle2);

figure(figNum);clf();
imshow(angle2Mask);
title('Figure 10: 5 groups, angular FFT, L = 9');
figNum = figNum+1;

%-----------------------------------------------------------------------
%Curve finding
%Load O and H
H = CS6640_gen_H;
O = CS6640_gen_O;

HShape1 = CS6640_FFT_shape(H,1);
OShape1 = CS6640_FFT_shape(O,1);

figure(figNum);clf();
hold on;
subplot(211);
scatter([1:length(HShape1)],HShape1)
subplot(212);
scatter([1:length(OShape1)],OShape1);
title('O shape:');
subplot(211);
title('Figure 11: Shape vectors. H Shape:');
hold off
figNum = figNum+1;

HShape2 = CS6640_FFT_shape(H,2);
OShape2 = CS6640_FFT_shape(O,2);



figure(figNum);clf();
hold on;
subplot(211);
scatter([1:length(HShape2)],HShape2)
subplot(212);
scatter([1:length(OShape2)],OShape2);
title('O shape:');
subplot(211);
title('Figure 12: Shape vectors. H Shape:');
hold off
figNum = figNum+1;
