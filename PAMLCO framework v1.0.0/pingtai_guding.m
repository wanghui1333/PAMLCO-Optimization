function [lirun] = pingtai_guding(zuiyou_xzuobiao, zuiyou_yzuobiao, zuiyou_banchang, zuiyou_jingchang, zuiyou_jianju, zuiyou_daoliu)

global gprMdl_1
global gprMdl_2
global gprMdl_3

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
global pingtai_zuobiao
global x_yali
global y_yali
global value_yali

PERM_mean = 0.00003;
jing_zuobiao = [zuiyou_xzuobiao', zuiyou_yzuobiao'];
[jingshu, temp] = size(jing_zuobiao);
[pingtaishu, temp] = size(pingtai_zuobiao);

lianjie_flag = zeros(1, jingshu);
bottom_flag = zeros(1, jingshu);
max_lirun =zeros(1, jingshu);
for jing_idx = 1:jingshu
    for top_bottom=1:2
        jingzuobiao_idx = jing_zuobiao(jing_idx, :);
        for pingtai_idx=1:pingtaishu
            pingtaizuobiao_idx = pingtai_zuobiao(pingtai_idx, :);
            if top_bottom == 1
                if panduan(jingzuobiao_idx, pingtaizuobiao_idx)
                    POR_mean = compute_meanvalue(jingzuobiao_idx(1), jingzuobiao_idx(2), x_por, y_por, zuiyou_banchang(jing_idx), zuiyou_jingchang(jing_idx), value_por);
                    SG_mean = compute_meanvalue(jingzuobiao_idx(1), jingzuobiao_idx(2), x_sg, y_sg, zuiyou_banchang(jing_idx), zuiyou_jingchang(jing_idx), value_sg);
                    YALI_mean = compute_meanvalue(jingzuobiao_idx(1), jingzuobiao_idx(2), x_yali, y_yali, zuiyou_banchang(jing_idx), zuiyou_jingchang(jing_idx), value_yali);
                               
                    maolirun = get_lirun([POR_mean, YALI_mean, SG_mean, zuiyou_banchang(jing_idx), zuiyou_jianju, zuiyou_jingchang(jing_idx), zuiyou_daoliu], jingzuobiao_idx, zuiyou_jingchang(jing_idx), pingtaizuobiao_idx, x_za, y_za, value_za, x_dengzhixian, y_dengzhixian, value_dengzhixian);
                    zuanjing_chengben = get_zuanjingchengben(jingzuobiao_idx, zuiyou_jingchang(jing_idx), pingtaizuobiao_idx, x_za, y_za, value_za, x_dengzhixian, y_dengzhixian, value_dengzhixian);
                    zhenlirun = maolirun - zuanjing_chengben;
                    if zhenlirun > max_lirun(jing_idx)
                        max_lirun(jing_idx) = zhenlirun;
                        lianjie_flag(jing_idx) = pingtai_idx;
                        bottom_flag(jing_idx) = top_bottom;
                    end
                end
            else
                jingzuobiao_fanzhuan = [jingzuobiao_idx(1), jingzuobiao_idx(2)+zuiyou_jingchang(jing_idx)];                
                if panduan(pingtaizuobiao_idx, jingzuobiao_fanzhuan)
                    POR_mean = compute_meanvalue(jingzuobiao_idx(1), jingzuobiao_idx(2), x_por, y_por, zuiyou_banchang(jing_idx), zuiyou_jingchang(jing_idx), value_por);
                    SG_mean = compute_meanvalue(jingzuobiao_idx(1), jingzuobiao_idx(2), x_sg, y_sg, zuiyou_banchang(jing_idx), zuiyou_jingchang(jing_idx), value_sg);
                    YALI_mean = compute_meanvalue(jingzuobiao_idx(1), jingzuobiao_idx(2), x_yali, y_yali, zuiyou_banchang(jing_idx), zuiyou_jingchang(jing_idx), value_yali);                    
                    
                    maolirun = get_lirun([POR_mean, YALI_mean, SG_mean, zuiyou_banchang(jing_idx), zuiyou_jianju, zuiyou_jingchang(jing_idx), zuiyou_daoliu], -jingzuobiao_fanzhuan, zuiyou_jingchang(jing_idx), -pingtaizuobiao_idx, -x_za, -y_za, value_za, -x_dengzhixian, -y_dengzhixian, value_dengzhixian);
                    zuanjing_chengben = get_zuanjingchengben(-jingzuobiao_fanzhuan, zuiyou_jingchang(jing_idx), -pingtaizuobiao_idx, -x_za, -y_za, value_za, -x_dengzhixian, -y_dengzhixian, value_dengzhixian);
                    zhenlirun = maolirun - zuanjing_chengben;
                    if zhenlirun > max_lirun(jing_idx)
                        max_lirun(jing_idx) = zhenlirun;
                        lianjie_flag(jing_idx) = pingtai_idx;
                        bottom_flag(jing_idx) = top_bottom;
                    end                    
                end
            end
        end
    end
end
pingtai_lirun = zeros(1, pingtaishu);
for idx=1:pingtaishu
    if sum(lianjie_flag==idx)
        pingtai_lirun(idx) = sum(max_lirun(lianjie_flag==idx))-300000*sum(lianjie_flag==idx)-8000000;
    end
end
lirun = sum(pingtai_lirun);


