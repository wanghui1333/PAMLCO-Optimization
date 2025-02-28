function [output_train]=eur_all_15(x)
% 孔隙度		裂缝半长	水平段长度	簇间距	导流能力
global gprMdl_15
output_train = predict(gprMdl_15, x);

end