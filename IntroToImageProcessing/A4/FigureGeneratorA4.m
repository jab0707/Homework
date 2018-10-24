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


%I generated the next few figures by adding stops to the MM function and
%plotting intermediate steps in the process
%%
M = CS6640_MM(vid1);
%One figure was for plotting the processed images
%one was for plotting the resulting outlined segmentation
%fignum = fignum +2;

figure(fignum);clf();
imshow(M(1).cdata);
title("Figure 8: Outlined moving things frame 1");
fignum = fignum+1;


figure(fignum);clf();
imshow(M(2).cdata);
title("Figure 9: Outlined moving things frame 2");
fignum = fignum+1;


%Look there is a moving person
figure(fignum);clf();
imshow(M(12).cdata);
title("Figure 10: Outlined moving things frame 12");
fignum = fignum+1;


dat = CS6640_object_data(M,vid1);
[objs(1),objs(2),objs(3)] = dat([1,2,12]).num_objects;
names = {'Frame1','Frame2','Frame12'};
table(names',objs','VariableNames',{'Frame','NumObjects'})


%Looking at frame 12
[areas(1),areas(2),areas(3),areas(4),areas(5)] = dat(12).objects(1:5).num_pixels;
[rmed(1),rmed(2),rmed(3),rmed(4),rmed(5)] = dat(12).objects(1:5).red_median;
[bmed(1),bmed(2),bmed(3),bmed(4),bmed(5)] = dat(12).objects(1:5).blue_median;
[gmed(1),gmed(2),gmed(3),gmed(4),gmed(5)] = dat(12).objects(1:5).green_median;
[cmean(1),cmean(2),cmean(3),cmean(4),cmean(5)] = dat(12).objects(1:5).col_mean;
[rmean(1),rmean(2),rmean(3),rmean(4),rmean(5)] = dat(12).objects(1:5).row_mean;

names = {'Obj1','Obj2','Obj3','Obj4','Obj5'};
table(names',areas',rmed',gmed',bmed',cmean',rmean','VariableNames',...
    {'Object','NumPixels','redMedian','greenMedian','blueMedian',...
    'columnMean','rowMean'})


%Watch the Movie
figure(fignum);movie(M)