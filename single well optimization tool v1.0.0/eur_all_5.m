function [output_train]=eur_all(x)

global gprMdl_5
output_train = predict(gprMdl_5,x);

end