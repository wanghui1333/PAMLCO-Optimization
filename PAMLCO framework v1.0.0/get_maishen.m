function [ZA] = qukuai_zuanjing(jingzuobiao_pingtai_hebing) % A靶点坐标，井长，平台坐标
[jingshu, temp] = size(jingzuobiao_pingtai_hebing);
% ZA=3500;
% ZB=3500;
global x_za
global y_za
global value_za
global x_dengzhixian
global y_dengzhixian
global value_dengzhixian

for idx=1:jingshu
    bar_a = jingzuobiao_pingtai_hebing(idx, :);
    [XA, YA]=deal(bar_a(1), bar_a(2));
    
    changdu = (x_dengzhixian - XA).^2 + (y_dengzhixian - YA).^2;
    [value, index_min] = min(changdu);
    % A 靶点坐标
    zuobiaox_true = x_dengzhixian(index_min);
    zuobiaoy_true = y_dengzhixian(index_min);

    XA = zuobiaox_true;
    YA = zuobiaoy_true;

    changdu = (x_za - XA).^2 + (y_za - YA).^2;
    [value, index_min] = min(changdu);
    ZA(idx) = value_za(index_min);
end
