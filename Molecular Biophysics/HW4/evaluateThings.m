%
clear
close all;
%%
C10 = 90;
C20 = 10;
V10 = 2;
V20 = 8;

V2f = 10/(1+((C10*V10)/(C20*V20)));
C2f = (C20*V20)/V2f;
C1f = C2f;
V1f = (C10*V10)/C1f;


%%
%correct
C20 = 20;

V2f = 10/(1+((C10*V10)/(C20*V20)));
C2f = (C20*V20)/V2f;
C1f = C2f;
V1f = (C10*V10)/C1f;
