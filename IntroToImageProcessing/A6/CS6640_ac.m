function im_seg = CS6640_ac(M,vidObj)
% CS6640_ac - use active contours to improve segmentation
% On input:
%   M (Matlab movie struct): segmentation movie (binary)
%   vidObj (video struct): created by readVideo
% On output:
%   im_seg (MxNxF binary array): improved segmentation provided as
%                                sequence of F images
% Call:
%   vidObj = VideoReader(�../../../A4/video3.avi�);
%   ims = CS6640_ac(M,vidObj);
% Author:
%   Jake Bergquist
%   UU
%   Fall 2018
%

framenum = vidObj.Duration*vidObj.FrameRate;
vidObj.CurrentTime = 0; 
frames = cell(framenum,1);
for fr = 1:framenum
    frames{fr} = rgb2gray(readFrame(vidObj));
end
vidObj.CurrentTime = 0; 

im_seg = zeros(size(frames{1},1),size(frames{1},2),framenum);
for fr = 1:framenum
    mask = M(fr).cdata;
    mask = rgb2gray(mask);
    mask = imbinarize(mask);
    currFr = (frames{fr});
    im_seg(:,:,fr) = activecontour(currFr,mask,'edge');
    
end

end