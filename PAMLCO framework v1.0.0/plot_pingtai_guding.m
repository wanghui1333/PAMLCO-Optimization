clear all
clc
close all

global gprMdl_1
global gprMdl_2
global gprMdl_3


temp = load('models/model_1');
gprMdl_1 = temp.gprMdl_idx;
temp = load('models/model_2');
gprMdl_2 = temp.gprMdl_idx;
temp = load('models/model_3');
gprMdl_3 = temp.gprMdl_idx;

data_results = xlsread('./best.xlsx'); % 保存的是中央坐标
zuiyou_xzuobiao = data_results(1, :);
zuiyou_yzuobiao = data_results(2, :);
zuiyou_banchang = data_results(3, :);
zuiyou_jingchang = data_results(4, :);
zuiyou_jianju = data_results(6, :);
zuiyou_daoliu = data_results(7, :);

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
sita = 30;
x_base = cosd(sita) * x_bases -sind(sita) * y_bases;
y_base = sind(sita) * x_bases + cosd(sita) * y_bases;

zuobiao = [18.7132	3.22761
18.7142	3.22875
18.7186	3.23332
18.7201	3.23595
18.7216	3.234
18.7176	3.22893
18.7159	3.22769
18.7144	3.22733
18.7132	3.22761
]*1e6;
x_bases = zuobiao(:,1);
y_bases = zuobiao(:,2);
sita = 30;
x_base1 = cosd(sita) * x_bases -sind(sita) * y_bases;
y_base1 = sind(sita) * x_bases + cosd(sita) * y_bases;

zuobiao = [18.7168	3.23136
18.7186	3.23332
18.717	3.23438
18.7167	3.23374
18.7168	3.23136
]*1e6;
x_bases = zuobiao(:,1);
y_bases = zuobiao(:,2);
sita = 30;
x_base2 = cosd(sita) * x_bases -sind(sita) * y_bases;
y_base2 = sind(sita) * x_bases + cosd(sita) * y_bases;

zuobiao = [18.7105	3.22676
18.7129	3.22765
18.7132	3.22761
18.7142	3.22875
18.7146	3.22918
18.7165	3.2321
18.7167	3.23374
18.717	3.23438
18.7154	3.23538
18.7105	3.22676
]*1e6;
x_bases = zuobiao(:,1);
y_bases = zuobiao(:,2);
sita = 30;
x_base3 = cosd(sita) * x_bases -sind(sita) * y_bases;
y_base3 = sind(sita) * x_bases + cosd(sita) * y_bases;

global x_por
global y_por
global value_por
global x_sg
global y_sg
global value_sg
global x_za
global y_za
global value_za
global x_dengzhixian
global y_dengzhixian
global value_dengzhixian

data_por = xlsread('./por.xlsx');
x_por = data_por(:, 1)';
y_por = data_por(:, 2)';
value_por = data_por(:, 3)'*0.01;

data_sg = xlsread('./sg.xlsx');
x_sg = data_sg(:, 1)';
y_sg = data_sg(:, 2)';
value_sg = data_sg(:, 3)';

data_za = xlsread('./za.xlsx');
x_za = data_za(:, 1)';
x_za = round(x_za);
y_za = data_za(:, 2)';
value_za = data_za(:, 3)';

data_dengzhixian = xlsread('./dengzhixian.xlsx');
x_dengzhixian = data_dengzhixian(:, 1)';
x_dengzhixian = round(x_dengzhixian);
y_dengzhixian = data_dengzhixian(:, 2)';
value_dengzhixian = data_dengzhixian(:, 3)';

data_yali = xlsread('./yali.xlsx');
x_bases = data_yali(:, 1);
y_bases = data_yali(:, 2);
value_yali = data_yali(:, 3);
sita = 30;
x_yali = cosd(sita) * x_bases -sind(sita) * y_bases;
y_yali = sind(sita) * x_bases + cosd(sita) * y_bases;

data_kuangqu = xlsread('./pingtai_zuobiao.xlsx', 'jiaoye');
x_bases = data_kuangqu(:, 4);
y_bases = data_kuangqu(:, 5);
pingtai_zuobiao(:, 1) = cosd(sita) * x_bases -sind(sita) * y_bases;
pingtai_zuobiao(:, 2) = sind(sita) * x_bases + cosd(sita) * y_bases;

