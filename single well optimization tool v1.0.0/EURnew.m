function [flirun] = EURnew(S)
x=S(1:2);
temp = [0.04, 0.00003, x];
flirun = -( EUR13(temp)-zuanjing(x)-EURfracture(x)-5000000)%%%% train /// test

end

