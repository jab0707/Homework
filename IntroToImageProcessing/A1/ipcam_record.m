function ipcam_record(address, time, output_path)
% ipcam_record - get a video and set of images and save to folder
% On input:
%     address (string): address of stream to be recorded
%        for CS6640: 'http://155.98.69.241:7788/stream/video.mjpeg'
%     time (int): number of seconds to record (not well calibrated)
%     output_path (string): name of folder to put data folders into
% On output:
%     A folder is created with a date/time stamp and a subfolder with data
% Call:
%     ipcam_record('http://155.98.69.241:7788/stream/video.mjpeg',5,'.');
% Author:
%     Taylor Welker
%     UU
%     Summer 2018
%

cam = ipcam(address);            % Store the ipcam object in 'cam'
framerate = 15;                 % The camera we use is recording at 15 fps
NUM_FRAMES = time*framerate;    % Calculate the number of frames we want

images = {};                    % This holds all of the images captured
timestamps = [];                % This holds the timestamp for each image captured

% For each frame you capture
for snap = 1:NUM_FRAMES
    [img, ts] = snapshot(cam);  % Capture the image and time metadata
    images{snap} = img;         % Store the image in the list
    d = datestr(ts, 'mm-dd-yy_HH-MM-SS-FFF'); % convert the metadata to the proper format
    timestamps = [timestamps;d];% Store the metadata in the timestamps list
end

sampledate = timestamps(1,:);            % Grab the date and time of the recording
dateAndTime = strsplit(sampledate, '_'); % Get ready to parse the date
date = dateAndTime(1);                   % Get the date
mkdir(sprintf('%s/',output_path),sprintf('%s', date{1})); % Make the folder to hold the data using the date

newFolderName = timestamps(1,:); % Get the time to further separate the data
mkdir(sprintf('%s/%s', output_path, date{1}),sprintf('%s',newFolderName)); % Create a folder designating the time the recording started

% Store each image in its own individual file
for frame = 1:NUM_FRAMES
    outputFileName = fullfile(sprintf('%s/%s/%s',output_path,date{1},newFolderName),sprintf('%s.jpg',timestamps(frame,:)));
    imwrite(images{frame}, outputFileName);
end

% Create a video file, and get it ready to be filled with images
video = VideoWriter(fullfile(sprintf('%s/%s/%s/%s',output_path,date{1},newFolderName,'video.avi')));
video.FrameRate = framerate;
open(video);

% Add each image to the video
for picture = 1:NUM_FRAMES
    img = images{picture};
    writeVideo(video,img);
end

close(video);