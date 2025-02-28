clear all;
clc;

% x0=[120;20;400;10];
% xm=[50;10;100;1];
% xn=[200;70;400;30];
global data_base
data_base = xlsread('0519-导流半长及支撑压裂的数据库1.xlsx');
%options = optimoptions('fmincon','Algorithm','sqp');
% x1=fmincon('EUR',x0,[],[], [], [], xm,xn);
% output=EUR(x1)

%%%%%%%%%%%%%%粒子群
lb=[50;10;100;1];
ub=[200;70;400;30];
[fval]=particleswarm(@EURnew,4,lb,ub)



%%%%%%%%%%%%%%fmincon_global
% tic, F=[];
% for i=1:5
%     [x,f0]=fminunc_global(@EURnew, xm,xn,2, 10);
%     F=[F,f0]
% end, toc
    
    
