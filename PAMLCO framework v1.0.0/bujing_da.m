function [output_xzuobiao, output_yzuobiao] = bujing_da(anchor, jingchang, juli, bottom)
jingshu = length(jingchang);
paijianju = 50;
output_xzuobiao = 0;
output_yzuobiao = 0;

pianyi_y = 0; %��ʼƫ��
for jing_move=1:jingshu % ���������ܲ����ھ�,�õ����Ϊ�½Ǳ�jing:jing_move-1�����Բ�����
    if juli >= sum(jingchang(1:jing_move)) + paijianju * jing_move - paijianju
        x_zuobiao = anchor;
        y_zuobiao = bottom + pianyi_y;
%         rectangle('position',[x_zuobiao, y_zuobiao, 98*2, jingchang(jing_move)], 'EdgeColor','r');
        output_xzuobiao(jing_move) = x_zuobiao;
        output_yzuobiao(jing_move) = y_zuobiao;
        pianyi_y = pianyi_y + jingchang(jing_move) + paijianju; % �����ż��
    end
end
% end