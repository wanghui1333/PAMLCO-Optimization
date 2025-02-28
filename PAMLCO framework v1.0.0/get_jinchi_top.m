function [Djinchi] = qukuai_zuanjing(jingzuobiao_pingtai_hebing, jingchang_hebing, pingtaizuobiao_hebing) % A靶点坐标，井长，平台坐标
[jingshu, temp] = size(jingzuobiao_pingtai_hebing);
% ZA=3500;
% ZB=3500;
jing_chengben = 0;
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
pingtaizuobiao_hebing = -pingtaizuobiao_hebing;
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

    XB = zuobiaox_trueb;
    YB = zuobiaoy_trueb;
   if isempty(XB) || isempty(YB)
        jing_chengben(idx) = 10e10;
        continue;
    end
    changdu = (x_za_temp - XB).^2 + (y_za_temp - YB).^2;
    [value, index_min] = min(changdu);
    ZB = value_za(index_min);
    
    L=sqrt((XA-XB)^2+(YA-YB)^2+(ZA-ZB)^2);
    Lpianyiju=abs((XB-XA)*Yi-(YB-YA)*Xi-YA*(XB-XA)+XA*(YB-YA))/sqrt((XA-XB)^2+(YA-YB)^2);
    Lbaqianju=sqrt((Xi-XA)^2+(Yi-YA)^2-Lpianyiju^2);
    Djinchi=ZA+226.23+0.268*sqrt((Lbaqianju-343.77)^2+Lpianyiju^2)+L;
    DA=ZA+226.23+0.268*sqrt((Lbaqianju-343.77)^2+Lpianyiju^2);
end