function [output_train]=eur_all(x)

global gprMdl_4
output_train = predict(gprMdl_4,x);

end