function [output_train]=eur_all(x)

global gprMdl_10
output_train = predict(gprMdl_10,x);

end