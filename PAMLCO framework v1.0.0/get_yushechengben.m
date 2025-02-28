function [result_all] = get_yushechengben(x_zuobiao, y_zuobiao, banchang, jingchang)
global tail
jingshu = length(x_zuobiao);
PERM_mean = 0.0005;
for i=1:jingshu
    chengben_zuanjing(i) = qukuai_zuanjing([x_zuobiao(i), y_zuobiao(i)], jingchang(i), [x_zuobiao(i), y_zuobiao(i)-tail]);
    result_chengben(i) = chengben_zuanjing(i);
end
result_all = sum(result_chengben);