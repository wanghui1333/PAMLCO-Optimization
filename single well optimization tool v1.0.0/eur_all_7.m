function [output_train]=eur_all(x)

global gprMdl_7
output_train = predict(gprMdl_7,x);

end