function [output_train]=eur_all(x)

global gprMdl_1
output_train = predict(gprMdl_1, x);

end