PERM_mean = 0.00003;
jing_zuobiao = [zuiyou_xzuobiao', zuiyou_yzuobiao'];
[jingshu, temp] = size(jing_zuobiao);
[pingtaishu, temp] = size(pingtai_zuobiao);

figure()
plot(x_base, y_base);
hold on;

for idx=1:jingshu
    rectangle('position',[zuiyou_xzuobiao(idx)-zuiyou_banchang(idx), zuiyou_yzuobiao(idx), zuiyou_banchang(idx)*2, zuiyou_jingchang(idx)], 'EdgeColor','r');
    text(zuiyou_xzuobiao(idx), zuiyou_yzuobiao(idx), num2str(idx))
end
for idx=1:pingtaishu
    rectangle('position',[pingtai_zuobiao(idx, 1)-50, pingtai_zuobiao(idx, 2), 100, 100], 'FaceColor',[0 1 0]);
    text(pingtai_zuobiao(idx, 1), pingtai_zuobiao(idx, 2), num2str(idx))
end

lianjie_flag = zeros(1, jingshu);
bottom_flag = zeros(1, jingshu);
max_lirun =zeros(1, jingshu);
zuanjing_chengbenall = [];
eur11_outputall = [];
eur_fracture_outputall = [];
Vyalieyeall = [];
Vzhichengjiall = [];
maolirunall = [];
chanliangall = [];
well_lengthall = [];
for jing_idx = 1:jingshu
    rectangle('position',[zuiyou_xzuobiao(jing_idx)-zuiyou_banchang(jing_idx), zuiyou_yzuobiao(jing_idx), zuiyou_banchang(jing_idx)*2, zuiyou_jingchang(jing_idx)], 'EdgeColor','g');
    for top_bottom=1:2
        jingzuobiao_idx = jing_zuobiao(jing_idx, :);
        for pingtai_idx=1:pingtaishu
            rectangle('position',[pingtai_zuobiao(pingtai_idx, 1)-50, pingtai_zuobiao(pingtai_idx, 2), 100, 100], 'FaceColor',[1 0 0]);
            pingtaizuobiao_idx = pingtai_zuobiao(pingtai_idx, :);
            if top_bottom == 1
                if panduan(jingzuobiao_idx, pingtaizuobiao_idx)
                    POR_mean = compute_meanvalue(jingzuobiao_idx(1), jingzuobiao_idx(2), x_por, y_por, zuiyou_banchang(jing_idx), zuiyou_jingchang(jing_idx), value_por);
                    SG_mean = compute_meanvalue(jingzuobiao_idx(1), jingzuobiao_idx(2), x_sg, y_sg, zuiyou_banchang(jing_idx), zuiyou_jingchang(jing_idx), value_sg);
                    YALI_mean = compute_meanvalue(jingzuobiao_idx(1), jingzuobiao_idx(2), x_yali, y_yali, zuiyou_banchang(jing_idx), zuiyou_jingchang(jing_idx), value_yali);
                    
                    [eur11_output, eur_fracture_output, maolirun, Vyalieye, Vzhichengji, chanliang] = get_xiaohui([POR_mean, YALI_mean, SG_mean, zuiyou_banchang(jing_idx), zuiyou_jianju(jing_idx), zuiyou_jingchang(jing_idx), zuiyou_daoliu(jing_idx)], jingzuobiao_idx, zuiyou_jingchang(jing_idx), pingtaizuobiao_idx, x_za, y_za, value_za, x_dengzhixian, y_dengzhixian, value_dengzhixian);
                    zuanjing_chengben = get_zuanjingchengben(jingzuobiao_idx, zuiyou_jingchang(jing_idx), pingtaizuobiao_idx, x_za, y_za, value_za, x_dengzhixian, y_dengzhixian, value_dengzhixian);
                    well_length = get_well_length(jingzuobiao_idx, zuiyou_jingchang(jing_idx), pingtaizuobiao_idx, x_za, y_za, value_za, x_dengzhixian, y_dengzhixian, value_dengzhixian);
                    zhenlirun = maolirun - zuanjing_chengben;
                    if zhenlirun > max_lirun(jing_idx)
                        max_lirun(jing_idx) = zhenlirun;
                        lianjie_flag(jing_idx) = pingtai_idx;
                        bottom_flag(jing_idx) = top_bottom;
                        zuanjing_chengbenall(jing_idx) = zuanjing_chengben;
                        eur11_outputall(jing_idx) = eur11_output;
                        eur_fracture_outputall(jing_idx) = eur_fracture_output;
                        Vyalieyeall(jing_idx) = Vyalieye;
                        Vzhichengjiall(jing_idx) = Vzhichengji;
                        chanliangall(jing_idx) = chanliang;
                        maolirunall(jing_idx) = maolirun;
                        well_lengthall(jing_idx) = well_length;
                    end
                end
            else
                jingzuobiao_fanzhuan = [jingzuobiao_idx(1), jingzuobiao_idx(2)+zuiyou_jingchang(jing_idx)];
                if panduan(pingtaizuobiao_idx, jingzuobiao_fanzhuan)
                    POR_mean = compute_meanvalue(jingzuobiao_idx(1), jingzuobiao_idx(2), x_por, y_por, zuiyou_banchang(jing_idx), zuiyou_jingchang(jing_idx), value_por);
                    SG_mean = compute_meanvalue(jingzuobiao_idx(1), jingzuobiao_idx(2), x_sg, y_sg, zuiyou_banchang(jing_idx), zuiyou_jingchang(jing_idx), value_sg);
                    YALI_mean = compute_meanvalue(jingzuobiao_idx(1), jingzuobiao_idx(2), x_yali, y_yali, zuiyou_banchang(jing_idx), zuiyou_jingchang(jing_idx), value_yali);                    
                    
                    [eur11_output, eur_fracture_output, maolirun, Vyalieye, Vzhichengji, chanliang] = get_xiaohui([POR_mean, YALI_mean, SG_mean, zuiyou_banchang(jing_idx), zuiyou_jianju(jing_idx), zuiyou_jingchang(jing_idx), zuiyou_daoliu(jing_idx)], -jingzuobiao_fanzhuan, zuiyou_jingchang(jing_idx), -pingtaizuobiao_idx, -x_za, -y_za, value_za, -x_dengzhixian, -y_dengzhixian, value_dengzhixian);
                    zuanjing_chengben = get_zuanjingchengben(-jingzuobiao_fanzhuan, zuiyou_jingchang(jing_idx), -pingtaizuobiao_idx, -x_za, -y_za, value_za, -x_dengzhixian, -y_dengzhixian, value_dengzhixian);
                    well_length = get_well_length(-jingzuobiao_fanzhuan, zuiyou_jingchang(jing_idx), -pingtaizuobiao_idx, -x_za, -y_za, value_za, -x_dengzhixian, -y_dengzhixian, value_dengzhixian);                    
                    zhenlirun = maolirun - zuanjing_chengben;
                    if zhenlirun > max_lirun(jing_idx)
                        max_lirun(jing_idx) = zhenlirun;
                        lianjie_flag(jing_idx) = pingtai_idx;
                        bottom_flag(jing_idx) = top_bottom;
                        zuanjing_chengbenall(jing_idx) = zuanjing_chengben;
                        eur11_outputall(jing_idx) = eur11_output;
                        eur_fracture_outputall(jing_idx) = eur_fracture_output;
                        Vyalieyeall(jing_idx) = Vyalieye;
                        Vzhichengjiall(jing_idx) = Vzhichengji;
                        chanliangall(jing_idx) = chanliang;
                        maolirunall(jing_idx) = maolirun;    
                        well_lengthall(jing_idx) = well_length;                        
                    end                    
                end
            end
            rectangle('position',[pingtai_zuobiao(pingtai_idx, 1)-50, pingtai_zuobiao(pingtai_idx, 2), 100, 100], 'FaceColor',[0 1 0]);
        end
    end
    rectangle('position',[zuiyou_xzuobiao(jing_idx)-zuiyou_banchang(jing_idx), zuiyou_yzuobiao(jing_idx), zuiyou_banchang(jing_idx)*2, zuiyou_jingchang(jing_idx)], 'EdgeColor','r');
    if max_lirun(jing_idx)==0
        rectangle('position',[zuiyou_xzuobiao(jing_idx)-zuiyou_banchang(jing_idx), zuiyou_yzuobiao(jing_idx), zuiyou_banchang(jing_idx)*2, zuiyou_jingchang(jing_idx)], 'EdgeColor','g');
    end

