function im = CS6640_backgound(video)
% CS6640_background - extract background image from video sequence
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