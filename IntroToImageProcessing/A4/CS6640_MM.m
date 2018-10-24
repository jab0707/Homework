function M = CS6640_MM(vidObj)
% CS6640_MM - segments moving objects in video
% On input:
%   vidObj (video object obtained by VideoReader): input video
% On output:
%   M (Matlab movie): movie of segmented moving objects
% Call:
%   vidObj = VideoReader(’../../../video.avi’);
%   M = CS6640_MM(vidObj);
% Author:
% 	Jake Bergquist
%   Fall 2018
%   U of U

%Load frames
vidObj.CurrentTime = 0;
framenum = vidObj.Duration*vidObj.FrameRate;
frames = cell(framenum,1);
for idx = 1:framenum
    frames{idx} = readFrame(vidObj);
end
vidObj.CurrentTime = 0; 
%Get Background
bckGrnd = CS6640_backgound(vidObj);

%For each frame
for idx = 1:length(frames)
    fr.original = frames{idx};
    fr.bckSub.raw = rgb2gray(uint8(abs(bckGrnd - frames{idx})));
    fr.bckSub.proc = process(fr.bckSub.raw);
    if idx>1
        fr.pairSub.raw = rgb2gray(uint8(abs(frames{idx}-frames{idx-1})));
        fr.pairSub.proc = process(fr.pairSub.raw);
        combined = fr.bckSub.proc + fr.pairSub.proc;
    else
        fr.pairSub.raw = {};
        fr.pairSub.proc = {};
        combined = fr.bckSub.proc;
    end
    
    if max(fr.bckSub.raw(:))<50
        combined = zeros(size(rgb2gray(frames{1})));
    end
    
    
    fr.movingThings = combined > 0;
    
    frameStructs(idx) = fr;
    
end
[sz1,sz2,sz3] = size(frames{1});
movieFrames = uint8(zeros(sz1,sz2,sz3,framenum));

for idx = 1:framenum
    inv = imcomplement(frameStructs(idx).movingThings);
    f = strel('square',5);
    inv = imdilate(inv,f);
    outLine = inv.*frameStructs(idx).movingThings;
    frame = mask(frameStructs(idx).original,outLine(:));
    movieFrames(:,:,:,idx) = frame;
end
M = immovie(uint8(movieFrames));

end


function pIm = process(rIm)


fIm = medfilt2(rIm);
fIm = uint8(fillOut(fIm));

%Binirize accpording to otsu threeshold
thresh = double(max(fIm(:)) - 4*(std(double(fIm(:)))))/255;
bIm = imbinarize(fIm,thresh);
pIm = bwmorph(bIm,'clean');
filt = strel('square',5);
pIm = imerode(pIm,filt);
pIm = imdilate(pIm,filt);
pIm = imdilate(pIm,filt);
pIm = imerode(pIm,filt);
pIm = imerode(pIm,filt);
pIm = imdilate(pIm,filt);

end

function fIm = fillOut(im)

fIm = zeros(size(im));
padIm = zeros((size(im)+[4,4]));
padIm(3:end-2,3:end-2) = im;
[sz1,sz2] = size(im);

for r = 3:sz1+2
    for c = 3:sz2+2
        val = sum(sum(padIm(r-2:r+2,c-2:c+2)));
        if val>255
            val = 255;
        end
        fIm(r-2,c-2) = val;
    end
end


end

