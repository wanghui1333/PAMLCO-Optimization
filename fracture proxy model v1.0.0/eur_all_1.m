function [output_train]=eur_all_1(x)
% ��϶��		�ѷ�볤	ˮƽ�γ���	�ؼ��	��������
global gprMdl_1
output_train = predict(gprMdl_1, x);

end