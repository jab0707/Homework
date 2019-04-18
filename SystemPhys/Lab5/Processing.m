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
        P2R3 = P2R3 + 1;
        end
    end
    
end


%%

