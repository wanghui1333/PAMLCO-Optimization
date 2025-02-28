function [fzuanjing] = zuanjing(S)
x=S(1:2);
DA=3200;
Djinchi=DA+x(2);
% %50进尺
%Tgongqi=0.0000023239*(x(2))^2+0.0049684206*(x(2))+0.013*(DA-2800)+42.2253;
%fzuanjing=9060544+1286.67*Djinchi+2.5986*Djinchi*Tgongqi-149.116*DA+105867*Tgongqi+44160*exp(0.0002*Djinchi)+33514*exp(0.0006*(Djinchi-2800))+26458*exp(0.00039*(Djinchi-2800))
%70A进尺
Tgongqi=0.0000021762*(x(2))^2+0.0040827978*(x(2))+0.013*(DA-3500)+49.77619;
fzuanjing=10177273+1290.24*Djinchi+2.5986*Djinchi*Tgongqi-149.116*DA+118688*Tgongqi+44160*exp(0.0002*Djinchi)+33514*exp(0.0006*(Djinchi-2800))+26458*exp(0.00039*(Djinchi-2800))
%70B进尺
%fzuanjing=10411646+1291.7*Djinchi+2.5986*Djinchi*Tgongqi-149.116*DA+118688*Tgongqi+44160*exp(0.0002*Djinchi)+33514*exp(0.0006*(Djinchi-2800))+26458*exp(0.00039*(Djinchi-2800))
% %70C进尺 
% fzuanjing=10660950+1360.84*Djinchi+2.5986*Djinchi*Tgongqi-149.116*DA+118688*Tgongqi+44160*exp(0.0002*Djinchi)+33514*exp(0.0006*(Djinchi-2800))+26458*exp(0.00039*(Djinchi-2800))








end