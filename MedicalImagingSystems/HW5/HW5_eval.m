clear
close all 
clc


%%
%Testing Backprojection

testThetas = deg2rad([0:5:175]);
simpleSinogram = zeros(201,1);
simpleSinogram(81:121,:) = 1;

t = 1;
figure(1);imshow(BackPropSinogram(simpleSinogram,testThetas(t),'linearinterp'));
title(sprintf('Basic Sinogram at %g^o',rad2deg(testThetas(t))));
set(gca,'fontsize',20)
t = 7;
figure(2);imshow(BackPropSinogram(simpleSinogram,testThetas(t),'linearinterp'));
title(sprintf('Basic Sinogram at %g^o',rad2deg(testThetas(t))));
set(gca,'fontsize',20)
t = 10;
figure(3);imshow(BackPropSinogram(simpleSinogram,testThetas(t),'linearinterp'));
title(sprintf('Basic Sinogram at %g^o',rad2deg(testThetas(t))));
set(gca,'fontsize',20)
[X,Y] = meshgrid(1:201,1:201);
b = zeros(length(simpleSinogram));
for t = 1:length(testThetas)
    b = b + BackPropSinogram(simpleSinogram,testThetas(t),'linearinterp');
    figure(4);imagesc(b./max(b(:)));title(sprintf('Proj %d',t));drawnow();
    figure(5);surf(X,Y,b);zlim([0 40]);drawnow();
end



%%
b = zeros(length(simpleSinogram));
filter = abs([-floor(length(simpleSinogram)/2):floor(length(simpleSinogram)/2)])';
filteredSinogram = abs(ifft(fftshift(fft(simpleSinogram)).*filter));
for t = 1:length(testThetas)
    b = b + BackPropSinogram(filteredSinogram,testThetas(t),'linearinterp');
    figure(4);imagesc(b./max(b(:)));title(sprintf('Proj %d',t));drawnow();
    figure(5);surf(X,Y,b);drawnow();
end

%%
figure(1);clf();
imshow(sinogram'/max(sinogram(:)))
%%
%Direct Backprojection
b = zeros(size(sinogram,1));
for t = 1:length(thetas)
b = b+BackPropSinogram(sinogram(:,t),deg2rad(thetas(t)),'linearinterp');
figure(1);imshow(b/max(b(:)));title(sprintf('Proj %d',t));drawnow();
end
figure(1);title('Direct Backprojection');set(gca,'fontsize',25)
%%
%Rho filtering
b = zeros(size(sinogram,1));
numSamples = size(sinogram,1);
rho = abs([-floor(numSamples/2):floor(numSamples/2)])';
Ft = fftshift(fft(sinogram),1);
M = abs(ifft(Ft.*rho));
%%
for t = 1:length(thetas)
b = b+BackPropSinogram(M(:,t),deg2rad(thetas(t)),'linearinterp');
figure(1);imshow(b/max(b(:)));title(sprintf('Proj %d',t));drawnow();
end
figure(1);title('Rho Filtered Backprojection');set(gca,'fontsize',25)
%%
%downsampling
%25% downsampled, skip every 4th angle
skipInds = [1:4:length(thetas)];
thetaInds = setdiff([1:length(thetas)],skipInds);
downSampleTheta = thetas(thetaInds);

b = zeros(size(sinogram,1));
for t = 1:length(downSampleTheta)
b = b+BackPropSinogram(M(:,thetaInds(t)),deg2rad(downSampleTheta(t)),'linearinterp');
figure(1);imshow(b/max(b(:)));title(sprintf('Proj %d',t));drawnow();
end
figure(1);title('25% downsampled Theta');set(gca,'fontsize',25)

%50% downsampeld uses every other
downSampleTheta = thetas(1:2:end);
thetaInds = [1:2:length(thetas)];
b = zeros(size(sinogram,1));
for t = 1:length(downSampleTheta)
b = b+BackPropSinogram(M(:,thetaInds(t)),deg2rad(downSampleTheta(t)),'linearinterp');
figure(2);imshow(b/max(b(:)));title(sprintf('Proj %d',t));drawnow();
end
figure(2);title('50% downsampled Theta');set(gca,'fontsize',25)
%75% downsampled uses every 4th 

downSampleTheta = thetas(1:4:end);
thetaInds = [1:4:length(thetas)];
b = zeros(size(sinogram,1));
for t = 1:length(downSampleTheta)
b = b+BackPropSinogram(M(:,thetaInds(t)),deg2rad(downSampleTheta(t)),'linearinterp');
figure(3);imshow(b/max(b(:)));title(sprintf('Proj %d',t));drawnow();
end
figure(3);title('75% downsampled Theta');set(gca,'fontsize',25)
%%
%Downsample sinogram
%25%
skipInds = [1:4:size(sinogram,1)];
sinogramInds = setdiff([1:size(sinogram,1)],skipInds);
downsampleSinogram = sinogram(sinogramInds,:);
downsampleSinogram = abs(ifft((fftshift(fft(downsampleSinogram),1).*abs([-floor(size(downsampleSinogram,1)/2):floor(size(downsampleSinogram,1)/2)]'))));
b = zeros(size(downsampleSinogram,1));
for t = 1:length(thetas)
    b = b+BackPropSinogram(downsampleSinogram(:,t),deg2rad(thetas(t)),'linearinterp');
    figure(1);imshow(b/max(b(:)));title(sprintf('Proj %d',t));drawnow();
end
figure(1);title('25% downsampled Sinogram');set(gca,'fontsize',25)

%50%
sinogramInds = [1:2:size(sinogram,1)-1];
downsampleSinogram = sinogram(sinogramInds,:);
downsampleSinogram = abs(ifft((fftshift(fft(downsampleSinogram),1).*abs([-floor(size(downsampleSinogram,1)/2):floor(size(downsampleSinogram,1)/2)]'))));
b = zeros(size(downsampleSinogram,1));
for t = 1:length(thetas)
    b = b+BackPropSinogram(downsampleSinogram(:,t),deg2rad(thetas(t)),'linearinterp');
    figure(2);imshow(b/max(b(:)));title(sprintf('Proj %d',t));drawnow();
end
figure(2);title('50% downsampled Sinogram');set(gca,'fontsize',25)


%75%
sinogramInds = [1:4:size(sinogram,1)-3];
downsampleSinogram = sinogram(sinogramInds,:);
downsampleSinogram = abs(ifft((fftshift(fft(downsampleSinogram),1).*abs([-floor(size(downsampleSinogram,1)/2):floor(size(downsampleSinogram,1)/2)]'))));
b = zeros(size(downsampleSinogram,1));
for t = 1:length(thetas)
    b = b+BackPropSinogram(downsampleSinogram(:,t),deg2rad(thetas(t)),'linearinterp');
    figure(3);imshow(b/max(b(:)));title(sprintf('Proj %d',t));drawnow();
end
figure(3);title('75% downsampled Sinogram');set(gca,'fontsize',25)
%%
%Hounsfield number fitting
water = [-20,0];
air = [-1200,-1000];

a = (water(2)-air(2))/(water(1)-air(1));
b = water(2)-a*water(1);

MysteryItem(1)=1850;
MysteryItem(2) = a*MysteryItem(1) + b;

figure(1);clf();
hold on;
scatter([water(1),air(1),MysteryItem(1)],[water(2),air(2),MysteryItem(2)]);
plot([-1300:1900],a.*[-1300:1900]+b);



