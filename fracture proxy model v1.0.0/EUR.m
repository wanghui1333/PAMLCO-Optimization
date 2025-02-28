function [S,flirun] = EUR(S,options)
x=S(1:4);
if exist('results','dir')==0
   mkdir('results');
end
now_time = strrep(char(datetime('now')), ':', '-');
fpn666 = fopen(strcat('results\', now_time, '.txt'), 'wt');
fprintf(fpn666, char(strcat(now_time, '\n')));
fprintf(fpn666, char(strcat(num2str(x), '\n')));
%temp = [0.04 , 28900, 0.65,  x];
temp = [0.04, 32000, 0.65,  x];
flirun = (EUR12(temp)-zuanjing(x)-fracture(x)-5000000) %%%% train /// test

fprintf(fpn666, char(strcat(num2str(flirun), '\n')));
fclose(fpn666);

end

