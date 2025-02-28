function [output_train]=eur_all(x)

global gprMdl_9
output_train = predict(gprMdl_9,x);

end