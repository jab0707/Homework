clc
clear
close all
%%

D = 0.01;
uair = 0.2080;
ulung = 0.2270;
X = (D*uair)/(0.873*ulung);



%%

lambdaVals = [10,5,2,1,0.8,0.6,0.4,0.3,0.2,0.1];
intensities = [0.2,0.4,0.6,0.8];
%Generate the images for me to look at
for ind1 = 1:length(intensities)
    for ind2 = 1:length(lambdaVals)
        currentIndex = length(lambdaVals)*(ind1-1) + ind2;
        fprintf(sprintf('index: %d\n',currentIndex))
        %Generate new image for each lambda value
        images(currentIndex).original = gen_im(6,intensities(ind1));
        dist = poissrnd(lambdaVals(ind2),256,256);
        dist = dist/max(dist(:));
        images(currentIndex).exposed = dist.*images(currentIndex).original;
        figure(currentIndex); clf();
        subplot(211);
        imshow(images(currentIndex).original);
        title(sprintf('Original for Labmda %d, intensity %d',lambdaVals(ind2),intensities(ind1)))
        subplot(212);
        imshow(images(currentIndex).exposed);
        title(sprintf('Exposed for Labmda %d, intensity %d',lambdaVals(ind2),intensities(ind1)))
    end
end
save('images.mat','images')
%%

%Display the images for my user to see
circleSeen = zeros(length(intensities),length(lambdaVals));
for ind1 = 1:length(intensities)
    for ind2 = 1:length(lambdaVals)
        currPosition = get(figure(1),'position');
        currentIndex = length(lambdaVals)*(ind1-1) + ind2;
        figure(1);
        imshow(images(currentIndex).exposed);
        title('Do you see a disntict circle?')
        set(figure(1),'position',currPosition);
        in = input('Do you see a circle in this image? 1:y 0:n ');
        circleSeen(ind1,ind2) = in;
    end
end
%%
save('observerResponse_1.mat','circleSeen')