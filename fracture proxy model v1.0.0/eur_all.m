function [output_train]=eur_all(x)
% ��϶��		�ѷ�볤	ˮƽ�γ���	�ؼ��	��������
global gprMdl_18
output_train = predict(gprMdl_18, x);

end