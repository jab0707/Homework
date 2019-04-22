%%
%Convert files for pfeifer
% clear
% close all
% rawFiles = dir('RawData/');
% 
% for i = 1:length(rawFiles)
%     
%     if any(strfind(rawFiles(i).name,'.csv'))
%         ts.potvals = csvread([rawFiles(i).folder,'/',rawFiles(i).name],1,1);
%         ts.potvals = ts.potvals';
%         save(['Convert/',rawFiles(i).name(1:end-3),'mat'],'ts');
%     end
%     
% end

%%
%Process the pfeifered signals
clear();close all

%%

files = dir('Processed/');

B1Count = 1;
B2Count = 1;
P1R1 = 1;
P1R2 = 1;
P1R3 = 1;
P2R1 = 1;
P2R2 = 1;
P2R3 = 1;

for i = 1:length(files)
    name = files(i).name;
    if any(strfind(name,'phase1_baseline'))
        if any(strfind(name,'-ls.mat'))
        load([files(i).folder,'/',name]);
        p1_b(B1Count).potvals = ts.potvals;
        p1_b(B1Count).fids = ts.fids;
        p1_b(B1Count).spl(1,:) = spline(1:length(ts.potvals(1,:)),ts.potvals(1,:),linspace(1,length(ts.potvals(1,:)),2000));
        p1_b(B1Count).spl(2,:) = spline(1:length(ts.potvals(1,:)),ts.potvals(2,:),linspace(1,length(ts.potvals(1,:)),2000));
        p1_b(B1Count).spl(3,:) = spline(1:length(ts.potvals(1,:)),ts.potvals(3,:),linspace(1,length(ts.potvals(1,:)),2000));
        p1_bs.allSpls(B1Count,:,1) = p1_b(B1Count).spl(1,:);
        p1_bs.allSpls(B1Count,:,2) = p1_b(B1Count).spl(2,:);
        p1_bs.allSpls(B1Count,:,3) = p1_b(B1Count).spl(3,:);
        B1Count = B1Count + 1;
        
        end
    end
    
    if any(strfind(name,'phase2_baseline'))
        if any(strfind(name,'-ls.mat'))
        load([files(i).folder,'/',name]);
        c = B2Count;
        p2_b(c).potvals = ts.potvals;
        p2_b(c).fids = ts.fids;
        p2_b(c).spl(1,:) = spline(1:length(ts.potvals(1,:)),ts.potvals(1,:),linspace(1,length(ts.potvals(1,:)),2000));
        p2_b(c).spl(2,:) = spline(1:length(ts.potvals(1,:)),ts.potvals(2,:),linspace(1,length(ts.potvals(1,:)),2000));
        p2_b(c).spl(3,:) = spline(1:length(ts.potvals(1,:)),ts.potvals(3,:),linspace(1,length(ts.potvals(1,:)),2000));
        p2_bs.allSpls(B2Count,:,1) = p2_b(B2Count).spl(1,:);
        p2_bs.allSpls(B2Count,:,2) = p2_b(B2Count).spl(2,:);
        p2_bs.allSpls(B2Count,:,3) = p2_b(B2Count).spl(3,:);
        B2Count = B2Count + 1;
        end
    end
    
    if any(strfind(name,'phase1_rest_1'))
        if any(strfind(name,'-ls.mat'))
        load([files(i).folder,'/',name]);
        c = P1R1;
        p1_r1(c).potvals = ts.potvals;
        p1_r1(c).fids = ts.fids;
        p1_r1(c).spl(1,:) = spline(1:length(ts.potvals(1,:)),ts.potvals(1,:),linspace(1,length(ts.potvals(1,:)),2000));
        p1_r1(c).spl(2,:) = spline(1:length(ts.potvals(1,:)),ts.potvals(2,:),linspace(1,length(ts.potvals(1,:)),2000));
        p1_r1(c).spl(3,:) = spline(1:length(ts.potvals(1,:)),ts.potvals(3,:),linspace(1,length(ts.potvals(1,:)),2000));
        p1_r1s.allSpls(P1R1,:,1) = p1_r1(P1R1).spl(1,:);
        p1_r1s.allSpls(P1R1,:,2) = p1_r1(P1R1).spl(2,:);
        p1_r1s.allSpls(P1R1,:,3) = p1_r1(P1R1).spl(3,:);
        
        P1R1 = P1R1 + 1;
        end
    end
    
    
    if any(strfind(name,'phase1_rest_2'))
        if any(strfind(name,'-ls.mat'))
        load([files(i).folder,'/',name]);
        c = P1R2;
        p1_r2(c).potvals = ts.potvals;
        p1_r2(c).fids = ts.fids;
        p1_r2(c).spl(1,:) = spline(1:length(ts.potvals(1,:)),ts.potvals(1,:),linspace(1,length(ts.potvals(1,:)),2000));
        p1_r2(c).spl(2,:) = spline(1:length(ts.potvals(1,:)),ts.potvals(2,:),linspace(1,length(ts.potvals(1,:)),2000));
        p1_r2(c).spl(3,:) = spline(1:length(ts.potvals(1,:)),ts.potvals(3,:),linspace(1,length(ts.potvals(1,:)),2000));
        p1_r2s.allSpls(P1R2,:,1) = p1_r2(P1R2).spl(1,:);
        p1_r2s.allSpls(P1R2,:,2) = p1_r2(P1R2).spl(2,:);
        p1_r2s.allSpls(P1R2,:,3) = p1_r2(P1R2).spl(3,:);
        P1R2 = P1R2 + 1;
        end
    end
    
    if any(strfind(name,'phase1_rest_3'))
        if any(strfind(name,'-ls.mat'))
        load([files(i).folder,'/',name]);
        c = P1R3;
        p1_r3(c).potvals = ts.potvals;
        p1_r3(c).fids = ts.fids;
        p1_r3(c).spl(1,:) = spline(1:length(ts.potvals(1,:)),ts.potvals(1,:),linspace(1,length(ts.potvals(1,:)),2000));
        p1_r3(c).spl(2,:) = spline(1:length(ts.potvals(1,:)),ts.potvals(2,:),linspace(1,length(ts.potvals(1,:)),2000));
        p1_r3(c).spl(3,:) = spline(1:length(ts.potvals(1,:)),ts.potvals(3,:),linspace(1,length(ts.potvals(1,:)),2000));
        p1_r3s.allSpls(P1R3,:,1) = p1_r3(P1R3).spl(1,:);
        p1_r3s.allSpls(P1R3,:,2) = p1_r3(P1R3).spl(2,:);
        p1_r3s.allSpls(P1R3,:,3) = p1_r3(P1R3).spl(3,:);
        P1R3 = P1R3 + 1;
        end
    end
    %
    if any(strfind(name,'phase2_rest_1'))
        if any(strfind(name,'-ls.mat'))
        load([files(i).folder,'/',name]);
        c = P2R1;
        p2_r1(c).potvals = ts.potvals;
        p2_r1(c).fids = ts.fids;
        p2_r1(c).spl(1,:) = spline(1:length(ts.potvals(1,:)),ts.potvals(1,:),linspace(1,length(ts.potvals(1,:)),2000));
        p2_r1(c).spl(2,:) = spline(1:length(ts.potvals(1,:)),ts.potvals(2,:),linspace(1,length(ts.potvals(1,:)),2000));
        p2_r1(c).spl(3,:) = spline(1:length(ts.potvals(1,:)),ts.potvals(3,:),linspace(1,length(ts.potvals(1,:)),2000));
        p2_r1s.allSpls(c,:,1) = p2_r1(c).spl(1,:);
        p2_r1s.allSpls(c,:,2) = p2_r1(c).spl(2,:);
        p2_r1s.allSpls(c,:,3) = p2_r1(c).spl(3,:);
        P2R1 = P2R1 + 1;
        end
    end
    
    
    if any(strfind(name,'phase2_rest_2'))
        if any(strfind(name,'-ls.mat'))
        load([files(i).folder,'/',name]);
        c = P2R2;
        p2_r2(c).potvals = ts.potvals;
        p2_r2(c).fids = ts.fids;
        p2_r2(c).spl(1,:) = spline(1:length(ts.potvals(1,:)),ts.potvals(1,:),linspace(1,length(ts.potvals(1,:)),2000));
        p2_r2(c).spl(2,:) = spline(1:length(ts.potvals(1,:)),ts.potvals(2,:),linspace(1,length(ts.potvals(1,:)),2000));
        p2_r2(c).spl(3,:) = spline(1:length(ts.potvals(1,:)),ts.potvals(3,:),linspace(1,length(ts.potvals(1,:)),2000));
        p2_r2s.allSpls(c,:,1) = p2_r2(c).spl(1,:);
        p2_r2s.allSpls(c,:,2) = p2_r2(c).spl(2,:);
        p2_r2s.allSpls(c,:,3) = p2_r2(c).spl(3,:);
        P2R2 = P2R2 + 1;
        end
    end
    
    if any(strfind(name,'phase2_rest_3'))
        if any(strfind(name,'-ls.mat'))
        load([files(i).folder,'/',name]);
        c = P2R3;
        p2_r3(c).potvals = ts.potvals;
        p2_r3(c).fids = ts.fids;
        p2_r3(c).spl(1,:) = spline(1:length(ts.potvals(1,:)),ts.potvals(1,:),linspace(1,length(ts.potvals(1,:)),2000));
        p2_r3(c).spl(2,:) = spline(1:length(ts.potvals(1,:)),ts.potvals(2,:),linspace(1,length(ts.potvals(1,:)),2000));
        p2_r3(c).spl(3,:) = spline(1:length(ts.potvals(1,:)),ts.potvals(3,:),linspace(1,length(ts.potvals(1,:)),2000));
        p2_r3s.allSpls(c,:,1) = p2_r3(c).spl(1,:);
        p2_r3s.allSpls(c,:,2) = p2_r3(c).spl(2,:);
        p2_r3s.allSpls(c,:,3) = p2_r3(c).spl(3,:);
        P2R3 = P2R3 + 1;
        end
    end
    
