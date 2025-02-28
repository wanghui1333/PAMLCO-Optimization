function [zongpingtaichengben] = plot_xuanzhuan(zuiyou_xzuobiao, zuiyou_yzuobiao, zuiyou_banchang, zuiyou_jingchang)
figure()
zuobiao = [18710417.95 	3226797.44 
18715432.25 	3235305.26 
18718563.45 	3233315.01 
18720052.41 	3235939.51 
18721541.37 	3234036.74 
18719198.45 	3231237.25 
18717490.52 	3228875.19 
18715738.80 	3227716.02 
18714403.12 	3227387.96 
18712848.46 	3227781.64 
18710417.95 	3226797.44 
];
x_bases = zuobiao(:,1);
y_bases = zuobiao(:,2);
plot(x_bases, y_bases)
hold on
for idx=1:length(zuiyou_jingchang)
    x_zuobiaos = [zuiyou_xzuobiao(idx), zuiyou_xzuobiao(idx)+zuiyou_banchang(idx)*2, zuiyou_xzuobiao(idx)+zuiyou_banchang(idx)*2, zuiyou_xzuobiao(idx), zuiyou_xzuobiao(idx)];
    y_zuobiaos = [zuiyou_yzuobiao(idx), zuiyou_yzuobiao(idx), zuiyou_yzuobiao(idx)+zuiyou_jingchang(idx), zuiyou_yzuobiao(idx)+zuiyou_jingchang(idx), zuiyou_yzuobiao(idx)];
    sita = -30;
    x_xuanzhuan = cosd(sita) * x_zuobiaos -sind(sita) * y_zuobiaos;
    y_xuanzhuan = sind(sita) * x_zuobiaos + cosd(sita) * y_zuobiaos;
    plot(x_xuanzhuan, y_xuanzhuan, 'r')
end
figure()
sita = 30;
x_yuanlai = cosd(sita) * x_bases -sind(sita) * y_bases;
y_yuanlai = sind(sita) * x_bases + cosd(sita) * y_bases;
plot(x_yuanlai, y_yuanlai)
hold on
for idx=1:length(zuiyou_jingchang)
    x_zuobiaos = [zuiyou_xzuobiao(idx), zuiyou_xzuobiao(idx)+zuiyou_banchang(idx)*2, zuiyou_xzuobiao(idx)+zuiyou_banchang(idx)*2, zuiyou_xzuobiao(idx), zuiyou_xzuobiao(idx)];
    y_zuobiaos = [zuiyou_yzuobiao(idx), zuiyou_yzuobiao(idx), zuiyou_yzuobiao(idx)+zuiyou_jingchang(idx), zuiyou_yzuobiao(idx)+zuiyou_jingchang(idx), zuiyou_yzuobiao(idx)];
    plot(x_zuobiaos, y_zuobiaos, 'r')
end
