function [output_train]=eur_all(x)

global gprMdl_13
output_train = predict(gprMdl_13,x);

end