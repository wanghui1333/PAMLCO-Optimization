function [output_train]=yalieye(x)
global gprMdl_2
output_train = predict(gprMdl_2, x);

end



