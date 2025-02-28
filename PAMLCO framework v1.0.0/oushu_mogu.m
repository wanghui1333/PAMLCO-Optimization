function [pingtai_real]=oushu_mogu(jing_zuobiao, zuiyou_banchang)
% zuiyou_xzuobiao = [-14379278.4902297,-14378958.9204595,-14378639.3506892,-14378319.7809190];
% zuiyou_yzuobiao = [-12421029.5499158,-12420626.3876731,-12420827.9687944,-12420424.8065517];
% zuiyou_banchang = [134.784885129320,134.784885129320,134.784885129320,134.784885129320];
% zuiyou_jingchang = [2726.30268739662,2868.67312344225,2910.75640990896,3152.92808425602];
% jing_zuobiao = [zuiyou_xzuobiao'+zuiyou_banchang', zuiyou_yzuobiao'];
zuiyou_xzuobiao = jing_zuobiao(:, 1) - zuiyou_banchang';
zuiyou_yzuobiao = jing_zuobiao(:, 2);
pingtai_candidate = [];
pingtai_real = [];
% 开始求解各种交点
% 偶数井求中间两个圆的交点
syms x y
r_first = 344;
r_second = 344;
shuliang = length(jing_zuobiao);
mid_index = ceil(shuliang / 2);
zuobiao_first = jing_zuobiao(mid_index, :);
zuobiao_second = jing_zuobiao(mid_index+1, :);
[x,y] = solve((x-zuobiao_first(1))^2+(y-zuobiao_first(2))^2-r_first^2,(x-zuobiao_second(1))^2+(y-zuobiao_second(2))^2-r_second^2);
position_x = vpa(x, 5); position_y = vpa(y, 5);
pingtai_candidate = [pingtai_candidate; [position_x, position_y]];
% 偶数井求最低圆与水平直线的交点
syms x y
[y_min, index_min] = min(zuiyou_yzuobiao);
x_center = jing_zuobiao(index_min, 1);
zuobiao_first = [x_center, y_min]; % 最低圆
x_min = min(jing_zuobiao(:, 1)) - 512;
x_max = min(jing_zuobiao(:, 1)) + 512;
[x,y] = solve((x-zuobiao_first(1))^2+(y-zuobiao_first(2))^2-r_first^2, y-y_min);
position_x = vpa(x, 5); position_y = vpa(y, 5);
pingtai_candidate = [pingtai_candidate; [position_x, position_y]];

% 偶数井求中间俩圆与中间竖向直线的交点
syms x y
zuobiao_first = jing_zuobiao(mid_index, :);
y_min = zuobiao_first(2) - 512;
y_max = zuobiao_first(2) + 512;

x_min = min(zuiyou_xzuobiao);
x_max = max(zuiyou_xzuobiao) + zuiyou_banchang(1) * 2;
x_index = (x_max-x_min) / 2 + x_min;
[x,y] = solve((x-zuobiao_first(1))^2+(y-zuobiao_first(2))^2-r_first^2, x-x_index);
position_x = vpa(x, 5); position_y = vpa(y, 5);
pingtai_candidate = [pingtai_candidate; [position_x, position_y]];

%%%%%%%%%
syms x y
zuobiao_first = jing_zuobiao(mid_index+1, :);
y_min = zuobiao_first(2) - 512;
y_max = zuobiao_first(2) + 512;

x_min = min(zuiyou_xzuobiao);
x_max = max(zuiyou_xzuobiao) + zuiyou_banchang(1) * 2;
x_index = (x_max-x_min) / 2 + x_min;
[x,y] = solve((x-zuobiao_first(1))^2+(y-zuobiao_first(2))^2-r_first^2, x-x_index);
position_x = vpa(x, 5); position_y = vpa(y, 5);
pingtai_candidate = [pingtai_candidate; [position_x, position_y]];

[dianshu, temp] = size(pingtai_candidate);
for idx=1:dianshu
    if panduan(jing_zuobiao, double(pingtai_candidate(idx, :))) && isreal(pingtai_candidate(idx, :))
        pingtai_real = [pingtai_real; pingtai_candidate(idx, :)];
    end
end