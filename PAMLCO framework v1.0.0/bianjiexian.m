function [pingtaizuobiao_anchor] = bianjiexian(jingzuobiao_pingtai, pingtaizuobiao_hebing, jingchang) % 更新一次平台坐标
% clear all;
% clc;
% pingtaizuobiao_hebing = [7.037506646249924e+05, 3.225296836002114e+06];
% jingzuobiao_pingtai = [702835.393053400,3225538.39764843;
%                 703179.239160200,3225683.30136282;
%                 703523.085267000,3225828.20507721;
%                 703866.931373800,3225973.10879160;
%                 704210.777480600,3226118.01250599;
%                 704554.623587400,3226262.91622038;
%                 704898.469694200,3226407.81993477];
% jingchang = [2163.86780100000,2474.41595800000,2784.91063300000,3095.50883800000,3406.02971000000,3716.48801200000,1441.13071900000];
[YA, index] = min(jingzuobiao_pingtai(:, 2));
XA = jingzuobiao_pingtai(index, 1);
chengben_pingtai = qukuai_zuanjing(jingzuobiao_pingtai, jingchang, pingtaizuobiao_hebing);
count = 1;
pingbaizuobiao_record = [];
for Xi=XA-3000*sind(10):20:XA+3000*sind(10)
    if Xi>=XA-3000*sind(10) && Xi<XA-350*sind(10)
        Yi=tand(10)*Xi+YA-tand(10)*XA;
    elseif Xi>=XA-350*sind(10)&& Xi<XA+350*sind(10)
        Yi=YA-sqrt(350^2-(Xi-XA)^2);
    elseif Xi>=XA+350*sind(10)&& Xi<XA+3000*sind(10)
        Yi=-tand(10)*Xi+YA+tand(10)*XA;
    end
    pingtaizuobiao_hebing = [Xi, Yi];
    pingbaizuobiao_record = [pingbaizuobiao_record; pingtaizuobiao_hebing];
    chengben_pingtai(count) = qukuai_zuanjing(jingzuobiao_pingtai, jingchang, pingtaizuobiao_hebing);
    rectangle('position',[Xi-50, Yi, 100, 100], 'FaceColor',[0 1 0]);
    count = count + 1;

end
[vals,index] = min(chengben_pingtai, [], 2);
pingtaizuobiao_anchor = pingbaizuobiao_record(index, :);


 