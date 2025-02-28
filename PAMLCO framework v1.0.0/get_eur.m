function [result_eur]=get_eur(x_zuobiao, y_zuobiao, banchang, jingchang)
global x_por
global y_por
global value_por
global x_sg
global y_sg
global value_sg

liefengjianju = 20;
daoliunengli = 5;
PERM_mean = 0.0005;
SG_mean = compute_meanvalue(x_zuobiao, y_zuobiao, x_sg, y_sg, banchang, jingchang, value_sg);
POR_mean = compute_meanvalue(x_zuobiao, y_zuobiao, x_por, y_por, banchang, jingchang, value_por);
result_eur = EUR12([POR_mean, PERM_mean, SG_mean, banchang, liefengjianju, jingchang, daoliunengli]);
 %result_eur = EUR11([banchang, jingchang, POR_mean]);


