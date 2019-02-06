c1Vid = VideoReader('car1.avi');
c2Vid = VideoReader('car2.avi');
c3Vid = VideoReader('car3.avi');
t1Vid = VideoReader('truck1.avi');
t2Vid = VideoReader('truck2.avi');
t3Vid = VideoReader('truck3.avi');
b1Vid = VideoReader('bus1.avi');
b2Vid = VideoReader('bus2.avi');
b3Vid = VideoReader('bus3.avi');

[c1V,c1Info] = CS6640_MM(c1Vid);
[c2V,c2Info] = CS6640_MM(c2Vid);
[c3V,c3Info] = CS6640_MM(c3Vid);
[t1V,t1Info] = CS6640_MM(t1Vid);
[t2V,t2Info] = CS6640_MM(t2Vid);
[t3V,t3Info] = CS6640_MM(t3Vid);
[b1V,b1Info] = CS6640_MM(b1Vid);
[b2V,b2Info] = CS6640_MM(b2Vid);
[b3V,b3Info] = CS6640_MM(b3Vid);

%%
for i = 1:length(c1Info)
    c1BW(i) = bwconncomp(c1Info(i).movingThings);
    temp = zeros(c1BW(i).ImageSize);
    szs = [];
    for j = 1:c1BW(i).NumObjects
        szs(j) = length(c1BW(i).PixelIdxList{j});
    end
    [~,maxIdx] = max(szs);
    temp(c1BW(i).PixelIdxList{maxIdx}) = 1;
    
    c1RP(i) = regionprops(temp,'MajorAxisLength','MinorAxisLength','Area','Perimeter');
end
for i = 1:length(c2Info)
    c2BW(i) = bwconncomp(c2Info(i).movingThings);
    temp = zeros(c2BW(i).ImageSize);
    szs = [];
    for j = 1:c2BW(i).NumObjects
        szs(j) = length(c2BW(i).PixelIdxList{j});
    end
    [~,maxIdx] = max(szs);
    temp(c2BW(i).PixelIdxList{maxIdx}) = 1;
    
    c2RP(i) = regionprops(temp,'MajorAxisLength','MinorAxisLength','Area','Perimeter');
end
offset = 0;
for i = 1:length(c3Info)
    c3BW(i) = bwconncomp(c3Info(i).movingThings);
    temp = zeros(c3BW(i).ImageSize);
    szs = [];
    for j = 1:c3BW(i).NumObjects
        szs(j) = length(c3BW(i).PixelIdxList{j});
    end
    [~,maxIdx] = max(szs);
    if maxIdx > 0
        temp(c3BW(i).PixelIdxList{maxIdx}) = 1;
        c3RP(i-offset) = regionprops(temp,'MajorAxisLength','MinorAxisLength','Area','Perimeter');
    else
        offset = offset + 1;
    end
end
offset = 0;
for i = 1:length(t1Info)
    t1BW(i) = bwconncomp(t1Info(i).movingThings);
    temp = zeros(t1BW(i).ImageSize);
    szs = [];
    for j = 1:t1BW(i).NumObjects
        szs(j) = length(t1BW(i).PixelIdxList{j});
    end
    [~,maxIdx] = max(szs);
    if maxIdx > 0
        temp(t1BW(i).PixelIdxList{maxIdx}) = 1;
        t1RP(i-offset) = regionprops(temp,'MajorAxisLength','MinorAxisLength','Area','Perimeter');
    else
        offset = offset + 1;
    end
end
offset = 0;
for i = 1:length(t2Info)
    t2BW(i) = bwconncomp(t2Info(i).movingThings);
    temp = zeros(t2BW(i).ImageSize);
    szs = [];
    for j = 1:t2BW(i).NumObjects
        szs(j) = length(t2BW(i).PixelIdxList{j});
    end
    [~,maxIdx] = max(szs);
    if maxIdx > 0
        temp(t2BW(i).PixelIdxList{maxIdx}) = 1;
        t2RP(i-offset) = regionprops(temp,'MajorAxisLength','MinorAxisLength','Area','Perimeter');
    else
        offset = offset + 1;
    end
end
offset = 0;
for i = 1:length(t3Info)
    t3BW(i) = bwconncomp(t3Info(i).movingThings);
    temp = zeros(t3BW(i).ImageSize);
    szs = [];
    for j = 1:t3BW(i).NumObjects
        szs(j) = length(t3BW(i).PixelIdxList{j});
    end
    [~,maxIdx] = max(szs);
    if maxIdx > 0
        temp(t3BW(i).PixelIdxList{maxIdx}) = 1;
        t3RP(i-offset) = regionprops(temp,'MajorAxisLength','MinorAxisLength','Area','Perimeter');
    else
        offset = offset + 1;
    end