end

pingtai_lirun = zeros(1, pingtaishu);
for idx=1:pingtaishu
    if sum(lianjie_flag==idx)
        pingtai_lirun(idx) = sum(max_lirun(lianjie_flag==idx))-300000*sum(lianjie_flag==idx)-8000000;
    end
end
real_pingtaishu = sum(pingtai_lirun~=0);
real_jingshu = sum(max_lirun~=0);
lirun = sum(pingtai_lirun)
lirun2 = sum(maolirunall)-sum(zuanjing_chengbenall)-real_jingshu*300000-real_pingtaishu*8000000;
lirun3 = sum(eur11_outputall)-sum(eur_fracture_outputall)-real_jingshu*5000000-sum(zuanjing_chengbenall)-real_jingshu*300000-real_pingtaishu*8000000;


figure()
hold on
plot(x_base, y_base);
for idx=1:pingtaishu
    rectangle('position',[pingtai_zuobiao(idx, 1)-50, pingtai_zuobiao(idx, 2), 100, 100], 'FaceColor',[0 1 0]);
end
juli = [];
for idx=1:jingshu
    if max_lirun(idx)>0
        rectangle('position',[zuiyou_xzuobiao(idx)-zuiyou_banchang(idx), zuiyou_yzuobiao(idx), zuiyou_banchang(idx)*2, zuiyou_jingchang(idx)], 'EdgeColor','r');
        if bottom_flag(idx)==1
            plot([jing_zuobiao(idx, 1), pingtai_zuobiao(lianjie_flag(idx), 1)],[jing_zuobiao(idx, 2), pingtai_zuobiao(lianjie_flag(idx), 2)], 'c')
        elseif bottom_flag(idx)==2
            jingzuobiao_fanzhuan = [jing_zuobiao(idx, 1), jing_zuobiao(idx, 2)+zuiyou_jingchang(idx)];
            plot([jing_zuobiao(idx, 1), pingtai_zuobiao(lianjie_flag(idx), 1)],[jing_zuobiao(idx, 2)+zuiyou_jingchang(idx), pingtai_zuobiao(lianjie_flag(idx), 2)], 'm')
        end
    end
