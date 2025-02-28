function [output_train]=eur_all_9(x)
% 孔隙度		裂缝半长	水平段长度	簇间距	导流能力
global gprMdl_9
output_train = predict(gprMdl_9, x);

end