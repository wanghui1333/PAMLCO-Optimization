function [fzuanjing] = zuanjing(x)

DA=2300;

 Djinchi=DA+x(2);
% %50����
  % fzuanjing=6419249+1682.6937*Djinchi+0.3024432575*Djinchi^2 + 0.0000072470369*Djinchi^3-0.0000059816812*Djinchi^2*DA+859.21936*DA-0.253570107*Djinchi*DA+0.1362177047*DA^2+0.0000029908406*Djinchi*DA^2 
% %70����
   fzuanjing=7477591+1523.8474*Djinchi+0.3406464357*Djinchi^2+0.0000072470369*Djinchi^3-0.0000059816812*Djinchi^2*DA+958.66891*DA-0.285102889*Djinchi*DA+0.1519840957*DA^2+0.0000029908406*Djinchi*DA^2
% %90����
%fzuanjing=9398985+1333.2268*Djinchi+0.3864914155*Djinchi^2+0.0000072470369*Djinchi^3-0.0000059816812*Djinchi^2*DA+1078.01134*DA-0.32294319*Djinchi*DA+0.1709042461*DA^2+0.0000029908406*Djinchi*DA^2 