end


figure()
hold on
sita = -30;
x_origin = cosd(sita) * x_base -sind(sita) * y_base;
y_origin = sind(sita) * x_base + cosd(sita) * y_base;
plot(x_origin, y_origin)
for idx=1:pingtaishu
    pingtaix_xuanzhuan(idx) = cosd(sita) * pingtai_zuobiao(idx, 1) -sind(sita) * pingtai_zuobiao(idx, 2);
    pingtaiy_yuanzhuan(idx) = sind(sita) * pingtai_zuobiao(idx, 1) + cosd(sita) * pingtai_zuobiao(idx, 2);
    rectangle('position',[pingtaix_xuanzhuan(idx)-50, pingtaiy_yuanzhuan(idx), 100, 100], 'FaceColor',[0 1 0]);
end

zuiyou_xzuobiao = zuiyou_xzuobiao - zuiyou_banchang(1);
jing_output = [];
for idx=1:jingshu
    if max_lirun(idx)>0
        jing_output = [jing_output, [data_results(:, idx);zuanjing_chengbenall(idx);eur11_outputall(idx); eur_fracture_outputall(idx); maolirunall(idx); Vyalieyeall(idx); Vzhichengjiall(idx); chanliangall(idx); well_lengthall(idx)]];
        x_zuobiaos = [zuiyou_xzuobiao(idx), zuiyou_xzuobiao(idx)+zuiyou_banchang(idx)*2, zuiyou_xzuobiao(idx)+zuiyou_banchang(idx)*2, zuiyou_xzuobiao(idx), zuiyou_xzuobiao(idx)];
        y_zuobiaos = [zuiyou_yzuobiao(idx), zuiyou_yzuobiao(idx), zuiyou_yzuobiao(idx)+zuiyou_jingchang(idx), zuiyou_yzuobiao(idx)+zuiyou_jingchang(idx), zuiyou_yzuobiao(idx)];
        x_xuanzhuan = cosd(sita) * x_zuobiaos -sind(sita) * y_zuobiaos;
        y_xuanzhuan = sind(sita) * x_zuobiaos + cosd(sita) * y_zuobiaos;
        plot(x_xuanzhuan, y_xuanzhuan, 'r')                
    end