end


%%
%plot hand recorded data
load('rec.mat');
x1 = 1:50;x2 = 51:100;x3 = 101:150;

p1h1 = rec(2:13,1);
p1sp1 = rec(2:13,2);

p1h2 = rec(14:18,1);
p1sp2 = rec(14:18,2);

p1h3 = rec(19:26,1);
p1sp3 = rec(19:26,2);


p2h1 = rec(28:36,1);
p2sp1 = rec(28:36,2);

p2h2 = rec(37:44,1);
p2sp2 = rec(37:44,2);

p2h3 = rec(45:51,1);
p2sp3 = rec(46:51,2);



sp1h1 = interp1(1:length(rec(2:13,1)),rec(2:13,1),linspace(1,length(rec(2:13,1)),50));
sp1sp1 = interp1(1:length(rec(2:13,2)),rec(2:13,2),linspace(1,length(rec(2:13,2)),50));

sp1h2 = interp1(1:length(rec(14:18,1)),rec(14:18,1),linspace(1,length(rec(14:18,1)),50));
sp1sp2 = interp1(1:length(rec(14:18,2)),rec(14:18,2),linspace(1,length(rec(14:18,1)),50));

sp1h3 = interp1(1:length(rec(19:26,1)),rec(19:26,1),linspace(1,length(rec(19:26,1)),50));
sp1sp3 = interp1(1:length(rec(19:26,2)),rec(19:26,2),linspace(1,length(rec(19:26,1)),50));


