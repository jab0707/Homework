%Script used for all figure generation for A6
%Author Jake Bergquist
warning("This function will clear the work space and close all figures")
fprintf("\nPress any key to continue\n");
pause;
clear
close all

vid1 = VideoReader('video1.avi');
framenum = vid1.Duration*vid1.FrameRate;
frames = cell(framenum,1);
for fr = 1:framenum
    frames{fr} = readFrame(vid1);
end
vid1.CurrentTime = 0; 
bckGrnd = CS6640_backgound(vid1);

fignum = 1;
gBckGrnd = rgb2gray(bckGrnd);
load('M1.mat');

imseg = CS6640_ac(M1,vid1);

gFrame11 = rgb2gray(frames{11});
figure(fignum);clf()
imshow(gFrame11);
title('Figure 1: Grayscale Frame 11');
fignum = fignum+1;

fr11SegOrig = gFrame11 .* uint8(imbinarize(rgb2gray(M1(11).cdata)));

figure(fignum);clf()
imshow(fr11SegOrig);
title('Figure 2: OriginalSegment');
fignum = fignum+1;

contourSeg = gFrame11 .* uint8(imseg(:,:,11));

figure(fignum);clf()
imshow(contourSeg);
title('Figure 3: Active Contours Segment');
fignum = fignum+1;

m = imbinarize(rgb2gray(M1(11).cdata));
edgeSegment = activecontour(gFrame11,m);

edgeIm = gFrame11 .* uint8(edgeSegment);

figure(fignum);clf()
imshow(edgeIm);
title('Figure 4: Active Contours Segment Edge mode');
fignum = fignum+1;


m = imbinarize(rgb2gray(M1(11).cdata));
fewIter = activecontour(gFrame11,m,50);%default is 100

fewIterIm = gFrame11 .* uint8(fewIter);

figure(fignum);clf()
imshow(fewIterIm);
title('Figure 5: Active Contours Segment fewer iterations');
fignum = fignum+1;


%Now on to level set

simpleCase = zeros(50:50);
simpleCase(15:35,15:35) = 255;%Add break point, go in and plot starting phi surf
figure(fignum);clf()
imshow(simpleCase);
title('Figure 6: Simple Case for level set');
fignum = fignum+1;

[simPhi,simTr] = CS6640_level_set(simpleCase,100,0.1,25,25);
fignum = fignum+1;
figure(fignum);clf()
surf(simPhi);
title('Figure 8: Final phi surf');
fignum = fignum+1;

figure(fignum);clf()
plot(simTr);
title('Figure 9: Tr value for each iteration');
xlabel('iteration');
ylabel('value');
fignum = fignum+1;

simpleMap = simPhi <= 0;
simpleMap = simpleMap(:);
maskIm = mask(simpleCase,simpleMap);


figure(fignum);clf()
imshow(maskIm);
title('Figure 10: Simple Case level set final region');
fignum = fignum+1;

fr11MovingCarLocation = [166,242];

[fr11Phi,fr11Tr] = CS6640_level_set(gFrame11,100,0.1,166,242);

figure(fignum);clf()
surf(fr11Phi);
title('Figure 11: Final phi surf');
fignum = fignum+1;

figure(fignum);clf()
plot(fr11Tr);
title('Figure 12: Tr value for each iteration');
xlabel('iteration');
ylabel('value');
fignum = fignum+1;

fr11Map = fr11Phi <= 0;
fr11Map = fr11Map(:);
maskIm = mask(gFrame11,fr11Map);


figure(fignum);clf()
imshow(maskIm);
title('Figure 13: Frame 11 level set final region');
fignum = fignum+1;
%Do it again with more iterations
[fr11Phi,fr11Tr] = CS6640_level_set(gFrame11,500,0.1,166,242);

figure(fignum);clf()
surf(fr11Phi);
title('Figure 14: Final phi surf');
fignum = fignum+1;

