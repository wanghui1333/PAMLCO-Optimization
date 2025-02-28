function [output_xzuobiao, output_yzuobiao] = bujing_xiao(anchor, jingchang)

jingshu = length(jingchang);
paijianju = 50;
output_xzuobiao = 0;
output_yzuobiao = 0;

[juli, bottom] = judi_bottom(anchor);
pianyi_y = paijianju; %起始偏移
for jing_move=1:jingshu % 计数该列能布几口井,得到结果为下角标jing:jing_move-1都可以布的下
    if juli >= sum(jingchang(1:jing_move))
        x_zuobiao = anchor;
        y_zuobiao = bottom + pianyi_y;
        output_xzuobiao(jing_move) = x_zuobiao;
        output_yzuobiao(jing_move) = y_zuobiao;
        pianyi_y = pianyi_y + jingchang(jing_move) + paijianju; % 加上排间距
    end
end
% end