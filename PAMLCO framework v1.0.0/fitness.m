function [S, zhenlirun]=fitness(S, options)
banchang = S(1);
liefengjianju = S(2);
daoliunengli = S(3);
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
global zuiyoulirun

global zuiyoulirun
global tail

zonglirun = [];
zuiyou_xzuobiao = [];
zuiyou_yzuobiao = [];
zuiyou_jingchang = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%第一个区域
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
x_base = cosd(sita) * x_bases -sind(sita) * y_bases;
y_base = sind(sita) * x_bases + cosd(sita) * y_bases;

start_jing = min(x_base);
end_jing = max(x_base);
liejianju = 50;

for anchor=start_jing+banchang:banchang*2+liejianju:end_jing-banchang
    [juli, bottom] = juli_bottom1(anchor);
    x_zuobiao = anchor;
    jingshu_max = floor(juli / 2000);
    juli = juli(jingshu_max >= 1);
    bottom = bottom(jingshu_max >= 1);
    jingshu_max = jingshu_max(jingshu_max >= 1);
    for quyu = 1:length(jingshu_max);
        if jingshu_max > 0
            [max_maishen, min_maishen] = find_maxmaishen(anchor);
            range_jinglength = [1000, min(juli(quyu), 4800-min_maishen)];
            range_jinglength = repmat(range_jinglength, jingshu_max(quyu), 1);
            data = [banchang, x_zuobiao, juli(quyu), bottom(quyu), liefengjianju, daoliunengli];
            x = gaot(range_jinglength, 'fitness_da', data, [], [], 'maxGenTerm',1);
            if x(end) > 0
                zonglirun = [zonglirun, x(end)];
                for jingshu_valid=1:jingshu_max(quyu) % 计数该列能布几口井
                    if sum(x(1:jingshu_valid)) + jingshu_valid * 50 - 50 >= juli
                        break;
                    end
                end
                jingshu_valid = max(jingshu_valid - 1, 1);
                zuiyou_jingchang = [zuiyou_jingchang, x(1:jingshu_valid)];
                [output_xzuobiao, output_yzuobiao] = bujing_da(x_zuobiao, x(1:jingshu_valid), juli(quyu), bottom(quyu));
                zuiyou_xzuobiao = [zuiyou_xzuobiao, output_xzuobiao];
                zuiyou_yzuobiao = [zuiyou_yzuobiao, output_yzuobiao];
            end
        end
    end
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%第二个区域
zuobiao = [18.7168	3.23136
18.7186	3.23332
18.717	3.23438
18.7167	3.23374
18.7168	3.23136
]*1e6;
x_bases = zuobiao(:,1);
y_bases = zuobiao(:,2);
sita = 30;
x_base = cosd(sita) * x_bases -sind(sita) * y_bases;
y_base = sind(sita) * x_bases + cosd(sita) * y_bases;

start_jing = min(x_base);
end_jing = max(x_base);
liejianju = 50;


for anchor=start_jing+banchang:banchang*2+liejianju:end_jing-banchang
    [juli, bottom] = juli_bottom2(anchor);
    x_zuobiao = anchor;
    jingshu_max = floor(juli / 2000);
    juli = juli(jingshu_max >= 1);
    bottom = bottom(jingshu_max >= 1);
    jingshu_max = jingshu_max(jingshu_max >= 1);
    for quyu = 1:length(jingshu_max);
        if jingshu_max > 0
            [max_maishen, min_maishen] = find_maxmaishen(anchor);
            range_jinglength = [1000, min(juli(quyu), 5400-min_maishen)];
            range_jinglength = repmat(range_jinglength, jingshu_max(quyu), 1);
            data = [banchang, x_zuobiao, juli(quyu), bottom(quyu), liefengjianju, daoliunengli];
            x = gaot(range_jinglength, 'fitness_da', data, [], [], 'maxGenTerm',1);
            if x(end) > 0
                zonglirun = [zonglirun, x(end)];
                for jingshu_valid=1:jingshu_max(quyu) % 计数该列能布几口井
                    if sum(x(1:jingshu_valid)) + jingshu_valid * 50 - 50 >= juli
                        break;
                    end
                end
                jingshu_valid = max(jingshu_valid - 1, 1);
                zuiyou_jingchang = [zuiyou_jingchang, x(1:jingshu_valid)];
                [output_xzuobiao, output_yzuobiao] = bujing_da(x_zuobiao, x(1:jingshu_valid), juli(quyu), bottom(quyu));
                zuiyou_xzuobiao = [zuiyou_xzuobiao, output_xzuobiao];
                zuiyou_yzuobiao = [zuiyou_yzuobiao, output_yzuobiao];
            end
        end
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%第三个区域
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
x_base = cosd(sita) * x_bases -sind(sita) * y_bases;
y_base = sind(sita) * x_bases + cosd(sita) * y_bases;

