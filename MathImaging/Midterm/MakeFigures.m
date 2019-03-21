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
BW4 = BW2';
LenaCorupt4 = Lena .*abs(1-BW4);
Masks(:,:,1) = double(BW);
Masks(:,:,2) = BW2;
Masks(:,:,3) = BW3;
Masks(:,:,4) = BW4;

CoruptLenas(:,:,1) = LenaCorupt;
CoruptLenas(:,:,2) = LenaCorupt2;
CoruptLenas(:,:,3) = LenaCorupt3;
CoruptLenas(:,:,4) = LenaCorupt4;
%%
%Initilize values


s1 = .1;
a1 = .1;
TVIter = 1000;
optIter = 40;
dualEps = .01;
primalEps = .01;
optEps = 0.01;
optEpsDecay = -0.001;


H1Ests = zeros(size(Lena,1),size(Lena,2),4);
TVEsts = zeros(size(Lena,1),size(Lena,2),4);
energies = zeros(4,3+optIter);
SigAlphas = zeros(2,3+optIter,4);
ImageSerieses = zeros(size(Lena,1),size(Lena,2),3+optIter,4);

%%
%Run the TV optimization of sigma and alpha selection
parfor i = 4:4
    
    [TVEsts(:,:,i),SigAlphas(:,:,i),ImageSerieses(:,:,:,i),energies(i,:)] = OptimizeTV(Lena,CoruptLenas(:,:,i),Masks(:,:,i),s1,a1,TVIter,optIter,dualEps,primalEps,optEps,optEpsDecay);
    
    
end


%%
%Run H1 stuff
parfor i = 1:4
    H1Ests(:,:,i) = H1Inpaint(CoruptLenas(:,:,i),Masks(:,:,i),.25,.25,1000);
end
%%
%Plot optimized TV
figure(1);
subplot(241);imshow(uint8(CoruptLenas(:,:,1)));title('Corupt 1');
subplot(245);imshow(uint8(TVEsts(:,:,1)));
title(['C1: Sigma: ',num2str(SigAlphas(1,end,1)),' Alpha: ',num2str(1000*SigAlphas(2,end,1))]);
subplot(242);imshow(uint8(CoruptLenas(:,:,2)));title('Corupt 2');
subplot(246);imshow(uint8(TVEsts(:,:,2)));
title(['C2: Sigma: ',num2str(SigAlphas(1,end,2)),' Alpha: ',num2str(1000*SigAlphas(2,end,2))]);
subplot(243);imshow(uint8(CoruptLenas(:,:,3)));title('Corupt 3');
subplot(247);imshow(uint8(TVEsts(:,:,3)));
title(['C3: Sigma: ',num2str(SigAlphas(1,end,3)),' Alpha: ',num2str(1000*SigAlphas(2,end,3))]);
subplot(244);imshow(uint8(CoruptLenas(:,:,4)));title('Corupt 4');
subplot(248);imshow(uint8(TVEsts(:,:,4)));
title(['C4: Sigma: ',num2str(SigAlphas(1,end,4)),' Alpha: ',num2str(1000*SigAlphas(2,end,4))]);
%%
%Plot H1
figure(1);
subplot(241);imshow(uint8(CoruptLenas(:,:,1)));title('Corupt 1');
subplot(245);imshow(uint8(H1Ests(:,:,1)));
title(['C1: Sigma: ',num2str(0.25),' Alpha: ',num2str(0.25)]);
subplot(242);imshow(uint8(CoruptLenas(:,:,2)));title('Corupt 2');
subplot(246);imshow(uint8(H1Ests(:,:,2)));
title(['C2: Sigma: ',num2str(0.25),' Alpha: ',num2str(0.25)]);
subplot(243);imshow(uint8(CoruptLenas(:,:,3)));title('Corupt 3');
subplot(247);imshow(uint8(H1Ests(:,:,3)));
title(['C3: Sigma: ',num2str(0.25),' Alpha: ',num2str(0.25)]);
subplot(244);imshow(uint8(CoruptLenas(:,:,4)));title('Corupt 4');
subplot(248);imshow(uint8(H1Ests(:,:,4)));
title(['C4: Sigma: ',num2str(0.25),' Alpha: ',num2str(0.25)]);

