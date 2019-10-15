function [sol]=pd_LRd_strand(t,x,data)
m = 0;
 opts =[];% odeset('RelTol',1e-6);
sol = pdepe(0,@pdex1pde,@pdex1ic,@pdex1bc,x,t,opts,data);

% --------------------------------------------------------------------------

function [c,f,s] = pdex1pde(x,t,u,DuDx,data)

c =ones(1,18)'; 
f = [data.Diff_X;zeros(1,17)'].*DuDx;

if x<=data.cell_STIM
    data.Is=data.Ist;
else
    data.Is=0;
end
s= cell_2009(t,u,data);
%s= cell_new_inid(t,u,data);
% --------------------------------------------------------------------------

function u0 = pdex1ic(x,data)
     cs=data.cs;
     u0=ppval(x,cs);
%     u0(1:18)=New % needs to be column vector in Matlab 2014 - fs
 
    % --------------------------------------------------------------------------

function [pl,ql,pr,qr] = pdex1bc(xl,ul,xr,ur,t,data)
 
pl =zeros(1,18)';
ql =ones(1,18)';
pr =zeros(1,18)';
qr = ones(1,18)';

 