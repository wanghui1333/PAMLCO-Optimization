function [output_train]=eur_all_12(x)
% ��϶��		�ѷ�볤	ˮƽ�γ���	�ؼ��	��������
global gprMdl_12
output_train = predict(gprMdl_12, x);

end