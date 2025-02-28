function [flirun] = EURnew(S)
x=S(1:4);
flirun = -( EUR12(x)-zuanjing(x)-fracture(x)-5000000)%%%% train /// test

end

