function [output_train]=nongdu(x)
global gprMdl_3
output_train = predict(gprMdl_3, x);

 
 
 

end



