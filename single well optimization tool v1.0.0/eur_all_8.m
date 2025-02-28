function [output_train]=eur_all(x)

global gprMdl_8
output_train = predict(gprMdl_8,x);

end