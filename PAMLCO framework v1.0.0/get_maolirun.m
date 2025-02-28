function [result_maolirun, eur, eurfracture]=get_maolirun(x_zuobiao, y_zuobiao, banchang, jingchang, jingzuobiao_pingtai_hebing, jingchang_hebing, pingtaizuobiao_hebing)

global x_por
global y_por
global value_por
global x_sg
global y_sg
global value_sg
global x_dengzhixian
global y_dengzhixian
global value_dengzhixian
global x_za
global y_za
global value_za

liefengjianju = 20;
daoliunengli = 5;
PERM_mean = 0.0005;
POR_mean = compute_meanvalue(x_zuobiao, y_zuobiao, x_por, y_por, banchang, jingchang, value_por);
SG_mean = compute_meanvalue(x_zuobiao, y_zuobiao, x_sg, y_sg, banchang, jingchang, value_sg);

tail = 500;
[eur, eurfracture, result_npvs] = get_chengben([POR_mean, PERM_mean, SG_mean, banchang, liefengjianju, jingchang, daoliunengli], [x_zuobiao + banchang, y_zuobiao], jingchang, [x_zuobiao + banchang, y_zuobiao-tail]);
chengben_zuanjing = qukuai_zuanjing([x_zuobiao + banchang, y_zuobiao], jingchang, [x_zuobiao + banchang, y_zuobiao-500]);
result_maolirun = result_npvs - chengben_zuanjing;