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
        %Display to check that it was done right
        figure(currentIndex); clf();
        subplot(211);
        imshow(images(currentIndex).original);
        title(sprintf('Original for Labmda %d, intensity %d',lambdaVals(ind2),intensities(ind1)))
        subplot(212);
        imshow(images(currentIndex).exposed);
        title(sprintf('Exposed for Labmda %d, intensity %d',lambdaVals(ind2),intensities(ind1)))
        images(currentIndex).lambdaVal = lambdaVals(ind2);
        images(currentIndex).intensity = intensities(ind1);
    end
end
%Calculate contrast and SNR of each image
aROI = pi*6^2;%r = 6
for im = 1:length(images)
    
    circleInds = find(images(im).original <1);
    Iroi = mean(images(im).exposed(circleInds));
    Ib = mean(images(im).exposed(setdiff([1:length(images(im).exposed(:))],circleInds)));
    images(im).contrast = abs(Ib-Iroi)/Ib;
    images(im).SNR = images(im).contrast * sqrt(1*images(im).lambdaVal*aROI);
    
end


save('images.mat','images')
%%

%Display the images for my user to see and evaluate
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
save('observerResponse.mat','circleSeen')

%%
obs1 = load('observerResponse_1.mat');
obs2 = load('observerResponse_2.mat');
obs3 = load('observerResponse_3.mat');


for ind1 = 1:length(intensities)
    col = find(obs1.circleSeen(ind1,:) == 1);
    if isempty(col)
        obs1.minLamb(ind1) = -1;
        obs1.SNR(ind1) = -1;
        obs1.C(ind1) = -1;
        
    else
        im = length(lambdaVals)*(ind1-1) + max(col);
        obs1.minLamb(ind1) = lambdaVals(max(col));
        obs1.SNR(ind1) = images(im).SNR;
        obs1.C(ind1) = images(im).contrast;
        
    end
    
    
    col = find(obs2.circleSeen(ind1,:) == 1);
    if isempty(col)
        obs2.minLamb(ind1) = -1;
        obs2.SNR(ind1) = -1;
        obs2.C(ind1) = -1;
        
    else
        im = length(lambdaVals)*(ind1-1) + max(col);
        obs2.minLamb(ind1) = lambdaVals(max(col));
        obs2.SNR(ind1) = images(im).SNR;
        obs2.C(ind1) = images(im).contrast;
        
    end
    
    col = find(obs3.circleSeen(ind1,:) == 1);
    if isempty(col)
        obs3.minLamb(ind1) = -1;
        obs3.SNR(ind1) = -1;
        obs3.C(ind1) = -1;
        
    else
        im = length(lambdaVals)*(ind1-1) + max(col);
        obs3.minLamb(ind1) = lambdaVals(max(col));
        obs3.SNR(ind1) = images(im).SNR;
        obs3.C(ind1) = images(im).contrast;
        
    end
    
    SNRs(1,ind1) = obs1.SNR(ind1);
    SNRs(2,ind1) = obs2.SNR(ind1);
    SNRs(3,ind1) = obs3.SNR(ind1);
    con(1,ind1) = obs1.SNR(ind1);
    con(2,ind1) = obs2.SNR(ind1);
    con(3,ind1) = obs3.SNR(ind1);
    minLamb(1,ind1) = obs1.minLamb(ind1);
    minLamb(2,ind1) = obs2.minLamb(ind1);
    minLamb(3,ind1) = obs3.minLamb(ind1);
end
%%
x = [1,1,1;2,2,2;3,3,3;4,4,4]';
figure(1);clf();hold on;
for ind1 = 1:4
    scatter(x(:,ind1),minLamb(:,ind1),[],'k','o','filled','MarkerFaceAlpha',0.6,'jitter','on','jitterAmount',0.15);
end
axis([0.5,4.5,0,max(minLamb(:))]);
figure(1);xticklabels({'','0.2','','0.4','','0.6','','0.8',''})
ylabel('Min Lambda')
xlabel('Intensity');
set(gca,'FontSize',20);

figure(2);clf();hold on;
for ind1 = 1:4
    scatter(x(:,ind1),con(:,ind1),[],'k','o','filled','MarkerFaceAlpha',0.6,'jitter','on','jitterAmount',0.15);
end
axis([0.5,4.5,0,max(con(:))]);
figure(2);xticklabels({'','0.2','','0.4','','0.6','','0.8',''})
ylabel('Contrast at min Lambda')
xlabel('Intensity');
set(gca,'FontSize',20);

figure(3);clf();hold on;
for ind1 = 1:4
    scatter(x(:,ind1),SNRs(:,ind1),[],'k','o','filled','MarkerFaceAlpha',0.6,'jitter','on','jitterAmount',0.15);
end
axis([0.5,4.5,0,max(SNRs(:))]);
figure(3);xticklabels({'','0.2','','0.4','','0.6','','0.8',''})
ylabel('SNR at min Lambda')
xlabel('Intensity');
set(gca,'FontSize',20);
%%

DesiredIm = 15;
figure(1);clf();
subplot(121);
imshow(images(DesiredIm).original);
title('Original');
subplot(122);
imshow(images(DesiredIm).exposed);
title('Exposed');



