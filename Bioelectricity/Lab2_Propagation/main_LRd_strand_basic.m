function main_LRd_strand_basic(p, varargin)
% /***************************************************************************
%  *   Copyright (C) 2006 by Leonid Livshitz and Yoram Rudy  *
%  *   Email livshitz@wustl.edu   *
%  *                                                                         *
%  *   This program is free software; you can redistribute it and/or modify  *
%  *   it under the terms of the GNU General Public License as published by  *
%  *   the Free Software Foundation; either version 2 of the License, or     *
%  *   (at your option) any later version.                                   *
%  *                                                                         *
%  *   This program is distributed in the hope that it will be useful,       *
%  *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
%  *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
%  *   GNU General Public License for more details.                          *
%  *                                                                         *
%  *   You should have received a copy of the GNU General Public License     *
%  *   along with this program; if not, write to the                         *
%  *   Free Software Foundation, Inc.,                                       *
%  *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
%  ***************************************************************************/
% 
% APL clear all
% APL close all

% display some info
disp(' ')
disp('Running simulation...')
disp('Parameters: ')
disp(['Istim: ',num2str(p.Istim)])
disp(['Coupling: ',num2str(p.coupling)])
disp(['INa: ',num2str(p.INaScale)])

t0 = clock;
constantsLRd_strand %% constants 
% modify parameters
data.Ist= p.Istim;% stimuli; default: 120; 100 captures, 90 does not (with Diff_X @ 0.00007, 90 captures)
data.Diff_X= p.coupling;%% Effective diffusion coefficient; default: 0.0007 (min 0.00002, max 0.003)
data.GNa = data.GNa * p.INaScale; % scale the sodium conductance
  
data.cell_STIM=0.05;% fraction of the cell stimulated


Time=200;Tmesh=800; %% ms; default Tmesh: 400
data.bcl=Time;
Xsize=1;Xmesh=50;%% 1 cm=100 cells; default Xmesh: 50
 
  x = linspace(0,Xsize,Xmesh);
  t = linspace(0,Time,Tmesh);
 
 
%   xs = linspace(0,Xsize,10*Xmesh);
N=1;%% number of beats; simulation is originally used to show alternans which is evident with more than 1 beat
tp=linspace(0,Time*N,Tmesh*N);

 [Xp,Tp]=meshgrid(tp,x);

 

TMP=zeros(length(t),length(x),N);
% Cai=zeros(length(t),length(x),N);
% Initial conditions
%   load llrd_n300
%  
%  X0=ones(1,length(x))'*x0;
%  data.cs = spline(x,X0');% Initial conditions
% Initial conditions
    load  initial_alternans
   data.cs=cs_0;
%    New=ppval(xs,data.cs);
 
% ca=[]; tmp=[]; 
    textchoice = round(rand(1)*10); % a random integer between 0 and 10
    if textchoice > 0
        h0 = waitbar(0,'Matlab is working hard, please wait...');
    else
        h0 = waitbar(0,'Matlab is hardly working, please wait...');
    end

for i=1:N
  
    sol=pd_LRD_strand(t,x,data);
    y=sol(end,:,:);
    y1=reshape(y,Xmesh,18);
    data.cs = spline(x,y1');
    
    TMP(:,:,i) = sol(:,:,1);
    
    %Cai(:,:,i)=sol(:,:,17);
 
 
     
    waitbar(i/N,h0)
%     APL Cai(:,:,i)=conc_buffer(sol(:,:,8),data.trpnbar,data.kmtrpn,data.cmdnbar,data.kmcmdn);

%     APL ca=[ca ; Cai(:,:,i)];
   
%     tmp=[tmp ;TMP(:,:,i)];
    
    % show simulation time
    t1= etime(clock,t0)/60;
    disp(['Simulation took ',num2str(t1),' minutes'])


end
        close(h0)
%       APL cs_0=data.cs;
  %  save  init_alternans cs_0
 % save strand_web3  sol Tp Xp
 

figure
% h=mesh(Tp',Xp',tmp);
h=mesh(Tp',Xp',TMP);
ylabel(['Time [ms]'],'FontSize',10)
xlabel(['Fiber [cm]'],'FontSize',10)
view(-37,70)
zlabel('V_m (mV)','FontSize',10)
set(gca,'FontSize',10)
axis tight
box off
grid off

% figure
% h1=mesh(Tp',Xp',1000*ca);
% ylabel(['Time [msec]'],'FontSize',18)
% xlabel(['Fiber'],'FontSize',18)
% 
% zlabel('[Ca_i] \mu M','FontSize',18)
% set(gca,'FontSize',18)
% view(-37,70)
% axis tight
% %colorbar
% box off
% grid off

% function [cai]=conc_buffer(ca_t,a1,b1,a2,b2)
% 
% 
%  	alp2 = a1+a2+b1+b2-ca_t;
% 	alp1 = b1*b2 -ca_t.*(b1+b2)+a1*b2+a2*b1;
% 	alp0 = -b1*b2*ca_t;
%       Q=(3*alp1-alp2.^2)/9;
%       R=(9*alp2.*alp1-27*alp0-2*alp2.^3)/54;
%       T=(R + (Q.^3 + R.^2).^0.5).^(1/3) -Q./((R + (Q.^3 + R.^2).^0.5).^(1/3));
%        
%      cai =abs(T-alp2/3);



% insert an empty line in console for convenience
disp(' ')

