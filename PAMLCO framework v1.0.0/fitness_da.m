function [S, result_all]=fitness_da(S, options)
global x_por
global y_por
global value_por
global x_sg
global y_sg
global value_sg
global tail
global x_za
global y_za
global value_za
global x_dengzhixian
global y_dengzhixian
global value_dengzhixian
global pingtai_zuobiao
global x_yali
global y_yali
global value_yali

jingchang = S(1:end-1);
banchang = options(2);
banchang = repmat(banchang, 1, length(jingchang));
anchor = options(3);
juli = options(4);
bottom = options(5);
liefengjianju = options(6);
daoliunengli = options(7);

% 产生框的坐标
[x_zuobiao, y_zuobiao] = bujing_da(anchor, jingchang, juli, bottom);
jingshu = length(x_zuobiao);
[pingtaishu, temp] = size(pingtai_zuobiao);

PERM_mean = 0.00003;
result_npv = zeros(1, jingshu);
for jing_idx=1:jingshu
    POR_mean = compute_meanvalue(x_zuobiao(jing_idx), y_zuobiao(jing_idx), x_por, y_por, banchang(jing_idx), jingchang(jing_idx), value_por);
    SG_mean = compute_meanvalue(x_zuobiao(jing_idx), y_zuobiao(jing_idx), x_sg, y_sg, banchang(jing_idx), jingchang(jing_idx), value_sg);
    YALI_mean = compute_meanvalue(x_zuobiao(jing_idx), y_zuobiao(jing_idx), x_yali, y_yali, banchang(jing_idx), jingchang(jing_idx), value_yali);
    
    jingzuobiao_idx = [x_zuobiao(jing_idx), y_zuobiao(jing_idx)];
    for top_bottom=1:2
        if top_bottom == 1
            for pingtai_idx=1:pingtaishu
                pingtaizuobiao_idx = pingtai_zuobiao(pingtai_idx, :);
                if panduan(jingzuobiao_idx, pingtaizuobiao_idx)
                    maolirun = get_lirun([POR_mean, YALI_mean, SG_mean, banchang(jing_idx), liefengjianju, jingchang(jing_idx), daoliunengli], jingzuobiao_idx, jingchang(jing_idx), pingtaizuobiao_idx, x_za, y_za, value_za, x_dengzhixian, y_dengzhixian, value_dengzhixian);
                    zuanjing_chengben = get_zuanjingchengben(jingzuobiao_idx, jingchang(jing_idx), pingtaizuobiao_idx, x_za, y_za, value_za, x_dengzhixian, y_dengzhixian, value_dengzhixian);
                    zhenlirun = maolirun - zuanjing_chengben;
                    if zhenlirun > result_npv(jing_idx)
                        result_npv(jing_idx) = zhenlirun;                   
                    end
                end
            end
        else
            jingzuobiao_fanzhuan = [jingzuobiao_idx(1), jingzuobiao_idx(2)+jingchang(jing_idx)];
            for pingtai_idx=1:pingtaishu
                pingtaizuobiao_idx = pingtai_zuobiao(pingtai_idx, :);
                if panduan(pingtaizuobiao_idx, jingzuobiao_fanzhuan)
                    maolirun = get_lirun([POR_mean, YALI_mean, SG_mean, banchang(jing_idx), liefengjianju, jingchang(jing_idx), daoliunengli], -jingzuobiao_fanzhuan, jingchang(jing_idx), -pingtaizuobiao_idx, -x_za, -y_za, value_za, -x_dengzhixian, -y_dengzhixian, value_dengzhixian);
                    zuanjing_chengben = get_zuanjingchengben(-jingzuobiao_fanzhuan, jingchang(jing_idx), -pingtaizuobiao_idx, -x_za, -y_za, value_za, -x_dengzhixian, -y_dengzhixian, value_dengzhixian);
                    zhenlirun = maolirun - zuanjing_chengben;
                    if zhenlirun > result_npv(jing_idx)
                        result_npv(jing_idx) = zhenlirun;                   
                    end        
                end
            end
        end
    end
end
result_all = sum(result_npv);

