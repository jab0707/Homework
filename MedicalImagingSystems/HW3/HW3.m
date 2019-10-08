%Q2
%part 1 making a spiral with trig functions
timeSprial = [0:.1:100*pi];
xgradSpiral = -sin(timeSprial).*timeSprial;
ygradSpiral = -cos(timeSprial).*timeSprial;
flipSpiral = ones(length(timeSprial),1);
PlotKSpace(xgradSpiral,ygradSpiral,flipSpiral,1);
figure(2);
plot(xgradSpiral);
figure(3)
plot(ygradSpiral);

%Part two making a start step

%get it into the starting position
clear
xgradStep(1:10) = .1;
ygradStep(1:10) = .1;

%The following segments will be repeated to do each step
repeatXgrad(1:10) = -.2;%First going backwayrds in x
repeatYgrad(1:10) = 0;%And not moving on y
%There are 11 steps to go from the most positive y value to the y axis, and
%I assume a unit value for the maximum y. Let's assume we only take two
%time steps to get from one y level to another
repeatXgrad(11:12) = 0;%Don't move x during this time
repeatYgrad(11:12) = -1/22;%11 steps per 1 unit, but pbroken into two steps makes 22 per one unit

repeatXgrad(13:22) = .2;%now go forward in x
repeatYgrad(1:10) = 0;%And not moving on y

repeatXgrad(23:24) = 0;%Don't move x during this time
repeatYgrad(23:24) = -1/22;%11 steps per 1 unit, but pbroken into two steps makes 22 per one unit

%Repeat the above 11 times then add one final negative x move

addOnX = repmat(repeatXgrad,1,11);
addOnY = repmat(repeatYgrad,1,11);

xgradStep = [xgradStep,addOnX,-.2.*ones(1,10)];
ygradStep = [ygradStep,addOnY,zeros(1,10)];

PlotKSpace(xgradStep,ygradStep,ones(size(xgradStep)),4);
figure(5);
plot(xgradStep);
figure(6)
plot(ygradStep);


function PlotKSpace(xgrad,ygrad,flips,figNum)


fullPath = zeros(2,length(xgrad) + 1);

for t = 1:length(xgrad)
fullPath(:,t+1) = fullPath(:,t).*flips(t);%If there is a flip at this time point, then flip the previous coordinates

fullPath(:,t+1) = fullPath(:,t) + [xgrad(t);ygrad(t)];

    
    
end
figure(figNum);clf();
plot(fullPath(1,:),fullPath(2,:),'linewidth',2)
axis('equal')

end
