function [output_train]=eur_all_2(x)
% ��϶��		�ѷ�볤	ˮƽ�γ���	�ؼ��	��������
global gprMdl_2
output_train = predict(gprMdl_2, x);

end