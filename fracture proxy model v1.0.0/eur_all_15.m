function [output_train]=eur_all_15(x)
% ��϶��		�ѷ�볤	ˮƽ�γ���	�ؼ��	��������
global gprMdl_15
output_train = predict(gprMdl_15, x);

end