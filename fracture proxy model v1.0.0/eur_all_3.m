function [output_train]=eur_all_3(x)
% ��϶��		�ѷ�볤	ˮƽ�γ���	�ؼ��	��������
global gprMdl_3
output_train = predict(gprMdl_3, x);

end