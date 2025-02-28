function [output_train]=eur_all(x)

global gprMdl_12
output_train = predict(gprMdl_12,x);

end