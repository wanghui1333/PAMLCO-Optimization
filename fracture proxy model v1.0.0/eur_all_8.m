function [output_train]=eur_all_8(x)
% ��϶��		�ѷ�볤	ˮƽ�γ���	�ؼ��	��������
global gprMdl_8
output_train = predict(gprMdl_8, x);

end