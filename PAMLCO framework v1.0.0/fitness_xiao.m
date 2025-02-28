function [S,result_all]=fitness_xiao(S, options)
global x_por
global y_por
global value_por
global x_sg
global y_sg
global value_sg
jingchang = S(1:end-1);
banchang = options(2);
banchang = repmat(banchang, 1, length(jingchang));
anchor = options(3);
liefengjianju = 20;
daoliunengli = 5;

% 产生框的坐标
[x_zuobiao, y_zuobiao] = bujing_xiao(anchor, jingchang);
jingshu = length(x_zuobiao);
POR_mean = 0.04;
PERM_mean = 0.0005;
SG_mean = 0.65;
for i=1:jingshu
    POR_mean = compute_meanvalue(x_zuobiao(i), y_zuobiao(i), x_por, y_por, banchang(i), jingchang(i), value_por);
    SG_mean = compute_meanvalue(x_zuobiao(i), y_zuobiao(i), x_sg, y_sg, banchang(i), jingchang(i), value_sg);
    chengben_zuanjing(i) = qukuai_zuanjing([x_zuobiao(i), y_zuobiao(i)], jingchang(i), [x_zuobiao(i), y_zuobiao(i)-343.77]);
    result_npvs = NPV0719([POR_mean, PERM_mean, SG_mean, banchang(i), liefengjianju, jingchang(i), daoliunengli]);
    result_npv(i) = result_npvs - chengben_zuanjing(i);
end
result_all = sum(result_npv);