end
delete('jing_output.xlsx')
xlswrite('jing_output.xlsx', jing_output)

zuiyou_xzuobiao = zuiyou_xzuobiao + zuiyou_banchang(1);
for idx=1:jingshu
    if max_lirun(idx)>0
        if bottom_flag(idx)==1
            x_xuanzhuan = cosd(sita) * zuiyou_xzuobiao(idx) -sind(sita) * zuiyou_yzuobiao(idx);
            y_xuanzhuan = sind(sita) * zuiyou_xzuobiao(idx) + cosd(sita) * zuiyou_yzuobiao(idx);
            plot([x_xuanzhuan(1), pingtaix_xuanzhuan(lianjie_flag(idx))],[y_xuanzhuan(1), pingtaiy_yuanzhuan(lianjie_flag(idx))], 'c')
        elseif bottom_flag(idx)==2
            x_xuanzhuan = cosd(sita) * zuiyou_xzuobiao(idx) -sind(sita) * (zuiyou_yzuobiao(idx)+zuiyou_jingchang(idx));
            y_xuanzhuan = sind(sita) * zuiyou_xzuobiao(idx) + cosd(sita) * (zuiyou_yzuobiao(idx)+zuiyou_jingchang(idx));            
            plot([x_xuanzhuan(1), pingtaix_xuanzhuan(lianjie_flag(idx))],[y_xuanzhuan(1), pingtaiy_yuanzhuan(lianjie_flag(idx))], 'm')
        end
    end
end

zuobiao_jingandpingtai = [];
for idx=1:jingshu
    if max_lirun(idx)>0
        if bottom_flag(idx)==1
            x_xuanzhuan = cosd(sita) * zuiyou_xzuobiao(idx) -sind(sita) * zuiyou_yzuobiao(idx);
            y_xuanzhuan = sind(sita) * zuiyou_xzuobiao(idx) + cosd(sita) * zuiyou_yzuobiao(idx);       
            plot([x_xuanzhuan(1), pingtaix_xuanzhuan(lianjie_flag(idx))],[y_xuanzhuan(1), pingtaiy_yuanzhuan(lianjie_flag(idx))], 'c')
            temp = [x_xuanzhuan; y_xuanzhuan;pingtaix_xuanzhuan(lianjie_flag(idx));pingtaiy_yuanzhuan(lianjie_flag(idx));bottom_flag(idx)];
            zuobiao_jingandpingtai = [zuobiao_jingandpingtai, temp];                
        elseif bottom_flag(idx)==2
            x_xuanzhuan = cosd(sita) * zuiyou_xzuobiao(idx) -sind(sita) * (zuiyou_yzuobiao(idx)+zuiyou_jingchang(idx));
            y_xuanzhuan = sind(sita) * zuiyou_xzuobiao(idx) + cosd(sita) * (zuiyou_yzuobiao(idx)+zuiyou_jingchang(idx));                        
            plot([x_xuanzhuan(1), pingtaix_xuanzhuan(lianjie_flag(idx))],[y_xuanzhuan(1), pingtaiy_yuanzhuan(lianjie_flag(idx))], 'm')
            temp = [x_xuanzhuan; y_xuanzhuan;pingtaix_xuanzhuan(lianjie_flag(idx));pingtaiy_yuanzhuan(lianjie_flag(idx));bottom_flag(idx)];
            zuobiao_jingandpingtai = [zuobiao_jingandpingtai, temp];                
        end
    end
end
delete('zuobiao_jingandpingtai.xlsx')
xlswrite('zuobiao_jingandpingtai.xlsx', zuobiao_jingandpingtai)