function [eur11_output, eur_fracture_output, npv_output, chengben_zuanjing, Vyalieye, Vzhichengji, chanliang]=get_xiaohui(x_zuobiao, y_zuobiao, banchang, jingchang, liefengjianju, daoliunengli, pingtai_zuobiao)
global x_por
global y_por
global value_por
global x_sg
global y_sg
global value_sg
global tail

% 产生框的坐标
jingshu = length(x_zuobiao);
PERM_mean = 0.00003;
for i=1:jingshu
    POR_mean = compute_meanvalue(x_zuobiao(i), y_zuobiao(i), x_por, y_por, banchang(i), jingchang(i), value_por);
    SG_mean = compute_meanvalue(x_zuobiao(i), y_zuobiao(i), x_sg, y_sg, banchang(i), jingchang(i), value_sg);

    [eur11_output, eur_fracture_output, npv_output, Vyalieye, Vzhichengji, chanliang] = get_npv([POR_mean, PERM_mean, SG_mean, banchang(i), liefengjianju, jingchang(i), daoliunengli], [x_zuobiao(i), y_zuobiao(i)], jingchang(i), pingtai_zuobiao);
    chengben_zuanjing = qukuai_zuanjing([x_zuobiao(i), y_zuobiao(i)], jingchang(i), pingtai_zuobiao);
end

