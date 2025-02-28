clc;
clear all;
[xm, fv]=PSO_adaptation(@AdaptFunc, 50,2,2,0.8,0.6,100,2)