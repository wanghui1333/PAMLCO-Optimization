function [output_train]=eur_all(x)

global gprMdl_6
output_train = predict(gprMdl_6,x);

end