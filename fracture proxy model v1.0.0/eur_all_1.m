function [output_train]=eur_all_1(x)
% 孔隙度		裂缝半长	水平段长度	簇间距	导流能力
global gprMdl_1
output_train = predict(gprMdl_1, x);

end