function [output_xzuobiao, output_yzuobiao] = bujing_xiao(anchor, jingchang)

jingshu = length(jingchang);
paijianju = 50;
output_xzuobiao = 0;
output_yzuobiao = 0;

[juli, bottom] = judi_bottom(anchor);
pianyi_y = paijianju; %��ʼƫ��
for jing_move=1:jingshu % ���������ܲ����ھ�,�õ����Ϊ�½Ǳ�jing:jing_move-1�����Բ�����
    if juli >= sum(jingchang(1:jing_move))
        x_zuobiao = anchor;
        y_zuobiao = bottom + pianyi_y;
        output_xzuobiao(jing_move) = x_zuobiao;
        output_yzuobiao(jing_move) = y_zuobiao;
        pianyi_y = pianyi_y + jingchang(jing_move) + paijianju; % �����ż��
    end
end
% end