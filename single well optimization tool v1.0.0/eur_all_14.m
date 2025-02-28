function [output_train]=eur_all(x)

global gprMdl_14
output_train = predict(gprMdl_14,x);

end