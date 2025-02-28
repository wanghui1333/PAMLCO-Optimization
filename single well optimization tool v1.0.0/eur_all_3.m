function [output_train]=eur_all(x)
global gprMdl_3
output_train = predict(gprMdl_3,x);

end