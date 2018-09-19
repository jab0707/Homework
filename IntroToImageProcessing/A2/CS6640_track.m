function [M,tracks] = CS6640_track(video)
% CS6640_track - track motion in a video
% On input:
%   video (video structure): input video
% On output:
%   M (movie structure): movie of detected differences
%   in video
%   tracks (kx2 array): row,col center of mass of largest
%   moving object in sequential video frames
% Call:
%   [M,tr] = CS6640_track(video);
% Author:
% 	Jake Bergquist
%   UU
%   Fall 2018
bckGround = Get_backgound(video);
grayBack = rgb2gray(bckGround);

video.CurrentTime = 0;%Ensure that the current time is set to 0

numFrames = video.Framerate * video.Duration;%Extract the number of frames in out video
frames = cell(numFrames,1);%Initilize empty cell array to hold all of our frames
for frameInd = 1:numFrames%For each frame, extract it from the video
    frames{frameInd} = readFrame(video);
end
imSz = size(frames{1});
outFrames = zeros(imSz(1),imSz(2),3,numFrames);
tracks = zeros(numFrames,2);
for fr = 1:length(frames)
    compCords1 = [];
    compCords2 = [];
    currentFrame = rgb2gray(frames{fr});
    currentFrameColor = frames{fr}; 
    backSubtract = currentFrame - grayBack;
    threshIm = backSubtract > (max(backSubtract(:))/2);
    erodeIm = imerode(threshIm,[0,1,0;1,1,1;0,1,0]);
    conComp = bwconncomp(erodeIm);

    if conComp.NumObjects >= 1
        szs = zeros(1,length(conComp.PixelIdxList));
        for comp = 1:length(conComp.PixelIdxList)
            szs(comp) = length(conComp.PixelIdxList{comp});
        end
        [~,ind] = sort(szs);

        comp1 = conComp.PixelIdxList{ind(length(ind))};
        [compCords1(:,2),compCords1(:,1)] = ind2sub(imSz(1:2),comp1);
        cent1 = round(mean(compCords1,1));
        if length(ind) > 1
            comp2 = conComp.PixelIdxList{ind(length(ind)-1)};
            [compCords2(:,1),compCords2(:,2)] = ind2sub(imSz(1:2),comp2);
            cent2 = round(mean(compCords2,1));

            dist = norm(double(cent1-cent2));
            if dist < 20
                centMain = mean([cent1;cent2]);
            else
                centMain = cent1;
            end
        else
            centMain = cent1;
        end
    else
        centMain = [0,0];
        outFr = currentFrameColor;
    end   
    outFr = insertMarker(currentFrameColor,floor(centMain),'o','color','r','size',4);
    outFrames(:,:,:,fr) = outFr;
    tracks(fr,:) = floor(centMain);

end
M = immovie(uint8(outFrames));
end




function im = Get_backgound(video)
% copy of CS6640_background - extract background image from video sequence
% On input:
%   video (video data structure): video sequence of k MxNx3 images
% On output:
%   im (MxN array): image
% Call:
%   im = CS4640_background(v);
% Author:
%   Jake Bergquist
% UU
% Fall 2018
%

video.CurrentTime = 0;%Ensure that the current time is set to 0

numFrames = video.Framerate * video.Duration;%Extract the number of frames in out video
frames = cell(numFrames,1);%Initilize empty cell array to hold all of our frames
for frameInd = 1:numFrames%For each frame, extract it from the video
    frames{frameInd} = readFrame(video);
end
%The easist way to get the background of the video would be to take the
%mode for each pixle's rgb values. To do so we first have to extract the
%RGB from each frame
%initilize the matricies to hold the rgbs for each frame
reds = zeros(size(frames{1},1),size(frames{1},2),length(frames));
greens = reds;
blues = reds;
for frameInd = 1:length(frames)%For each frame
    curFrame = frames{frameInd};%Save that frame
    reds(:,:,frameInd) = curFrame(:,:,1);%Get the red slice for that frame
    greens(:,:,frameInd) = curFrame(:,:,2);%and the green
    blues(:,:,frameInd) = curFrame(:,:,3);%and the blue
end

%Now that we have the RGBs we will extract the mode for each pixle for each
%color value
redMode = mode(reds,3);%Get the red mode
greenMode = mode(greens,3);%Get the green mode
blueMode = mode(blues,3);%Blue mode

%Now we reconstruct the three colors into the final background image
im = [];
im(:,:,1) = redMode;
im(:,:,2) = greenMode;
im(:,:,3) = blueMode;
im = uint8(im); %Make sure we convert back to int8 because mode likely converted to double

end