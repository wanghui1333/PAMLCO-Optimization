function [output_train]=eur_all_9(x)
% ��϶��		�ѷ�볤	ˮƽ�γ���	�ؼ��	��������
global gprMdl_9
output_train = predict(gprMdl_9, x);

end