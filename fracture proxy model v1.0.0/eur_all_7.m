function [output_train]=eur_all_7(x)
% 孔隙度		裂缝半长	水平段长度	簇间距	导流能力
global gprMdl_7
output_train = predict(gprMdl_7, x);

end