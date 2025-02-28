function [output_train]=eur_all_10(x)
% 孔隙度		裂缝半长	水平段长度	簇间距	导流能力
global gprMdl_10
output_train = predict(gprMdl_10, x);

end