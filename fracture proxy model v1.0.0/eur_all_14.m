function [output_train]=eur_all_14(x)
% ��϶��		�ѷ�볤	ˮƽ�γ���	�ؼ��	��������
global gprMdl_14
output_train = predict(gprMdl_14, x);

end