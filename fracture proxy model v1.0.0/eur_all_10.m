function [output_train]=eur_all_10(x)
% ��϶��		�ѷ�볤	ˮƽ�γ���	�ؼ��	��������
global gprMdl_10
output_train = predict(gprMdl_10, x);

end