%%
%Plot TV opt energy
figure(3);clf();hold on
cs = [1,0,0;0,1,0;0,0,1;1,0,1];
for i = 1:size(energies,1)
    plot(energies(i,:)','LineWidth',2,'Color',cs(i,:));
end
legend('C1','C2','C3','C4');xlabel('Iteration');ylabel('Energy');title('H1 Optimize Energy');

%%
%Plot unoptimized TV
figure(1);
subplot(241);imshow(uint8(CoruptLenas(:,:,1)));title('Corupt 1');
subplot(245);imshow(uint8(ImageSerieses(:,:,1,1)));
title(['C1: Sigma: ',num2str(SigAlphas(1,1,1)),' Alpha: ',num2str(1000*SigAlphas(2,1,1))]);
subplot(242);imshow(uint8(CoruptLenas(:,:,2)));title('Corupt 2');
subplot(246);imshow(uint8(ImageSerieses(:,:,1,2)));
title(['C2: Sigma: ',num2str(SigAlphas(1,1,2)),' Alpha: ',num2str(1000*SigAlphas(2,1,2))]);
subplot(243);imshow(uint8(CoruptLenas(:,:,3)));title('Corupt 3');
subplot(247);imshow(uint8(ImageSerieses(:,:,1,3)));
title(['C3: Sigma: ',num2str(SigAlphas(1,1,3)),' Alpha: ',num2str(1000*SigAlphas(2,1,3))]);
subplot(244);imshow(uint8(CoruptLenas(:,:,4)));title('Corupt 4');
subplot(248);imshow(uint8(ImageSerieses(:,:,1,4)));
title(['C4: Sigma: ',num2str(SigAlphas(1,1,4)),' Alpha: ',num2str(1000*SigAlphas(2,1,4))]);
%%
%plot TV paths of optimization for sigma and alpha 
figure(1);clf();
parfor i = 1:4
    
    figure(1);subplot(2,2,i)
    normEnergy = energies(i,:) - min(energies(i,:));
    normEnergy = normEnergy / max(normEnergy);
    color = [normEnergy;zeros(1,length(normEnergy));1-normEnergy];
    scatter(SigAlphas(1,:,i),SigAlphas(2,:,i),[],color');
    hold on;
    for j = 2:length(SigAlphas)
        quiver(SigAlphas(1,j-1,i),SigAlphas(2,j-1,i),SigAlphas(1,j,i)-SigAlphas(1,j-1,i),SigAlphas(2,j,i)-SigAlphas(2,j-1,i),'Color',color(:,j)');
    end
    xlabel('Sigma');ylabel('Alpha/1000');title(['Corrupt ',num2str(i)]);
end 

%%
figure(1);clf()
parfor i = 1:4
    
    figure(1);subplot(2,2,i)
    normEnergy = energies(i,:) - min(energies(i,:));
    normEnergy = normEnergy / max(normEnergy);
    color = [normEnergy;zeros(1,length(normEnergy));1-normEnergy];
    sf = fit([SigAlphas(1,:,i)',SigAlphas(2,:,i)'],normEnergy','poly23');
    scatter3(SigAlphas(1,:,i),SigAlphas(2,:,i),normEnergy,[],color');
    hold on;
    plot(sf)
    for j = 2:length(SigAlphas)
        quiver3(SigAlphas(1,j-1,i),SigAlphas(2,j-1,i),normEnergy(j-1),SigAlphas(1,j,i)-SigAlphas(1,j-1,i),SigAlphas(2,j,i)-SigAlphas(2,j-1,i),normEnergy(j)-normEnergy(j-1),'Color',color(:,j)','linewidth',2);
    end
    zlabel('Normalized Energy');xlabel('Sigma');ylabel('Alpha/1000');title(['Corrupt ',num2str(i)]);
end 
