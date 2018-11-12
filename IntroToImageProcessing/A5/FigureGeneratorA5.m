%Script used for all figure generation for A4
%Author Jake Bergquist
warning("This function will clear the work space and close all figures")
fprintf("\nPress any key to continue\n");
pause;
clear
close all

%Read video
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
figure(fignum);clf()
imshow(gBckGrnd);
title('Figure 1: Grayscale Background Image');
fignum = fignum+1;

frame11 = frames{11};
gFrame11 = rgb2gray(frame11);

figure(fignum);clf()
imshow(gFrame11);
title('Figure 2: Grayscale Frame 11');
fignum = fignum+1;

gdiff1 = gBckGrnd - gFrame11;

figure(fignum);clf()
imshow(gdiff1);
title('Figure 3: Gray Difference Image');
fignum = fignum+1;

%Get movie segmentations 
[M,frameStructs] = CS6640_MM(vid1);

%Frame 11 has a good car in it with a segmentation that could use improving

figure(fignum);clf();
imshow(M(11).cdata);
title("Figure 4: Outlined moving things frame 11");
fignum = fignum+1;

figure(fignum);clf();
imshow(frameStructs(11).movingThings);
title("Figure 5: Binary classification of the moving things frame 11");
fignum = fignum+1;

labeled = bwlabel(frameStructs(11).movingThings);
gr1 = (labeled == 1);

figure(fignum);clf();
imshow(gr1);
title("Figure 6: Focusing on the SUV on the road");
fignum = fignum+1;


%Get the bounding box
truckInds = find(gr1 == 1);
[truckInds(:,1),truckInds(:,2)] = ind2sub([480,640],truckInds);
bBoxUL = [min(truckInds(:,1)),min(truckInds(:,2))];
bBoxLR = [max(truckInds(:,1)),max(truckInds(:,2))];

%Cut the car out
smallImGr1 = gr1(bBoxUL(1):bBoxLR(1),bBoxUL(2):bBoxLR(2));
carIm = frame11(bBoxUL(1):bBoxLR(1),bBoxUL(2):bBoxLR(2),:);
outlinedCar = M(11).cdata(bBoxUL(1):bBoxLR(1),bBoxUL(2):bBoxLR(2),:);



figure(fignum);clf();

subplot(211);
imshow(carIm);
subplot(212);
imshow(outlinedCar);
subplot(211);
title("Figure 7: Focusing on the SUV on the road");
fignum = fignum+1;


grayTruck = rgb2gray(carIm);
grayTruck(smallImGr1==0) = 0;%Set the area around our original segmentation to 0

truckEdges1 = imfilter(grayTruck,fspecial('sobel'));
truckEdges2 = imfilter(grayTruck,fspecial('prewit'));
truckEdges3 = truckEdges1 + truckEdges2;
truckEdges3 = uint8((double(truckEdges3)/double(max(truckEdges3(:))))*255);
filt1 = strel('square',3);
cutOut = smallImGr1;
cutOut([1,45],:) = 0;%make sure the edges do not touch the edge of the image
cutOut(:,[1,102]) = 0;
cutOut = imerode(cutOut,filt1);
truckEdges3(cutOut==0) = 0;

%Look at the lines
figure(fignum);clf();
imshow(truckEdges3);
title("Figure 8: Lines of the SUV");
fignum = fignum+1;

binIm = imbinarize(truckEdges3);

binIm = imdilate(binIm,filt1);
binIm = imerode(binIm,filt1);
binIm = imerode(binIm,filt1);

[idx1,idx2] = find(binIm == 1);

lefColCut = min(idx1);
rightColCut = max(idx1);
topRowCut = min(idx2);
botRowCut = max(idx2);
%Trim by the bounding box of our lines
trimmedSegment  = smallImGr1;
trimmedSegment(1:lefColCut,:) = 0;
trimmedSegment(rightColCut:end,:) = 0;
trimmedSegment(:,1:topRowCut) = 0;
trimmedSegment(:,botRowCut:end) = 0;

trimmedTruck  = uint8(double(trimmedSegment).*double(grayTruck));

figure(fignum);clf();
subplot(211);
imshow(grayTruck);
subplot(212);
imshow(trimmedTruck);
subplot(211);
title("Figure 9: Trimmed truck segment");
fignum = fignum+1;


%Load in my hand segmented truth
gTruth = load('handSegmented.mat');
binGTruth = gTruth.cdata(:,:,1)>220;
gTrutharea = size(find(binGTruth==1));

figure(fignum);clf();
imshow(gTruth.cdata);
title("Figure 10: Hand Segmented");
fignum = fignum+1;


