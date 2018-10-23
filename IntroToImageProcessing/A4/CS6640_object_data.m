function object_data = CS6640_object_data(M,vidObj)
%
% On input:
%   M (Matlab movie): movie of segmented moving objects
%   vidObj (video object obtained by VideoReader): input video
% On output:
%   object_data (struct vector): object data
%       (k).num_objects (int): number of objects in frame k
%       (k).objects (struct vector): has features for each object (p)
%       objects(p).row_mean (float): row mean
%       objects(p).col_mean (float): column mean
%       objects(p).ul_row (int): upper left row for bounding box
%       objects(p).ul_col (int): upper left col for bounding box
%       objects(p).lr_row (int): lower right row for bounding box
%       objects(p).lr_col (int): lower right col for bounding box
%       objects(p).num_pixels (int): number of pixels
%       objects(p).red_median (int): median red value for object
%       objects(p).green_median (int): median green value for object
%       objects(p).blue_median (int): median blue value for object
% Call:
%   obj_data = CS6640_object_data(M,vidObj);
% Author:
%   Jake Bergquist
%   Fall 2018
%   UU
%



vidObj.CurrentTime = 0;
framenum = vidObj.Duration*vidObj.FrameRate;
frames = cell(framenum,1);
for idx = 1:framenum
    frames{idx} = readFrame(vidObj);
end
vidObj.CurrentTime = 0; 
bckGrnd = CS6640_backgound(vidObj);

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
