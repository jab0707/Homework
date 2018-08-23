function CS6640_look_at_video(fname)
% CS6640_look_at_video - reads a video and displays it one frame at a time
% On input:
%     fname (string): name of video file
% On output:
%     only displays to figure
% Call:
%     CS6640_look_at_video('video.avi');
% Author:
%     T. Henderson
%     UU
%     Summer 2018
%

vidObj = VideoReader(fname);

while hasFrame(vidObj)
    vidFrame = readFrame(vidObj);
    imshow(vidFrame);
    input('Hit Return')
end