originalArea= size(find(smallImGr1==1));
trimedArea = size(find(trimmedSegment==1));
carLabels = [2,1,1,1,1,1,1,1,1,1,1,1,1,1,1];%Which label in each frame is the car we want
centCoords = [];
for ind = 1:15%the first 15 frames have a car moving accross
    labels = bwlabel(frameStructs(ind).movingThings);
    [rs,cls] = find(labels == carLabels(ind));
    centCoords(ind,1) = mean(rs);
    centCoords(ind,2) = mean(cls);
    
    
end
%Use cent coords to find hough line
centCoords = floor(centCoords);
houghIm = uint8(zeros(480,640));
for ind = 1:15
    houghIm(centCoords(ind,1),centCoords(ind,2)) = 1;
end
houghIm = (houghIm == 1);

[H,theta,rho] = hough(houghIm);
[mxv,mxIdx] = max(H(:));
[rhoIdx,thetaIdx]=ind2sub(size(H),mxIdx);

houghRho = rho(rhoIdx);
houghTheta = theta(thetaIdx);
%Plot the hough line
x = linspace(1,640,640);
y = (houghRho - (x*cosd(houghTheta)))/sind(houghTheta);

houghBackground = insertMarker(bckGrnd,[x;y]','circle','Color','r','Size',4);
movingCar = insertMarker(bckGrnd,[centCoords(:,2)';centCoords(:,1)']','circle','Color','r','Size',5);

figure(fignum);clf();
imshow(movingCar);
title("Figure 11: Centroids of 1 moving car");
fignum = fignum+1;

figure(fignum);clf();
imshow(houghBackground);
title("Figure 12: Hough Line of moving Car");
fignum = fignum+1;

figure(fignum);clf();
imshow(H);
title("Figure 12.1: Hough Accumulator Array");
fignum = fignum+1;

%Graph Cuts

subsectFrame11 = gFrame11(bBoxUL(1)-30:bBoxLR(1)+30,bBoxUL(2)-20:bBoxLR(2)+20);
subsectFrame11 = imfilter(subsectFrame11,fspecial('average',5));
subSectBckGrnd = gBckGrnd(bBoxUL(1)-30:bBoxLR(1)+30,bBoxUL(2)-20:bBoxLR(2)+20);
subSectBckGrnd = imfilter(subSectBckGrnd,fspecial('average',5));

subDiffIm = (subSectBckGrnd - subsectFrame11);

[grC,grV] = CS6640_GC(subDiffIm);
region1 = (grC == 1);%Which one we car about chages each time
%Because kmeans is random as to which group gets 1 v 2 each time. 
%This could change to grC == 2 depending
cleanedReg1 = imdilate(imerode(region1,ones(5,5)),ones(5,5));
gcSegment = subsectFrame11 .* uint8(cleanedReg1);

figure(fignum);clf();
imshow(subDiffIm);
title("Figure 13: Sub section diff im");
fignum = fignum+1;

figure(fignum);clf();
imshow(region1);
title("Figure 14: Graph cuts region 1");
fignum = fignum+1;
figure(fignum);clf();
imshow(cleanedReg1);
title("Figure 15: Cleaned up GC region 1");
fignum = fignum+1;

figure(fignum);clf();
imshow(gcSegment);
title("Figure 16: Segment from GC");
fignum = fignum+1;


%Water Shed
wsInput = imfilter(medfilt2(gdiff1),fspecial('gaussian'));
WS = CS6640_WS(wsInput);
mxGr = 0;
mxSpread = 0;
for ind = 1:max(WS(:))
    grIdx = find(WS == ind);
    currSpread = max(wsInput(grIdx))-min(wsInput(grIdx));
    if(currSpread > mxSpread)
        mxSpread = currSpread;
        mxGr = ind;
    end
    
end

figure(fignum);clf();
imshow(wsInput);
title("Figure 17: Watershed Input");
fignum = fignum+1;

figure(fignum);clf();
surf(wsInput,'FaceColor','b','EdgeColor','b');
title("Figure 18: Watershed Input surf");
fignum = fignum+1;

figure(fignum);clf();
imshow(WS == mxGr);
title("Figure 19: Deepest water shed");
fignum = fignum+1;

deepShed = (WS == mxGr);
frame11Mask = mask(frame11,deepShed(:));
difImMask = mask(wsInput,deepShed(:));

figure(fignum);clf();
imshow(frame11Mask);
title("Figure 20: Deepest water shed on bkcground");
fignum = fignum+1;

figure(fignum);clf();
imshow(difImMask);
title("Figure 21: Deepest water shed on diff im");
fignum = fignum+1;