sp2h1 = interp1(1:length(rec(28:36,1)),rec(28:36,1),linspace(1,length(rec(28:36,1)),50));
sp2sp1 = interp1(1:length(rec(28:36,2)),rec(28:36,2),linspace(1,length(rec(28:36,1)),50));

sp2h2 = interp1(1:length(rec(37:44,1)),rec(37:44,1),linspace(1,length(rec(37:44,1)),50));
sp2sp2 = interp1(1:length(rec(37:44,2)),rec(37:44,2),linspace(1,length(rec(37:44,1)),50));

sp2h3 = interp1(1:length(rec(45:51,1)),rec(45:51,1),linspace(1,length(rec(45:51,1)),50));
sp2sp3 = interp1(1:length(rec(46:51,2)),rec(46:51,2),linspace(1,length(rec(45:51,1)),50));
%%
figure('DefaultAxesFontSize',18);clf();
hold on;
plot(x1,sp1h1,'r','linewidth',2);
plot(x2,sp1h2,'g','linewidth',2);
plot(x3,sp1h3,'b','linewidth',2);
plot(x1,sp2h1,'r--','linewidth',2);
plot(x2,sp2h2,'g--','linewidth',2);
plot(x3,sp2h3,'b--','linewidth',2);
set(gca,'XTick',[]);
xlabel('Rest Period');
ylabel('Heart Rate');
hold off

