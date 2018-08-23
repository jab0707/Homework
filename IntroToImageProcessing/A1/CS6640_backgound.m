function im = CS6640_backgound(video)
% CS6640_background - extract background image from video sequence
% On input:
% video (video data structure): video sequence of k MxNx3 images
% On output:
% im (MxN array): image
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
im = frames;

end