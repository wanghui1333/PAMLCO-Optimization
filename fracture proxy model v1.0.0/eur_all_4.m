function [output_train]=eur_all_4(x)
% ��϶��		�ѷ�볤	ˮƽ�γ���	�ؼ��	��������
global gprMdl_4
output_train = predict(gprMdl_4, x);

end