end
offset = 0;
for i = 1:length(b1Info)
    b1BW(i) = bwconncomp(b1Info(i).movingThings);
    temp = zeros(b1BW(i).ImageSize);
    szs = [];
    for j = 1:b1BW(i).NumObjects
        szs(j) = length(b1BW(i).PixelIdxList{j});
    end
    [~,maxIdx] = max(szs);
    if maxIdx > 0
        temp(b1BW(i).PixelIdxList{maxIdx}) = 1;
        b1RP(i-offset) = regionprops(temp,'MajorAxisLength','MinorAxisLength','Area','Perimeter');
    else
        offset = offset + 1;
    end
end
offset = 0;
for i = 1:length(b2Info)
    b2BW(i) = bwconncomp(b2Info(i).movingThings);
    temp = zeros(b2BW(i).ImageSize);
    szs = [];
    for j = 1:b2BW(i).NumObjects
        szs(j) = length(b2BW(i).PixelIdxList{j});
    end
    [~,maxIdx] = max(szs);
    if maxIdx > 0
        temp(b2BW(i).PixelIdxList{maxIdx}) = 1;
        b2RP(i-offset) = regionprops(temp,'MajorAxisLength','MinorAxisLength','Area','Perimeter');
    else
        offset = offset + 1;
    end
end
offset = 0;
for i = 1:length(b3Info)
    b3BW(i) = bwconncomp(b3Info(i).movingThings);
    temp = zeros(b3BW(i).ImageSize);
    szs = [];
    for j = 1:b3BW(i).NumObjects
        szs(j) = length(b3BW(i).PixelIdxList{j});
    end
    [~,maxIdx] = max(szs);
    if maxIdx > 0
        temp(b3BW(i).PixelIdxList{maxIdx}) = 1;
        b3RP(i-offset) = regionprops(temp,'MajorAxisLength','MinorAxisLength','Area','Perimeter');
    else
        offset = offset + 1;
    end
end
%%
Truths(1:403) = 1;
Truths(404:745) = 2;
Truths(746:1285) = 3;

TrainVects(1,:) = [c1RP(:).Area,c2RP(:).Area,t1RP(:).Area,t2RP(:).Area,b1RP(:).Area,b2RP(:).Area];
TrainVects(2,:) = [c1RP(:).MajorAxisLength,c2RP(:).MajorAxisLength,t1RP(:).MajorAxisLength,t2RP(:).MajorAxisLength,b1RP(:).MajorAxisLength,b2RP(:).MajorAxisLength];
TrainVects(3,:) = [c1RP(:).MinorAxisLength,c2RP(:).MinorAxisLength,t1RP(:).MinorAxisLength,t2RP(:).MinorAxisLength,b1RP(:).MinorAxisLength,b2RP(:).MinorAxisLength];
TrainVects(4,:) = [c1RP(:).Perimeter,c2RP(:).Perimeter,t1RP(:).Perimeter,t2RP(:).Perimeter,b1RP(:).Perimeter,b2RP(:).Perimeter];

net = feedforwardnet(5);
net.divideParam.valRatio = 0;
net.divideParam.testRatio = 0;
net.divideParam.trainRatio = 1;
net.trainParam.epochs = 1000;
[net,tra,Ya,Ea] = train(net,TrainVects,Truths);
TrainingResultsFull = round(net(TrainVects));
CarsTFull = TrainingResults(1:403);
TrucksTFull = TrainingResults(404:745);
BusTFull = TrainingResults(756:end);

TestVects(1,:) = [c3RP(:).Area,t3RP(:).Area,b3RP(:).Area];
TestVects(2,:) = [c3RP(:).MajorAxisLength,t3RP(:).MajorAxisLength,b3RP(:).MajorAxisLength,];
TestVects(3,:) = [c3RP(:).MinorAxisLength,t3RP(:).MinorAxisLength,b3RP(:).MinorAxisLength];
TestVects(4,:) = [c3RP(:).Perimeter,t3RP(:).Perimeter,b3RP(:).Perimeter];

TestResultsFull = round(net(TestVects));
CarsTestFull = TestResultsFull(1:91);
TrcuksTestFull = TestResultsFull(92:315);
BusTestFull = TestResultsFull(316:end);


net2 = feedforwardnet(5);
net2.divideParam.valRatio = 0;
net2.divideParam.testRatio = 0;
net2.divideParam.trainRatio = 1;
net2.trainParam.epochs = 1000;
[net2,tra,Ya,Ea] = train(net2,TrainVects(4,:),Truths);%Train only with perimeters


TrainingResultsPerim = round(net2(TrainVects(4,:)));
CarsTP = TrainingResultsPerim(1:403);
TrucksTP = TrainingResultsPerim(404:745);
BusTP = TrainingResultsPerim(756:end);

TestResultsPerim = round(net2(TestVects(4,:)));
CarsTestP = TestResultsPerim(1:91);
TrucksTestP = TestResultsPerim(92:315);
BusTestP = TestResultsPerim(316:end);




%%
camera = webcam;
nnet = alexnet;
picture = camera.snapshot;
picture = imresize(picture,[227,227]);
figure(1);clf();
image(picture);
label = classify(nnet,picture);
title(['Figure : ',char(label)]);
drawnow
clear camera
