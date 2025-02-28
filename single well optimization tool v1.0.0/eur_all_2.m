function [output_train]=eur_all(x)
global gprMdl_2
output_train = predict(gprMdl_2,x);

end