function [output_train]=eur_all_8(x)
% 孔隙度		裂缝半长	水平段长度	簇间距	导流能力
global gprMdl_8
output_train = predict(gprMdl_8, x);

end