figure('DefaultAxesFontSize',18);clf();
hold on;
plot(x1,sp1sp1,'r','linewidth',2);
plot(x2,sp1sp2,'g','linewidth',2);
plot(x3,sp1sp3,'b','linewidth',2);
plot(x1,sp2sp1,'r--','linewidth',2);
plot(x2,sp2sp2,'g--','linewidth',2);
plot(x3,sp2sp3,'b--','linewidth',2);
set(gca,'XTick',[]);
xlabel('Rest Period');
ylabel('SPO2');


%%
cl = kmeans(p1_bs.allSpls(:,:,1),2);


if (sum(cl == 1)> sum(cl == 2))
    
    c = 1;
else
    c =2;
end
p1_bmean(1,:) = mean(p1_bs.allSpls(find(cl == c),:,1));
p1_bmean(2,:) = mean(p1_bs.allSpls(find(cl == c),:,2));
p1_bmean(3,:) = mean(p1_bs.allSpls(find(cl == c),:,3));


cl = kmeans(p2_bs.allSpls(:,:,1),2);

if (sum(cl == 1)> sum(cl == 2))
    
    c = 1;
else
    c =2;
end
p2_bmean(1,:) = mean(p2_bs.allSpls(find(cl == c),:,1));
p2_bmean(2,:) = mean(p2_bs.allSpls(find(cl == c),:,2));
p2_bmean(3,:) = mean(p2_bs.allSpls(find(cl == c),:,3));

%%
figure('DefaultAxesFontSize',18);clf();

subplot(311);hold on;
plot(p1_bmean(1,:),'r','linewidth',2);
plot(p2_bmean(1,:),'r--','linewidth',2);
title('I');
xlabel('time (ms)');
ylabel('voltage (mv)');
subplot(312);hold on;
plot(p1_bmean(2,:),'g','linewidth',2);
plot(p2_bmean(2,:),'g--','linewidth',2);
title('II');
xlabel('time (ms)');
ylabel('voltage (mv)');
subplot(313);hold on;
plot(p1_bmean(3,:),'b','linewidth',2);
plot(p2_bmean(3,:),'b--','linewidth',2);
title('III');
xlabel('time (ms)');
ylabel('voltage (mv)');

%%
figure('DefaultAxesFontSize',18);clf();

subplot(341);hold on;
plot(mean(p1_r1s.allSpls(1:5,:,1),1),'r','linewidth',2);
plot(mean(p2_r1s.allSpls(1:5,:,1),1),'r--','linewidth',2);
title('R1');
ylabel({'I','voltage (mv)'});
subplot(342);hold on;
plot(mean(p1_r2s.allSpls(1:5,:,1),1),'r','linewidth',2);
plot(mean(p2_r2s.allSpls(1:5,:,1),1),'r--','linewidth',2);
title('R2');

subplot(343);hold on;
plot(mean(p1_r3s.allSpls(1:5,:,1),1),'r','linewidth',2);
plot(mean(p2_r3s.allSpls(1:5,:,1),1),'r--','linewidth',2);
title('R3');
subplot(344);hold on;
plot(p1_bmean(1,:),'k','linewidth',1);
plot(p2_bmean(1,:),'k--','linewidth',1);
title('Base');

subplot(345);hold on;
plot(mean(p1_r1s.allSpls(1:5,:,2),1),'g','linewidth',2);
plot(mean(p2_r1s.allSpls(1:5,:,2),1),'g--','linewidth',2);
ylabel({'II','voltage (mv)'});
subplot(346);hold on;
plot(mean(p1_r2s.allSpls(1:5,:,2),1),'g','linewidth',2);
plot(mean(p2_r2s.allSpls(1:5,:,2),1),'g--','linewidth',2);

subplot(347);hold on;
plot(mean(p1_r3s.allSpls(1:5,:,2),1),'g','linewidth',2);
plot(mean(p2_r3s.allSpls(1:5,:,2),1),'g--','linewidth',2);

subplot(348);hold on;
plot(p1_bmean(2,:),'k','linewidth',1);
plot(p2_bmean(2,:),'k--','linewidth',1);

