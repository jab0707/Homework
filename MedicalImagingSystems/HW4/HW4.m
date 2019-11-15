clc
clear
close all
%%

lambdaVals = [10,8,6,4,2,1,0.1,0.05,0.01];

for ind = 1:length(lambdaVals)
    %Generate new image for each lambda value
    images(ind).original = gen_im(6,0.2);
    dist = poissrnd(lambdaVals(ind),256,256);
    dist = dist/max(dist(:));
    images(ind).exposed = dist.*images(ind).original;
    figure(ind); clf();
    subplot(211);
    imshow(images(ind).original);
    title(sprintf('Original for Labmda %d',lambdaVals(ind)))
    subplot(212);
    imshow(images(ind).exposed);
    title(sprintf('Exposed for Labmda %d',lambdaVals(ind)))
end

