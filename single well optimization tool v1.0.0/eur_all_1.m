function [output_train]=eur_all(x)
% 孔隙度	渗透率	裂缝半长	裂缝条数	裂缝间距	导流能力
global gprMdl_1
output_train = predict(gprMdl_1, x);

end