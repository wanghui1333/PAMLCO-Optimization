function [frecovery] = recovery(x)
%% 厚度30m;
%含气饱和度：0.65;
%XF：120m;
%LENGTH:1600m;
%储量：1.7117亿
%产量：1.07亿;
%采收率：0.62511
%%
frecovery = (1.232508338*((15+x(1))^0.872-15^0.872)/(pi^0.128*0.872*x(1))); %120-1600-1.07
end