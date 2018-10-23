%Script used for all figure generation for A4
%Author Jake Bergquist
warning("This function will clear the work space and close all figures")
fprintf("\nPress any key to continue\n");
pause;
clear
close all

%For this assign,ment I will also show most (not all) of my testing code
%for the development of the two functions as that testing code will be used
%to generate some of the intermediate figures, but it will not be present
%in the final versions of the functions.

vid1 = VideoReader('video1.avi');
framenum = vid1.Duration*vid1.FrameRate;
frames = cell(framenum,1);
for fr = 1:framenum
    frames{fr} = readFrame(vid1);
end
vid1.CurrentTime = 0; 
bckGrnd = CS6640_backgound(vid1);

fignum = 1;

figure(fignum);clf()
imshow(bckGrnd);
title('Figure 1.1: Background Image');
fignum = fignum+1;

gBckGrnd = rgb2gray(bckGrnd);
figure(fignum);clf()
imshow(gBckGrnd);
title('Figure 1.2: Grayscale Background Image');
fignum = fignum+1;

frame1 = frames{1};
gFrame1 = rgb2gray(frame1);

figure(fignum);clf()
imshow(frame1);
title('Figure 2.1: Frame 1');
fignum = fignum+1;

figure(fignum);clf()
imshow(gFrame1);
title('Figure 2.2: Grayscale Frame 1');
fignum = fignum+1;

diff1 = bckGrnd - frame1;
gdiff1 = gBckGrnd - gFrame1;

figure(fignum);clf()
imshow(diff1);
title('Figure 3: Difference Image');
fignum = fignum+1;

figure(fignum);clf()
imshow(gdiff1);
title('Figure 4: Gray Difference Image');
fignum = fignum+1;


%Don't really see a difference in the two difference images, in fact when I
%subtract them I get no difference at all so we will go with using the
%gimage diff for now

%Threshold
threshold = 50;
binImage = imbinarize(gdiff1,threshold/255);

figure(fignum);clf()
imshow(binImage);
title('Figure 5: Threshold of Diff Image');
fignum = fignum+1;

filt = strel('square',5);
processed = imerode(imdilate(binImage,filt),filt);



