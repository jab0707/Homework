%%
clear;close all;
%Load Data
load('midterm.mat');
%Make other corruptions

BW2 = zeros(size(Lena));
BW2(:,1:5:end) = 1;
BW2(:,1:5:end) = 1;

LenaCorupt2 = Lena .* abs(1-BW2);

BW3 = zeros(size(Lena));
LenaCorupt3 = Lena;
for i = 1:length(Lena(:))
    if rand() > .8
        BW3(i) = 1;
        LenaCorupt3(i) = 0;
    end
end
BW4 = BW3';
LenaCorupt4 = Lena .*abs(1-BW4);
Masks(:,:,1) = double(BW);
Masks(:,:,2) = BW2;
Masks(:,:,3) = BW3;
Masks(:,:,4) = BW4;

CoruptLenas(:,:,1) = LenaCorupt;
CoruptLenas(:,:,2) = LenaCorupt2;
CoruptLenas(:,:,3) = LenaCorupt3;
CoruptLenas(:,:,4) = LenaCorupt4;

H1Ests = zeros(size(Lena,1),size(Lena,2),4);
TVEsts = zeros(size(Lena,1),size(Lena,2),4);
energies = zeros(4,103);
SigAlphas = zeros(2,103,4);
ImageSerieses = zeros(size(Lena,1),size(Lena,2),103,4);

s1 = .1;
a1 = .1;
TVIter = 1000;
optIter = 100;
dualEps = .01;
primalEps = .01;
optEps = 0.01;
optEpsDecay = -0.001;

%%
parfor i = 1:4
    
    [TVEsts(:,:,i),SigAlphas(:,:,i),ImageSerieses(:,:,:,i),energies(i,:)] = OptimizeTV(Lena,CoruptLenas(:,:,i),Masks(:,:,i),s1,a1,TVIter,optIter,dualEps,primalEps,optEps,optEpsDecay);
    
    
end


%%

parfor i = 1:4
    H1Ests(:,:,i) = H1Inpaint(CoruptLenas(:,:,i),Masks(:,:,i),.25,.25,1000);
end
%%
figure(1);subplot(211);imshow(uint8(CoruptLenas(:,:,1)));subplot(212);imshow(uint8(TVEsts(:,:,1)));
figure(2);subplot(211);imshow(uint8(CoruptLenas(:,:,2)));subplot(212);imshow(uint8(TVEsts(:,:,2)));
figure(3);subplot(211);imshow(uint8(CoruptLenas(:,:,3)));subplot(212);imshow(uint8(TVEsts(:,:,3)));
figure(4);subplot(211);imshow(uint8(CoruptLenas(:,:,4)));subplot(212);imshow(uint8(TVEsts(:,:,4)));