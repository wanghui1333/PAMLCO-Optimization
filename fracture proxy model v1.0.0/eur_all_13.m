function [output_train]=eur_all_13(x)
% ��϶��		�ѷ�볤	ˮƽ�γ���	�ؼ��	��������
global gprMdl_13
output_train = predict(gprMdl_13, x);

end