function [output_train]=eur_all(x)
% ��϶��	��͸��	�ѷ�볤	�ѷ�����	�ѷ���	��������
global gprMdl_1
output_train = predict(gprMdl_1, x);

end