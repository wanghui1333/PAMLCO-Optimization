function [x_zuobiao, y_zuobiao, position]=generate_box(jianju_jing, jianju_pai, banchang, jingchang)

x_start = 13701280 ;
x_end = 13704570 ;
y_start = 13141980 ;
y_end = 13151080 ;
diqu_kuan = x_end-x_start;
diqu_chang = y_end - y_start;
x_bianju = 10;
y_bianju  = 10;
% jianju_jing = 30; 
% jianju_pai = 80; 
% banchang = 100;
% jingchang = 2900;
% banchang_block2=100;
% jingchang_block2 = 1000;
jingshu_meipai = floor((diqu_kuan-x_bianju)/ (jianju_jing + banchang*2));
paishu = floor((diqu_chang-y_bianju) / (jingchang + jianju_pai));
for i=1:paishu
    for j=1:jingshu_meipai
        position = j+(i-1) * jingshu_meipai;
        x_zuobiao(position) = x_start + x_bianju + (j-1)*(jianju_jing + banchang*2);
        y_zuobiao(position) = y_start + y_bianju + (i-1) * (jianju_pai + jingchang);
    end
end
%zongjingshu = jingshu_meipai * paishu;

%%%%%%%%%%%%%%%%%%%%
% x_base=xlsread('小模型边界.xlsx','sheet1');
% y_base=xlsread('小模型边界.xlsx','sheet2');
% sita = 33; % 逆时针旋转30度
% xx = cosd(sita) * x_base -sind(sita) * y_base;
% yy = sind(sita) * x_base + cosd(sita) * y_base;
% plot(xx, yy)
% hold on
% for i=1:zongjingshu
%     rectangle('position',[x_zuobiao(i),y_zuobiao(i),banchang*2,jingchang],'edgecolor','r');
% end
%%%%%%%%%%%%%%%%%%%%

