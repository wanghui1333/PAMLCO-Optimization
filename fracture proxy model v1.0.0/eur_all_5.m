function [output_train]=eur_all_5(x)
% ��϶��		�ѷ�볤	ˮƽ�γ���	�ؼ��	��������
global gprMdl_5
output_train = predict(gprMdl_5, x);

end