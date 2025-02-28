function [output_train]=eur_all(x)
% 孔隙度		裂缝半长	水平段长度	簇间距	导流能力
global gprMdl_18
output_train = predict(gprMdl_18, x);

end