subplot(3,4,9);hold on;
plot(mean(p1_r1s.allSpls(1:5,:,3),1),'b','linewidth',2);
plot(mean(p2_r1s.allSpls(1:5,:,3),1),'b--','linewidth',2);

xlabel('time (ms)');
ylabel({'III','voltage (mv)'});
subplot(3,4,10);hold on;
plot(mean(p1_r2s.allSpls(1:5,:,3),1),'b','linewidth',2);
plot(mean(p2_r2s.allSpls(1:5,:,3),1),'b--','linewidth',2);

xlabel('time (ms)');
ylabel('voltage (mv)');
subplot(3,4,11);hold on;
plot(mean(p1_r3s.allSpls(1:5,:,3),1),'b','linewidth',2);
plot(mean(p2_r3s.allSpls(1:5,:,3),1),'b--','linewidth',2);

xlabel('time (ms)');
ylabel('voltage (mv)');
subplot(3,4,12);hold on;
plot(p1_bmean(3,:),'k','linewidth',1);
plot(p2_bmean(3,:),'k--','linewidth',1);

xlabel('time (ms)');
ylabel('voltage (mv)');


%%
figure('DefaultAxesFontSize',18);clf();

subplot(341);hold on;
plot(mean(p1_r1s.allSpls(end-5:end,:,1),1),'r','linewidth',2);
plot(mean(p2_r1s.allSpls(end-5:end,:,1),1),'r--','linewidth',2);
title('R1');
ylabel({'I','voltage (mv)'});
subplot(342);hold on;
plot(mean(p1_r2s.allSpls(end-5:end,:,1),1),'r','linewidth',2);
plot(mean(p2_r2s.allSpls(end-5:end,:,1),1),'r--','linewidth',2);
title('R2');

subplot(343);hold on;
plot(mean(p1_r3s.allSpls(end-5:end,:,1),1),'r','linewidth',2);
plot(mean(p2_r3s.allSpls(end-5:end,:,1),1),'r--','linewidth',2);
title('R3');
subplot(344);hold on;
plot(p1_bmean(1,:),'k','linewidth',1);
plot(p2_bmean(1,:),'k--','linewidth',1);
title('Base');

subplot(345);hold on;
plot(mean(p1_r1s.allSpls(end-5:end,:,2),1),'g','linewidth',2);
plot(mean(p2_r1s.allSpls(end-5:end,:,2),1),'g--','linewidth',2);
ylabel({'II','voltage (mv)'});
subplot(346);hold on;
plot(mean(p1_r2s.allSpls(end-5:end,:,2),1),'g','linewidth',2);
plot(mean(p2_r2s.allSpls(end-5:end,:,2),1),'g--','linewidth',2);

subplot(347);hold on;
plot(mean(p1_r3s.allSpls(end-5:end,:,2),1),'g','linewidth',2);
plot(mean(p2_r3s.allSpls(end-5:end,:,2),1),'g--','linewidth',2);

subplot(348);hold on;
plot(p1_bmean(2,:),'k','linewidth',1);
plot(p2_bmean(2,:),'k--','linewidth',1);

subplot(3,4,9);hold on;
plot(mean(p1_r1s.allSpls(end-5:end,:,3),1),'b','linewidth',2);
plot(mean(p2_r1s.allSpls(end-5:end,:,3),1),'b--','linewidth',2);

xlabel('time (ms)');
ylabel({'III','voltage (mv)'});
subplot(3,4,10);hold on;
plot(mean(p1_r2s.allSpls(end-5:end,:,3),1),'b','linewidth',2);
plot(mean(p2_r2s.allSpls(end-5:end,:,3),1),'b--','linewidth',2);

xlabel('time (ms)');
ylabel('voltage (mv)');
subplot(3,4,11);hold on;
plot(mean(p1_r3s.allSpls(end-5:end,:,3),1),'b','linewidth',2);
plot(mean(p2_r3s.allSpls(end-5:end,:,3),1),'b--','linewidth',2);

xlabel('time (ms)');
ylabel('voltage (mv)');
subplot(3,4,12);hold on;
plot(p1_bmean(3,:),'k','linewidth',1);
plot(p2_bmean(3,:),'k--','linewidth',1);

xlabel('time (ms)');
ylabel('voltage (mv)');

