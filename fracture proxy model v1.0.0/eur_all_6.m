function [output_train]=eur_all_6(x)
% ��϶��		�ѷ�볤	ˮƽ�γ���	�ؼ��	��������
global gprMdl_6
output_train = predict(gprMdl_6, x);

end