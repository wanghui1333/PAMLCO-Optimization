function [output_train]=eur_all_11(x)
% ��϶��		�ѷ�볤	ˮƽ�γ���	�ؼ��	��������
global gprMdl_11
output_train = predict(gprMdl_11, x);

end