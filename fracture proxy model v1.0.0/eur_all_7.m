function [output_train]=eur_all_7(x)
% ��϶��		�ѷ�볤	ˮƽ�γ���	�ؼ��	��������
global gprMdl_7
output_train = predict(gprMdl_7, x);

end