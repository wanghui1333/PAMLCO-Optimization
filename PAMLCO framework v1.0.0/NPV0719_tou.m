function [f] = NPV0719(x, jingzuobiao_pingtai_hebing, jingchang_hebing, pingtaizuobiao_hebing)
%x(1)孔隙度，x(2)渗透率；x(3)含气饱和度；x(4) 裂缝半长；x(5) 裂缝间距；x(6) 水平段长度；x(7)裂缝导流能力

[jingshu, temp] = size(jingzuobiao_pingtai_hebing);
% ZA=3500;
% ZB=3500;
global x_za
global y_za
global value_za
global x_dengzhixian
global y_dengzhixian
global value_dengzhixian
global tail
x_za_temp = -x_za;
y_za_temp = -y_za;
x_dengzhixian_temp = -x_dengzhixian;
y_dengzhixian_temp = -y_dengzhixian;
jingzuobiao_pingtai_hebing = -jingzuobiao_pingtai_hebing;
jingzuobiao_pingtai_hebing(:, 2) = jingzuobiao_pingtai_hebing(:, 2) - jingchang_hebing;
pingtaizuobiao_hebing = jingzuobiao_pingtai_hebing;
pingtaizuobiao_hebing(:, 2) = pingtaizuobiao_hebing(:, 2) - tail;
for idx=1:jingshu
    bar_a = jingzuobiao_pingtai_hebing(idx, :);
    pingtai_zuobiao = pingtaizuobiao_hebing;

    [XA, YA]=deal(bar_a(1), bar_a(2));
    [Xi, Yi]=deal(pingtai_zuobiao(1), pingtai_zuobiao(2));
    changdu = (x_dengzhixian_temp - XA).^2 + (y_dengzhixian_temp - YA).^2;
    [value, index_min] = min(changdu);
    % A 靶点坐标
    zuobiaox_true = x_dengzhixian_temp(index_min);
    zuobiaoy_true = y_dengzhixian_temp(index_min);
    value_true = value_dengzhixian(index_min);
    % 得到那一列信息
    candidate_y = y_dengzhixian_temp(zuobiaox_true == x_dengzhixian_temp);
    candidate_x = x_dengzhixian_temp(zuobiaox_true == x_dengzhixian_temp);
    candidate_value = value_dengzhixian(zuobiaox_true == x_dengzhixian_temp);
    candidate_by = candidate_y(candidate_y > zuobiaoy_true);
    candidate_bvalue = candidate_value(candidate_y > zuobiaoy_true);
    candidate_bx = candidate_x(candidate_y > zuobiaoy_true);
    % 求取最近的值
    changdu = sqrt((candidate_by - zuobiaoy_true).^2 + (candidate_bvalue - value_true).^2);
    [value, index_min] = min(abs((changdu - jingchang_hebing(idx))));
    zuobiaox_trueb = candidate_bx(index_min);
    zuobiaoy_trueb = candidate_by(index_min);
    value_trueb = candidate_bvalue(index_min);
    XA = zuobiaox_true;
    YA = zuobiaoy_true;

    changdu = (x_za_temp - XA).^2 + (y_za_temp - YA).^2;
    [value, index_min] = min(changdu);
    ZA = value_za(index_min);
end
% f=EURfracture(x, ZA);
%x(1)孔隙度，x(2)渗透率；x(3)含气饱和度；x(4) 裂缝半长；x(5) 裂缝间距；x(6) 水平段长度；x(7)裂缝导流能力

temp = [x(1),  x(4),x(5), x(6), x(7)];
f=EUR11(temp)-EURfracture(x, ZA)-5000000;
end