start_jing = min(x_base);
end_jing = max(x_base);
liejianju = 50;

for anchor=start_jing+banchang:banchang*2+liejianju:end_jing-banchang
    [juli, bottom] = juli_bottom3(anchor);
    x_zuobiao = anchor;
    jingshu_max = floor(juli / 2000);
    juli = juli(jingshu_max >= 1);
    bottom = bottom(jingshu_max >= 1);
    jingshu_max = jingshu_max(jingshu_max >= 1);
    for quyu = 1:length(jingshu_max);
        if jingshu_max > 0
            [max_maishen, min_maishen] = find_maxmaishen(anchor);
            range_jinglength = [1000, min(juli(quyu), 5500-min_maishen)];
            range_jinglength = repmat(range_jinglength, jingshu_max(quyu), 1);
            data = [banchang, x_zuobiao, juli(quyu), bottom(quyu), liefengjianju, daoliunengli];
            x = gaot(range_jinglength, 'fitness_da', data, [], [], 'maxGenTerm',1);
            if x(end) > 0
                zonglirun = [zonglirun, x(end)];
                for jingshu_valid=1:jingshu_max(quyu) % 计数该列能布几口井
                    if sum(x(1:jingshu_valid)) + jingshu_valid * 50 - 50 >= juli
                        break;
                    end
                end
                jingshu_valid = max(jingshu_valid - 1, 1);
                zuiyou_jingchang = [zuiyou_jingchang, x(1:jingshu_valid)];
                [output_xzuobiao, output_yzuobiao] = bujing_da(x_zuobiao, x(1:jingshu_valid), juli(quyu), bottom(quyu));
                zuiyou_xzuobiao = [zuiyou_xzuobiao, output_xzuobiao];
                zuiyou_yzuobiao = [zuiyou_yzuobiao, output_yzuobiao];
            end
        end
    end
end

zuiyou_banchang = repmat(banchang, 1, length(zuiyou_jingchang));
zuiyou_jianju = repmat(liefengjianju, 1, length(zuiyou_jingchang));
zuiyou_daoliu = repmat(daoliunengli, 1, length(zuiyou_jingchang));

if sum(zonglirun) > 0 
    [zhenlirun] = pingtai_guding(zuiyou_xzuobiao, zuiyou_yzuobiao, zuiyou_banchang, zuiyou_jingchang, liefengjianju, daoliunengli);
    if zhenlirun > zuiyoulirun
        zuiyoulirun = zhenlirun;
        zuiyoulirun_store = repmat(zuiyoulirun, 1, length(zuiyou_jingchang));
        results_strore = [zuiyou_xzuobiao; zuiyou_yzuobiao; zuiyou_banchang; zuiyou_jingchang; zuiyoulirun_store; zuiyou_jianju; zuiyou_daoliu];
        delete('best.xlsx')
        xlswrite('best.xlsx', results_strore)
    end

else
    zhenlirun = sum(zonglirun)
end

