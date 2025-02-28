function [output_train]=eur_all(x)

global gprMdl_15
output_train = predict(gprMdl_15,x);

end