figure(fignum);clf()
plot(fr11Tr);
title('Figure 15: Tr value for each iteration');
xlabel('iteration');
ylabel('value');
fignum = fignum+1;

fr11Map = fr11Phi <= 0;
fr11Map = fr11Map(:);
maskIm = mask(gFrame11,fr11Map);


figure(fignum);clf()
imshow(maskIm);
title('Figure 16: Frame 11 level set final region');
fignum = fignum+1;


%Do it again witha  different starting place

[fr11Phi,fr11Tr] = CS6640_level_set(gFrame11,500,0.1,167,208);

figure(fignum);clf()
surf(fr11Phi);
title('Figure 17: Final phi surf');
fignum = fignum+1;

figure(fignum);clf()
plot(fr11Tr);
title('Figure 18: Tr value for each iteration');
xlabel('iteration');
ylabel('value');
fignum = fignum+1;

fr11Map = fr11Phi <= 0;
fr11Map = fr11Map(:);
maskIm = mask(gFrame11,fr11Map);


figure(fignum);clf()
imshow(maskIm);
title('Figure 19: Frame 11 level set final region');
fignum = fignum+1;

%way different location
[fr11Phi,fr11Tr] = CS6640_level_set(gFrame11,500,0.1,353,403);

figure(fignum);clf()
surf(fr11Phi);
title('Figure 20: Final phi surf');
fignum = fignum+1;

figure(fignum);clf()
plot(fr11Tr);
title('Figure 21: Tr value for each iteration');
xlabel('iteration');
ylabel('value');
fignum = fignum+1;

fr11Map = fr11Phi <= 0;
fr11Map = fr11Map(:);
maskIm = mask(gFrame11,fr11Map);


figure(fignum);clf()
imshow(maskIm);
title('Figure 22: Frame 11 level set final region');
fignum = fignum+1;

%Old location, many many iterations
[fr11Phi,fr11Tr] = CS6640_level_set(gFrame11,5000,0.1,167,208);

figure(fignum);clf()
surf(fr11Phi);
title('Figure 23: Final phi surf');
fignum = fignum+1;

figure(fignum);clf()
plot(fr11Tr);
title('Figure 24: Tr value for each iteration');
xlabel('iteration');
ylabel('value');
fignum = fignum+1;

fr11Map = fr11Phi <= 0;
fr11Map = fr11Map(:);
maskIm = mask(gFrame11,fr11Map);


figure(fignum);clf()
imshow(maskIm);
title('Figure 25: Frame 11 level set final region');
fignum = fignum+1;
%%
%Here with many iterations
[fr11Phi,fr11Tr] = CS6640_level_set(gFrame11,5000,0.1,353,403);

figure(fignum);clf()
surf(fr11Phi);
title('Figure 20: Final phi surf');
fignum = fignum+1;

figure(fignum);clf()
plot(fr11Tr);
title('Figure 21: Tr value for each iteration');
xlabel('iteration');
ylabel('value');
fignum = fignum+1;

fr11Map = fr11Phi <= 0;
fr11Map = fr11Map(:);
maskIm = mask(gFrame11,fr11Map);


figure(fignum);clf()
imshow(maskIm);
title('Figure 22: Frame 11 level set final region');
fignum = fignum+1;

%%

[fr11Phi,fr11Tr] = CS6640_level_set(medfilt2( medfilt2(gFrame11)),500,0.1,166,242);

figure(fignum);clf()
surf(fr11Phi);
title('Figure 26: Final phi surf');
fignum = fignum+1;

figure(fignum);clf()
plot(fr11Tr);
title('Figure 27: Tr value for each iteration');
xlabel('iteration');
ylabel('value');
fignum = fignum+1;

fr11Map = fr11Phi <= 0;
fr11Map = fr11Map(:);
maskIm = mask(gFrame11,fr11Map);


figure(fignum);clf()
imshow(maskIm);
title('Figure 28: Frame 11 level set final region');
fignum = fignum+1;
