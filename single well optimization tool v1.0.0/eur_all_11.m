function [output_train]=eur_all(x)

global gprMdl_11
output_train = predict(gprMdl_11,x);

end