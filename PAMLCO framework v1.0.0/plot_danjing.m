function [] = plot_danjing(x_zuobiao, y_zuobiao, banchang, jingchang, liefengjianju, daoliunengli)
% x_zuobiao = [14375387.9700000];
% y_zuobiao = [12412663.5668650];
% banchang = [98];
% jingchang = [4630.22197180603];
global x_por
global y_por
global value_por
global x_sg
global y_sg
global value_sg
output_x(1) = x_zuobiao;
output_y(1) = y_zuobiao;
rectangle('position',[output_x(1), output_y(1), banchang*2, jingchang(1)], 'EdgeColor','r');
POR_mean = compute_meanvalue(output_x(1), output_y(1), x_por, y_por, banchang(1), jingchang(1), value_por);
SG_mean = compute_meanvalue(output_x(1), output_y(1), x_sg, y_sg, banchang(1), jingchang(1), value_sg);
danjingchengben = NPV0719([POR_mean, 0.0005, SG_mean, banchang, liefengjianju, jingchang(1), daoliunengli], [x_zuobiao + banchang, y_zuobiao], jingchang, [x_zuobiao + banchang, y_zuobiao-344]);
text(output_x(1), output_y(1), num2str(round(danjingchengben/1000000)))
jingshu = length(jingchang);
if jingshu > 1
    for idx=2:length(jingchang)
        output_x(idx) = x_zuobiao;
        output_y(idx) =  output_y(idx-1) + jingchang(idx-1) + 50;
        rectangle('position',[output_x(idx), output_y(idx), banchang*2, jingchang(idx)], 'EdgeColor','r');
        POR_mean = compute_meanvalue(output_x(idx), output_y(idx), x_por, y_por, banchang, jingchang(idx), value_por);
        SG_mean = compute_meanvalue(output_x(idx), output_y(idx), x_sg, y_sg, banchang, jingchang(idx), value_sg);

        danjingchengben = NPV0719([POR_mean, 0.0005, SG_mean, banchang, 20, jingchang(idx), 5]);
        text(output_x(idx), output_y(idx), num2str(round(danjingchengben/1000000)))

    end
end