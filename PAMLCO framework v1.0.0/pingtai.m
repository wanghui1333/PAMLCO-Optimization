function [zongchengben, maolirun, zhenlirun] = pingtai(zuiyou_xzuobiao, zuiyou_yzuobiao, zuiyou_banchang, zuiyou_jingchang, zuiyou_jianju, zuiyou_daoliu)
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
zuiyou_xzuobiao = zuiyou_xzuobiao - zuiyou_banchang;

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


data_kuangqu = xlsread('./jiaoye_kuangqu.xlsx', 'sheet1');
sita = 30;
x_kuangqu1 = cosd(sita) * data_kuangqu(:,1) -sind(sita) * data_kuangqu(:,2);
y_kuangqu1 = sind(sita) * data_kuangqu(:,1) + cosd(sita) * data_kuangqu(:,2);

data_kuangqu = xlsread('./jiaoye_kuangqu.xlsx', 'sheet2');
sita = 30;
x_kuangqu2 = cosd(sita) * data_kuangqu(:,1) -sind(sita) * data_kuangqu(:,2);
y_kuangqu2 = sind(sita) * data_kuangqu(:,1) + cosd(sita) * data_kuangqu(:,2);

data_kuangqu = xlsread('./jiaoye_kuangqu.xlsx', 'sheet3');
sita = 30;
x_kuangqu3 = cosd(sita) * data_kuangqu(:,1) -sind(sita) * data_kuangqu(:,2);
y_kuangqu3 = sind(sita) * data_kuangqu(:,1) + cosd(sita) * data_kuangqu(:,2);

data_kuangqu = xlsread('./jiaoye_kuangqu.xlsx', 'sheet4');
sita = 30;
x_kuangqu4 = cosd(sita) * data_kuangqu(:,1) -sind(sita) * data_kuangqu(:,2);
y_kuangqu4 = sind(sita) * data_kuangqu(:,1) + cosd(sita) * data_kuangqu(:,2);

data_kuangqu = xlsread('./jiaoye_kuangqu.xlsx', 'sheet5');
sita = 30;
x_kuangqu5 = cosd(sita) * data_kuangqu(:,1) -sind(sita) * data_kuangqu(:,2);
y_kuangqu5 = sind(sita) * data_kuangqu(:,1) + cosd(sita) * data_kuangqu(:,2);

data_kuangqu = xlsread('./jiaoye_kuangqu.xlsx', 'sheet6');
sita = 30;
x_kuangqu6 = cosd(sita) * data_kuangqu(:,1) -sind(sita) * data_kuangqu(:,2);
y_kuangqu6 = sind(sita) * data_kuangqu(:,1) + cosd(sita) * data_kuangqu(:,2);

start_jing = min(x_base) + 50;
end_jing = max(x_base);
anchor = start_jing;
jingshu = length(zuiyou_jingchang);

jing_zuobiao = [zuiyou_xzuobiao'+zuiyou_banchang', zuiyou_yzuobiao'];
archorx_zuobiao = [];
archory_zuobiao = [];
for idx=1:jingshu
    archorx_zuobiao(idx) = zuiyou_xzuobiao(idx) + zuiyou_banchang(idx);
    archory_zuobiao(idx) = zuiyou_yzuobiao(idx) - 344;
end
pingtai_zuobiao = [archorx_zuobiao', archory_zuobiao'];
[pingtaishu, temp] = size(pingtai_zuobiao);
for i=1:jingshu
    chengben_zuanjing(i) = qukuai_zuanjing([zuiyou_xzuobiao(i) + zuiyou_banchang(i), zuiyou_yzuobiao(i)], zuiyou_jingchang(i), [zuiyou_xzuobiao(i) + zuiyou_banchang(i), zuiyou_yzuobiao(i)-500]);
end
strcat('chengben of before optimizaiton is ---', num2str(sum(chengben_zuanjing)))

% figure()
% plot(x_base, y_base);
% hold on;
previous_symbol = 0;
cengshu = 0;
for idx=1:jingshu
%     plot_danjing(zuiyou_xzuobiao(idx), zuiyou_yzuobiao(idx), zuiyou_banchang(idx), zuiyou_jingchang(idx), zuiyou_jianju(1), zuiyou_daoliu(1))
    center = [jing_zuobiao(idx, 1), jing_zuobiao(idx, 2)];
%     filledCircle(center, 344, 1000, 'b');
end
for idx=1:pingtaishu
%     rectangle('position',[pingtai_zuobiao(idx, 1)-50, pingtai_zuobiao(idx, 2), 100, 100], 'FaceColor',[0 1 0]);
end
%计算层数
for idx=1:jingshu
    if zuiyou_xzuobiao(idx) ~= previous_symbol
        previous_symbol = zuiyou_xzuobiao(idx);
        cengshu(idx) = 1;
    else
        cengshu(idx) = cengshu(idx-1) + 1;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pingtaizuobiao_xiaohui = []; % 保存合并后平台的坐标
lianjie_flagzong = [];
jing_zuobiao_reshape = [];
zuiyou_jingchang_reshape = [];
cengshu_reshape = [];
flag_topdown_zong = [];
flag_ceng_zong = [];
pingtai_ceng_zong = [];
wufabujing = 0;
chengben_wudianfa = [];
for jdx=1:max(cengshu) % 逐排的进行计算
    jing_zuobiao_idx = jing_zuobiao(cengshu==jdx, :);
    zuiyou_banchang_idx = zuiyou_banchang(cengshu==jdx);
    zuiyou_jingchang_idx = zuiyou_jingchang(cengshu==jdx);
    [pingtaishu_pai, temp] = size(jing_zuobiao_idx);
    [jingshu_pai, temp] = size(jing_zuobiao_idx);
    chengben_minceng = 10e10;
    wudianfa_chengben = [];
    flag_topdown = [];
    flag_ceng = [];
    pingtai_ceng = [];
    tiaoguo_flag = 0;
    for weizhi=1:2
        pingtai_zuobiao_idx = [];
        pingtaizuobiao_ceng = [];
        count_pingtai = 1;
        if jdx > 1
            count_pingtai = max(lianjie_flagzong) + 1;
        end
        if weizhi == 1
            za_bottom = get_maishen(jing_zuobiao_idx);
%             if sum(inpolygon(jing_zuobiao_idx(:, 1),jing_zuobiao_idx(:, 2),x_kuangqu1,y_kuangqu1)) ~=0
%                 continue;
%             elseif sum(inpolygon(jing_zuobiao_idx(:, 1),jing_zuobiao_idx(:, 2),x_kuangqu2,y_kuangqu2)) ~=0
%                 continue;
%             elseif sum(inpolygon(jing_zuobiao_idx(:, 1),jing_zuobiao_idx(:, 2),x_kuangqu3,y_kuangqu3)) ~=0
%                 continue;
%             elseif sum(inpolygon(jing_zuobiao_idx(:, 1),jing_zuobiao_idx(:, 2),x_kuangqu4,y_kuangqu4)) ~=0
%                 continue;
%             elseif sum(inpolygon(jing_zuobiao_idx(:, 1),jing_zuobiao_idx(:, 2),x_kuangqu5,y_kuangqu5)) ~=0
%                 continue;
%             elseif sum(inpolygon(jing_zuobiao_idx(:, 1),jing_zuobiao_idx(:, 2),x_kuangqu6,y_kuangqu6)) ~=0
%                 continue;
%             end
            pingtai_zuobiao_idx(:, 1) = jing_zuobiao_idx(:, 1);
            pingtai_zuobiao_idx(:, 2) = jing_zuobiao_idx(:, 2)-344;
        elseif weizhi == 2
            continue;
            x_por = -x_por;
            y_por = -y_por;
            x_sg = -x_sg;
            y_sg = -y_sg;
            x_za = -x_za;
            y_za = -y_za;
            x_dengzhixian = -x_dengzhixian;
            y_dengzhixian = -y_dengzhixian;
            jing_zuobiao_idx(:, 2) = jing_zuobiao_idx(:, 2) + zuiyou_jingchang_idx';
%             if sum(inpolygon(jing_zuobiao_idx(:, 1),jing_zuobiao_idx(:, 2),x_kuangqu1,y_kuangqu1)) ~=0
%                 tiaoguo_flag = 1;
%                 continue;
%             elseif sum(inpolygon(jing_zuobiao_idx(:, 1),jing_zuobiao_idx(:, 2),x_kuangqu2,y_kuangqu2)) ~=0
%                 tiaoguo_flag = 1;
%                 continue;
%             elseif sum(inpolygon(jing_zuobiao_idx(:, 1),jing_zuobiao_idx(:, 2),x_kuangqu3,y_kuangqu3)) ~=0
%                 tiaoguo_flag = 1;
%                 continue;
%             elseif sum(inpolygon(jing_zuobiao_idx(:, 1),jing_zuobiao_idx(:, 2),x_kuangqu4,y_kuangqu4)) ~=0
%                 tiaoguo_flag = 1;
%                 continue;
%             elseif sum(inpolygon(jing_zuobiao_idx(:, 1),jing_zuobiao_idx(:, 2),x_kuangqu5,y_kuangqu5)) ~=0
%                 tiaoguo_flag = 1;
%                 continue;
%             elseif sum(inpolygon(jing_zuobiao_idx(:, 1),jing_zuobiao_idx(:, 2),x_kuangqu6,y_kuangqu6)) ~=0
%                 tiaoguo_flag = 1;
%                 continue;
%             end
            % 上面满足要求，180度旋转坐标和地理参数
            jing_zuobiao_idx = -jing_zuobiao_idx;
            za_top = get_maishen(jing_zuobiao_idx);
%             zuiyou_jingchang_idx = zuiyou_jingchang_idx - (za_top - za_bottom);
%             jing_zuobiao_idx(:, 2) = jing_zuobiao_idx(:, 2) + (za_top - za_bottom)';
            pingtai_zuobiao_idx(:, 1) = jing_zuobiao_idx(:, 1);
            pingtai_zuobiao_idx(:, 2) = jing_zuobiao_idx(:, 2)-344;
        end
        % 开始准备漂移，首先是计算连接情况
%         figure()
%         plot_duojing(jing_zuobiao_idx, zuiyou_banchang_idx, zuiyou_jingchang_idx, 'r')
        [jingshu, temp] = size(jing_zuobiao_idx);
        for idx=1:jingshu
%             rectangle('position',[jing_zuobiao_idx(idx, 1)-zuiyou_banchang_idx(idx), jing_zuobiao_idx(idx, 2), zuiyou_banchang_idx(idx)*2, zuiyou_jingchang_idx(idx)], 'EdgeColor','r');
%             text(jing_zuobiao_idx(idx, 1)-zuiyou_banchang_idx(idx), jing_zuobiao_idx(idx, 2)+zuiyou_jingchang_idx(idx)/2, num2str(round(zuiyou_jingchang_idx(idx))))
        end
        dis = zeros(jingshu_pai, pingtaishu_pai);
        for idx=1:jingshu_pai
            for kdx=1:pingtaishu_pai
                if panduan(jing_zuobiao_idx(idx, :), pingtai_zuobiao_idx(kdx, :)) && qukuai_zuanjing(jing_zuobiao_idx(idx, :), zuiyou_jingchang_idx(idx), pingtai_zuobiao_idx(kdx, :))< 1e10
                    dis(idx, kdx) = compute_distance(jing_zuobiao_idx(idx, :), pingtai_zuobiao_idx(kdx, :));
                else
                    dis(idx, kdx) = 10000000;
                end
            end
        end
        % 提取平台与哪个井相连,并进行连接
        [vals,index] = min(dis, [], 2);
        count_jing = zeros(1, pingtaishu_pai);
        for idx=1:jingshu_pai
            count_jing(index(idx)) = 1; % 记录哪个平台被连接了
        end
        
        chengben_pingtai = zeros(1, pingtaishu_pai);
        for idx=1:pingtaishu_pai % 准备计算每个平台的成本
            if length(jing_zuobiao_idx(index==idx, :)) ~= 0
                jingzuobiao_pingtai_hebing = jing_zuobiao_idx(index==idx, :); % 获取与idx平台连接的井
                pingtaizuobiao_hebing = pingtai_zuobiao_idx(idx, :);
                jingchang_hebing = zuiyou_jingchang_idx(index==idx);
                chengben_pingtai(idx) = qukuai_zuanjing(jingzuobiao_pingtai_hebing, jingchang_hebing, pingtaizuobiao_hebing);
            end
        end
        revisit_flag = zeros(1, pingtaishu_pai); % 标记一下某个平台是否被合并了
        lianjie_flag = zeros(1, jingshu_pai);% 标记一下哪个井连的是哪个平台
        for idx=1:pingtaishu_pai-1
            flag_wucaozuo = 1;
            if ~revisit_flag(idx) && count_jing(idx) % 判断该idx平台否被合并过，以及是否有井相连
                pingtaizuobiao_idx = pingtai_zuobiao_idx(idx, :);
                pingtaichengben_idx = chengben_pingtai(idx);
                jingzuobiao_pingtai_idx = jing_zuobiao_idx(index==idx, :);
                jingchang_idx = zuiyou_jingchang_idx(index==idx);
    %             filledCircle([jingzuobiao_pingtai_idx(1), jingzuobiao_pingtai_idx(2)], 344, 1024, 'b');
                for kdx=idx+1:idx+1
                    if ~revisit_flag(kdx) && count_jing(kdx)% 判断该kdx平台否被合并过，以及是否有井相连
                        pingtaizuobiao_kdx = pingtai_zuobiao_idx(kdx, :);
                        pingtaichengben_kdx = chengben_pingtai(kdx);
                        jingzuobiao_pingtai_kdx = jing_zuobiao_idx(index==kdx, :);
                        jingchang_kdx = zuiyou_jingchang_idx(index==kdx);
    %                     filledCircle([jingzuobiao_pingtai_kdx(1), jingzuobiao_pingtai_kdx(2)], 344, 1024, 'b');
                        % 判断两个平台是否满足要求,满足要求进行合并
                        chengben_twopingtai = pingtaichengben_idx + pingtaichengben_kdx;
                        jingzuobiao_xin = [jingzuobiao_pingtai_idx; jingzuobiao_pingtai_kdx];
                        pingtaizuobiao_xin = oushu_mogu(jingzuobiao_xin, zuiyou_banchang_idx(1));
                        if length(pingtaizuobiao_xin) ==0
                            continue;
                        end
                        jingchang_xin = [jingchang_idx, jingchang_kdx];
                        % 逐个的计算新平台坐标的成本，留下成本最低的那个
                        [xinpingtaishu, temp] = size(pingtaizuobiao_xin);
                        chengben_onepingtais = 0;
                        for qdx=1:xinpingtaishu
                            chengben_onepingtais(qdx) = qukuai_zuanjing(jingzuobiao_xin, jingchang_xin, pingtaizuobiao_xin(qdx, :));
                        end
                        [chengben_onepingtai, index_value] = min(chengben_onepingtais);
                        pingtaizuobiao_xin = pingtaizuobiao_xin(index_value, :);
%                         filledCircle([pingtaizuobiao_xin(1), pingtaizuobiao_xin(2)], 16, 1024, 'r');
                        if chengben_onepingtai < chengben_twopingtai &&  panduan(jingzuobiao_xin, pingtaizuobiao_xin)% 满足成本降低的要求，进行合并,得到新的平台阻坐标
                            flag_wucaozuo = 0;
                            revisit_flag(idx) = 1;
                            revisit_flag(kdx) = 1;
                            lianjie_flag(index==idx) = count_pingtai;
                            lianjie_flag(index==kdx) = count_pingtai;
                            count_pingtai = count_pingtai+1;
                            pingtaizuobiao_ceng = [pingtaizuobiao_ceng; pingtaizuobiao_xin];
                            break;
                        end
                    end
                end
            end
            % 处理没有合并的井
            if flag_wucaozuo && count_jing(idx) && ~revisit_flag(idx)
                lianjie_flag(index==idx) = count_pingtai;
                count_pingtai = count_pingtai+1;
                pingtaizuobiao_xin = pingtai_zuobiao_idx(idx, :);
                pingtaizuobiao_ceng = [pingtaizuobiao_ceng; pingtaizuobiao_xin];
            end
        end
        % 处理最后一口井
        if isempty(idx) && pingtaishu_pai==1
            lianjie_flag(index==1) = count_pingtai;
            count_pingtai = count_pingtai+1;
            pingtaizuobiao_xin = pingtai_zuobiao_idx(1, :);
            pingtaizuobiao_ceng = [pingtaizuobiao_ceng; pingtaizuobiao_xin];
        elseif flag_wucaozuo && count_jing(idx + 1) && ~revisit_flag(idx + 1)
            lianjie_flag(index==idx+1) = count_pingtai;
            count_pingtai = count_pingtai+1;
            pingtaizuobiao_xin = pingtai_zuobiao_idx(idx + 1, :);
            pingtaizuobiao_ceng = [pingtaizuobiao_ceng; pingtaizuobiao_xin];
        end
        pingtaizuobiao_ceng = double(pingtaizuobiao_ceng);
        [pingtaishu, temp] = size(pingtaizuobiao_ceng);
        chengben_pingtai_after = 0;
        if jdx ==1
            for idx=1:pingtaishu
                jingzuobiao_pingtai = jing_zuobiao_idx(lianjie_flag==idx, :);
                jingchang_doudong = zuiyou_jingchang_idx(lianjie_flag==idx); 
%                 rectangle('position',[pingtaizuobiao_ceng(idx, 1)-50, pingtaizuobiao_ceng(idx, 2), 100, 100], 'FaceColor',[1 0 0]);
                chengben_pingtai_after(idx) = qukuai_zuanjing(jingzuobiao_pingtai, jingchang_doudong, pingtaizuobiao_ceng(idx, :));
            end   
        else
            for idx=1:pingtaishu
                jingzuobiao_pingtai = jing_zuobiao_idx(lianjie_flag==idx + max(lianjie_flagzong), :);
                jingchang_doudong = zuiyou_jingchang_idx(lianjie_flag==idx + max(lianjie_flagzong)); 
%                 rectangle('position',[pingtaizuobiao_ceng(idx, 1)-50, pingtaizuobiao_ceng(idx, 2), 100, 100], 'FaceColor',[1 0 0]);
                chengben_pingtai_after(idx) = qukuai_zuanjing(jingzuobiao_pingtai, jingchang_doudong, pingtaizuobiao_ceng(idx, :));
            end  
        end
        if sum(chengben_pingtai_after) < chengben_minceng
            chengben_minceng = sum(chengben_pingtai_after);
            lianjie_flag_temp = lianjie_flag;
            pingtaizuobiao_ceng_temp = pingtaizuobiao_ceng;
            jingzuobiao_temp = jing_zuobiao_idx;
            flag_topdown = repmat(weizhi, 1, jingshu_pai);
            flag_ceng = repmat(jdx, 1, jingshu_pai);
            pingtai_ceng = repmat(jdx, 1, pingtaishu);
        end
        %%%%%%%%%%%%%%%%%%%%回复原始数据
        if weizhi ==2
            x_por = -x_por;
            y_por = -y_por;
            x_sg = -x_sg;
            y_sg = -y_sg;
            x_za = -x_za;
            y_za = -y_za;
            x_dengzhixian = -x_dengzhixian;
            y_dengzhixian = -y_dengzhixian;
        end

    end
    if tiaoguo_flag
        tiaoguo_flag = 0;
        x_por = -x_por;
        y_por = -y_por;
        x_sg = -x_sg;
        y_sg = -y_sg;
        x_za = -x_za;
        y_za = -y_za;
        x_dengzhixian = -x_dengzhixian;
        y_dengzhixian = -y_dengzhixian;
    end
    if chengben_minceng >= 10e10
        wufabujing(jdx) = 1;
        lianjie_flagzong = repmat([1], 1, jingshu_pai);
        continue;
    else
       wufabujing(jdx) = 0;

    end
    chengben_wudianfa = [chengben_wudianfa, chengben_minceng];
    zuiyou_jingchang_reshape = [zuiyou_jingchang_reshape, zuiyou_jingchang_idx];
    lianjie_flagzong = [lianjie_flagzong, lianjie_flag_temp];
    pingtaizuobiao_xiaohui = [pingtaizuobiao_xiaohui; pingtaizuobiao_ceng_temp];
    jing_zuobiao_reshape = [jing_zuobiao_reshape; jingzuobiao_temp];
    flag_topdown_zong = [flag_topdown_zong, flag_topdown];
    flag_ceng_zong = [flag_ceng_zong, flag_ceng];
    pingtai_ceng_zong = [pingtai_ceng_zong, pingtai_ceng];
end
strcat('chengben of after wudianfa is ---', num2str(sum(chengben_wudianfa)))

lianjie_flagzong_temp = lianjie_flagzong;
pingtaizuobiao_xiaohui_temp = pingtaizuobiao_xiaohui;
jing_zuobiao_reshape_temp = jing_zuobiao_reshape;
zuiyou_jingchang_reshape_temp = zuiyou_jingchang_reshape;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%开始漂移
zongchengben = [];
zonglirun = [];
lianjie_flagzong = [];
pingtai_zong = [];
jingzuobiao_zong = [];
jingchang_zong = [];
pingtai_ceng_temp = [];
for ceng=1:max(flag_ceng_zong)
    if wufabujing(ceng)
        zongchengben = 10e10;
        continue;
    end
    jing_zuobiao_reshape = jing_zuobiao_reshape_temp(flag_ceng_zong==ceng, :);
    pingtai_zuobiao = pingtaizuobiao_xiaohui_temp(pingtai_ceng_zong==ceng, :);
    zuiyou_jingchang_reshape = zuiyou_jingchang_reshape_temp(flag_ceng_zong==ceng);
    jing_zuobiao = jing_zuobiao_reshape;
    
    topdown = max(flag_topdown_zong(flag_ceng_zong==ceng));
    [jingshu, temp] = size(jing_zuobiao);
    [pingtaishu, temp] = size(pingtai_zuobiao);
    if topdown == 2
        x_por = -x_por;
        y_por = -y_por;
        x_sg = -x_sg;
        y_sg = -y_sg;
        x_za = -x_za;
        y_za = -y_za;
        x_dengzhixian = -x_dengzhixian;
        y_dengzhixian = -y_dengzhixian;
    end    
    
    for qdx=1:3 % 迭代次数
%         figure()
%         hold on;
        
        for idx=1:jingshu
%             plot_danjing(jing_zuobiao_reshape(idx, 1) - zuiyou_banchang(idx), jing_zuobiao_reshape(idx, 2), zuiyou_banchang(idx), zuiyou_jingchang_reshape(idx))
%             rectangle('position',[jing_zuobiao_reshape(idx, 1)-zuiyou_banchang(idx), jing_zuobiao_reshape(idx, 2), zuiyou_banchang(idx)*2, zuiyou_jingchang_reshape(idx)], 'EdgeColor','r');
%             text(jing_zuobiao_reshape(idx, 1)-zuiyou_banchang(idx), jing_zuobiao_reshape(idx, 2)+zuiyou_jingchang_reshape(idx)/2, num2str(round(zuiyou_jingchang_reshape(idx))))
        end
        for idx=1:pingtaishu
%             rectangle('position',[double(pingtai_zuobiao(idx, 1))-50, double(pingtai_zuobiao(idx, 2)), 100, 100], 'FaceColor',[0 1 0]);
        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % 计算每口井与平台的距离，并将井与最近的平台连起来
        count_update = 1;
        while (count_update<10)
            count_update = count_update + 1;
            dis = zeros(jingshu, pingtaishu);
            for idx=1:jingshu
                for kdx=1:pingtaishu
                    if panduan(jing_zuobiao(idx, :), pingtai_zuobiao(kdx, :)) && qukuai_zuanjing(jing_zuobiao(idx, :), zuiyou_jingchang_reshape(idx), pingtai_zuobiao(kdx, :))< 1e10
                        dis(idx, kdx) = compute_distance(jing_zuobiao(idx, :), pingtai_zuobiao(kdx, :));
                    else
                        dis(idx, kdx) = 10000000;
                    end
                end
            end

            % 提取平台与哪个井相连,并进行连接
            [vals,index] = min(dis, [], 2);
            if sum(vals >= 10000000)
                jing_zuobiao_yichang = jing_zuobiao(vals >= 10000000, :);
                jing_zuobiao_yichang(:, 2) = jing_zuobiao_yichang(:, 2) - 344;
                pingtai_zuobiao = [pingtai_zuobiao; jing_zuobiao_yichang];
                pingtaishu = length(pingtai_zuobiao);
            else
                break;
            end
        end
        count_jing = zeros(1, pingtaishu);
        lianjie_flag = zeros(1, jingshu);% 标记一下哪个井连的是哪个平台
        for idx=1:jingshu
            count_jing(index(idx)) = 1; % 记录哪个平台被连接了
            lianjie_flag(idx) = index(idx);
%             hold on;
%             plot([jing_zuobiao(idx, 1), pingtai_zuobiao(index(idx), 1)], [jing_zuobiao(idx, 2), pingtai_zuobiao(index(idx), 2)]);
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % 准备合并
        chengben_pingtai = zeros(1, pingtaishu);
        for idx=1:pingtaishu % 准备计算每个平台的成本
            if length(jing_zuobiao(index==idx, :)) ~= 0
                jingzuobiao_pingtai_hebing = jing_zuobiao(index==idx, :); % 获取与idx平台连接的井
                pingtaizuobiao_hebing = pingtai_zuobiao(idx, :);
                jingchang_hebing = zuiyou_jingchang_reshape(index==idx);
                chengben_pingtai(idx) = qukuai_zuanjing(jingzuobiao_pingtai_hebing, jingchang_hebing, pingtaizuobiao_hebing);
%                 text(pingtaizuobiao_hebing(1), pingtaizuobiao_hebing(2), num2str(round(chengben_pingtai(idx) / 1e6)))
            end
        end
        revisit_flag = zeros(1, pingtaishu); % 标记一下某个平台是否被合并了
        pingtaizuobiao_xiaohui = []; % 保存合并后井的坐标
        count_pingtai = 1;
        if pingtaishu > 1
            for idx=1:pingtaishu-1
                flag_wucaozuo = 1;
                if ~revisit_flag(idx) && count_jing(idx) % 判断该idx平台否被合并过，以及是否有井相连
                    pingtaizuobiao_idx = pingtai_zuobiao(idx, :);
                    pingtaichengben_idx = chengben_pingtai(idx);
                    jingzuobiao_pingtai_idx = jing_zuobiao(index==idx, :);
                    jingchang_idx = zuiyou_jingchang_reshape(index==idx);
                    for kdx=idx+1:pingtaishu
                        if ~revisit_flag(kdx) && count_jing(kdx)% 判断该kdx平台否被合并过，以及是否有井相连
                            pingtaizuobiao_kdx = pingtai_zuobiao(kdx, :);
                            pingtaichengben_kdx = chengben_pingtai(kdx);
                            jingzuobiao_pingtai_kdx = jing_zuobiao(index==kdx, :);
                            jingchang_kdx = zuiyou_jingchang_reshape(index==kdx);

                            %判断两个平台是否满足要求,满足要求进行合并
                            chengben_twopingtai = pingtaichengben_idx + pingtaichengben_kdx;
                            pingtaizuobiao_xin(1) = (pingtaizuobiao_idx(1) + pingtaizuobiao_kdx(1)) / 2;
                            pingtaizuobiao_xin(2) = min(pingtaizuobiao_idx(2), pingtaizuobiao_kdx(2))-100;
                            jingzuobiao_xin = [jingzuobiao_pingtai_idx; jingzuobiao_pingtai_kdx];
                            jingchang_xin = [jingchang_idx, jingchang_kdx];
                            chengben_onepingtai = qukuai_zuanjing(jingzuobiao_xin, jingchang_xin, pingtaizuobiao_xin);
                            if chengben_onepingtai < chengben_twopingtai &&  panduan(jingzuobiao_xin, pingtaizuobiao_xin)% 满足成本降低的要求，进行合并,得到新的平台阻坐标
                                flag_wucaozuo = 0;
                                hebingkuang(1) = min(pingtaizuobiao_idx(1), pingtaizuobiao_kdx(1));
                                hebingkuang(2) = min(pingtaizuobiao_idx(2), pingtaizuobiao_kdx(2));
                                kuandu = abs(pingtaizuobiao_idx(1) - pingtaizuobiao_kdx(1));
                                gaodu = abs(pingtaizuobiao_idx(2) - pingtaizuobiao_kdx(2));
        %                             chengben_onepingtai
        %                             chengben_twopingtai
%                                 rectangle('position',[hebingkuang(1)-100, hebingkuang(2)-50, kuandu+200, gaodu+200], 'EdgeColor','b');
                                revisit_flag(idx) = 1;
                                revisit_flag(kdx) = 1;
                                lianjie_flag(index==idx) = count_pingtai;
                                lianjie_flag(index==kdx) = count_pingtai;
                                count_pingtai = count_pingtai+1;
                                pingtaizuobiao_xiaohui = [pingtaizuobiao_xiaohui; pingtaizuobiao_xin];
                                break;
                            end
                        end
                    end
                end
                if flag_wucaozuo && count_jing(idx) && ~revisit_flag(idx)
                    lianjie_flag(index==idx) = count_pingtai;
                    count_pingtai = count_pingtai+1;
                    pingtaizuobiao_xin = pingtai_zuobiao(idx, :);
                    pingtaizuobiao_xiaohui = [pingtaizuobiao_xiaohui; pingtaizuobiao_xin];
                end
            end
            if isempty(count_jing) || isempty(revisit_flag)
                disp('haha')
            end
            if flag_wucaozuo && count_jing(idx + 1) && ~revisit_flag(idx + 1)
                lianjie_flag(index==idx+1) = count_pingtai;
                count_pingtai = count_pingtai+1;
                pingtaizuobiao_xin = pingtai_zuobiao(idx + 1, :);
                pingtaizuobiao_xiaohui = [pingtaizuobiao_xiaohui; pingtaizuobiao_xin];
            end
        end


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % 更新平台坐标，然后删除没有连接的井
        if sum(revisit_flag) ~= 0
            pingtai_zuobiao = double(pingtaizuobiao_xiaohui);
        end
        [pingtaishu, temp] = size(pingtai_zuobiao);
        chengben_pingtai_after = 0;
        for idx=1:pingtaishu
            jingzuobiao_pingtai = jing_zuobiao(lianjie_flag==idx, :);
            jingchang_doudong = zuiyou_jingchang_reshape(lianjie_flag==idx); 
            pingtai_zuobiao(idx, :) = update_pingtai_function(jingzuobiao_pingtai, pingtai_zuobiao(idx, :));
%             rectangle('position',[pingtai_zuobiao(idx, 1)-50, pingtai_zuobiao(idx, 2), 100, 100], 'FaceColor',[1 0 0]);
            chengben_pingtai_after(idx) = qukuai_zuanjing(jingzuobiao_pingtai, jingchang_doudong, pingtai_zuobiao(idx, :));
        end   
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%计算利润
    PERM_mean = 0.00003;
    result_npv = 0;
    for zdx=1:jingshu
        POR_mean = compute_meanvalue(jing_zuobiao(zdx, 1), jing_zuobiao(zdx, 2), x_por, y_por, zuiyou_banchang(zdx), zuiyou_jingchang_reshape(zdx), value_por);
        SG_mean = compute_meanvalue(jing_zuobiao(zdx, 1), jing_zuobiao(zdx, 2), x_sg, y_sg, zuiyou_banchang(zdx), zuiyou_jingchang_reshape(zdx), value_sg);

        result_npv(zdx) = NPV0719([POR_mean, PERM_mean, SG_mean, zuiyou_banchang(zdx), zuiyou_jianju(1), zuiyou_jingchang_reshape(zdx), zuiyou_daoliu(1)], [jing_zuobiao(zdx, 1), jing_zuobiao(zdx, 2)], zuiyou_jingchang_reshape(zdx), pingtai_zuobiao(lianjie_flag(zdx), :));
    end
    result_all = sum(result_npv);
    zonglirun = [zonglirun, result_all];
    if topdown == 2
        x_por = -x_por;
        y_por = -y_por;
        x_sg = -x_sg;
        y_sg = -y_sg;
        x_za = -x_za;
        y_za = -y_za;
        x_dengzhixian = -x_dengzhixian;
        y_dengzhixian = -y_dengzhixian;
        pingtai_zuobiao = -pingtai_zuobiao;
        jing_zuobiao_reshape = -jing_zuobiao;
    end
    zongchengben = [zongchengben, sum(chengben_pingtai_after)];
    if ceng > 1
        lianjie_flag = max(lianjie_flagzong) + lianjie_flag;
    end
    lianjie_flagzong = [lianjie_flagzong, lianjie_flag];
    pingtai_zong = [pingtai_zong; pingtai_zuobiao];
    jingzuobiao_zong = [jingzuobiao_zong; jing_zuobiao_reshape];
    jingchang_zong = [jingchang_zong, zuiyou_jingchang_reshape];
    pingtai_ceng_temp = [pingtai_ceng_temp, repmat(ceng, 1, pingtaishu)];
end
zongchengben = sum(zongchengben);
maolirun = sum(zonglirun);
zhenlirun = maolirun - zongchengben;
strcat('chengben of after piaoyi is ---', num2str(sum(zongchengben)))
strcat('zonglirun of after piaoyi is ---', num2str(sum(maolirun)))
strcat('zhenlirun of after piaoyi is ---', num2str(sum(zhenlirun)))

indexes = get_guaitai(lianjie_flagzong);
[zuiyou_jingchang, jing_zuobiao] = process_jing(jingchang_zong, jingzuobiao_zong, indexes);
zuiyou_xzuobiao = jing_zuobiao(:, 1)' - zuiyou_banchang(1);
zuiyou_yzuobiao = jing_zuobiao(:, 2)';

if ~isempty(indexes)
    start_jing = min(x_base) + 50;
    end_jing = max(x_base);
    anchor = start_jing;
    jingshu = length(zuiyou_jingchang);

    jing_zuobiao = [zuiyou_xzuobiao'+zuiyou_banchang', zuiyou_yzuobiao'];
    archorx_zuobiao = [];
    archory_zuobiao = [];
    for idx=1:jingshu
        archorx_zuobiao(idx) = zuiyou_xzuobiao(idx) + zuiyou_banchang(idx);
        archory_zuobiao(idx) = zuiyou_yzuobiao(idx) - 344;
    end
    pingtai_zuobiao = [archorx_zuobiao', archory_zuobiao'];
    [pingtaishu, temp] = size(pingtai_zuobiao);
    for i=1:jingshu
        chengben_zuanjing(i) = qukuai_zuanjing([zuiyou_xzuobiao(i) + zuiyou_banchang(i), zuiyou_yzuobiao(i)], zuiyou_jingchang(i), [zuiyou_xzuobiao(i) + zuiyou_banchang(i), zuiyou_yzuobiao(i)-500]);
    end
    strcat('chengben of before optimizaiton is ---', num2str(sum(chengben_zuanjing)))

%     figure()
%     plot(x_base, y_base);
%     hold on;
    previous_symbol = 0;
    cengshu = 0;
    for idx=1:jingshu
%         plot_danjing(zuiyou_xzuobiao(idx), zuiyou_yzuobiao(idx), zuiyou_banchang(idx), zuiyou_jingchang(idx), zuiyou_jianju(1), zuiyou_daoliu(1))
        center = [jing_zuobiao(idx, 1), jing_zuobiao(idx, 2)];
%         filledCircle(center, 344, 1000, 'b');
    end
    for idx=1:pingtaishu
%         rectangle('position',[pingtai_zuobiao(idx, 1)-50, pingtai_zuobiao(idx, 2), 100, 100], 'FaceColor',[0 1 0]);
    end
    %计算层数
    for idx=1:jingshu
        if zuiyou_xzuobiao(idx) ~= previous_symbol
            previous_symbol = zuiyou_xzuobiao(idx);
            cengshu(idx) = 1;
        else
            cengshu(idx) = cengshu(idx-1) + 1;
        end
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    pingtaizuobiao_xiaohui = []; % 保存合并后平台的坐标
    lianjie_flagzong = [];
    jing_zuobiao_reshape = [];
    zuiyou_jingchang_reshape = [];
    cengshu_reshape = [];
    flag_topdown_zong = [];
    flag_ceng_zong = [];
    pingtai_ceng_zong = [];
    wufabujing = 0;
    chengben_wudianfa = [];
    for jdx=1:max(cengshu) % 逐排的进行计算
        jing_zuobiao_idx = jing_zuobiao(cengshu==jdx, :);
        zuiyou_banchang_idx = zuiyou_banchang(cengshu==jdx);
        zuiyou_jingchang_idx = zuiyou_jingchang(cengshu==jdx);
        [pingtaishu_pai, temp] = size(jing_zuobiao_idx);
        [jingshu_pai, temp] = size(jing_zuobiao_idx);
        chengben_minceng = 10e10;
        wudianfa_chengben = [];
        flag_topdown = [];
        flag_ceng = [];
        pingtai_ceng = [];
        tiaoguo_flag = 0;
        for weizhi=1:2
            pingtai_zuobiao_idx = [];
            pingtaizuobiao_ceng = [];
            count_pingtai = 1;
            if jdx > 1
                count_pingtai = max(lianjie_flagzong) + 1;
            end
            if weizhi == 1
                za_bottom = get_maishen(jing_zuobiao_idx);
    %             if sum(inpolygon(jing_zuobiao_idx(:, 1),jing_zuobiao_idx(:, 2),x_kuangqu1,y_kuangqu1)) ~=0
    %                 continue;
    %             elseif sum(inpolygon(jing_zuobiao_idx(:, 1),jing_zuobiao_idx(:, 2),x_kuangqu2,y_kuangqu2)) ~=0
    %                 continue;
    %             elseif sum(inpolygon(jing_zuobiao_idx(:, 1),jing_zuobiao_idx(:, 2),x_kuangqu3,y_kuangqu3)) ~=0
    %                 continue;
    %             elseif sum(inpolygon(jing_zuobiao_idx(:, 1),jing_zuobiao_idx(:, 2),x_kuangqu4,y_kuangqu4)) ~=0
    %                 continue;
    %             elseif sum(inpolygon(jing_zuobiao_idx(:, 1),jing_zuobiao_idx(:, 2),x_kuangqu5,y_kuangqu5)) ~=0
    %                 continue;
    %             elseif sum(inpolygon(jing_zuobiao_idx(:, 1),jing_zuobiao_idx(:, 2),x_kuangqu6,y_kuangqu6)) ~=0
    %                 continue;
    %             end
                pingtai_zuobiao_idx(:, 1) = jing_zuobiao_idx(:, 1);
                pingtai_zuobiao_idx(:, 2) = jing_zuobiao_idx(:, 2)-344;
            elseif weizhi == 2
                continue;
                x_por = -x_por;
                y_por = -y_por;
                x_sg = -x_sg;
                y_sg = -y_sg;
                x_za = -x_za;
                y_za = -y_za;
                x_dengzhixian = -x_dengzhixian;
                y_dengzhixian = -y_dengzhixian;
                jing_zuobiao_idx(:, 2) = jing_zuobiao_idx(:, 2) + zuiyou_jingchang_idx';
    %             if sum(inpolygon(jing_zuobiao_idx(:, 1),jing_zuobiao_idx(:, 2),x_kuangqu1,y_kuangqu1)) ~=0
    %                 tiaoguo_flag = 1;
    %                 continue;
    %             elseif sum(inpolygon(jing_zuobiao_idx(:, 1),jing_zuobiao_idx(:, 2),x_kuangqu2,y_kuangqu2)) ~=0
    %                 tiaoguo_flag = 1;
    %                 continue;
    %             elseif sum(inpolygon(jing_zuobiao_idx(:, 1),jing_zuobiao_idx(:, 2),x_kuangqu3,y_kuangqu3)) ~=0
    %                 tiaoguo_flag = 1;
    %                 continue;
    %             elseif sum(inpolygon(jing_zuobiao_idx(:, 1),jing_zuobiao_idx(:, 2),x_kuangqu4,y_kuangqu4)) ~=0
    %                 tiaoguo_flag = 1;
    %                 continue;
    %             elseif sum(inpolygon(jing_zuobiao_idx(:, 1),jing_zuobiao_idx(:, 2),x_kuangqu5,y_kuangqu5)) ~=0
    %                 tiaoguo_flag = 1;
    %                 continue;
    %             elseif sum(inpolygon(jing_zuobiao_idx(:, 1),jing_zuobiao_idx(:, 2),x_kuangqu6,y_kuangqu6)) ~=0
    %                 tiaoguo_flag = 1;
    %                 continue;
    %             end
                % 上面满足要求，180度旋转坐标和地理参数
                jing_zuobiao_idx = -jing_zuobiao_idx;
                za_top = get_maishen(jing_zuobiao_idx);
    %             zuiyou_jingchang_idx = zuiyou_jingchang_idx - (za_top - za_bottom);
    %             jing_zuobiao_idx(:, 2) = jing_zuobiao_idx(:, 2) + (za_top - za_bottom)';
                pingtai_zuobiao_idx(:, 1) = jing_zuobiao_idx(:, 1);
                pingtai_zuobiao_idx(:, 2) = jing_zuobiao_idx(:, 2)-344;
            end
            % 开始准备漂移，首先是计算连接情况
%             figure()
    %         plot_duojing(jing_zuobiao_idx, zuiyou_banchang_idx, zuiyou_jingchang_idx, 'r')
            [jingshu, temp] = size(jing_zuobiao_idx);
            for idx=1:jingshu
%                 rectangle('position',[jing_zuobiao_idx(idx, 1)-zuiyou_banchang_idx(idx), jing_zuobiao_idx(idx, 2), zuiyou_banchang_idx(idx)*2, zuiyou_jingchang_idx(idx)], 'EdgeColor','r');
%                 text(jing_zuobiao_idx(idx, 1)-zuiyou_banchang_idx(idx), jing_zuobiao_idx(idx, 2)+zuiyou_jingchang_idx(idx)/2, num2str(round(zuiyou_jingchang_idx(idx))))
            end
            dis = zeros(jingshu_pai, pingtaishu_pai);
            for idx=1:jingshu_pai
                for kdx=1:pingtaishu_pai
                    if panduan(jing_zuobiao_idx(idx, :), pingtai_zuobiao_idx(kdx, :)) && qukuai_zuanjing(jing_zuobiao_idx(idx, :), zuiyou_jingchang_idx(idx), pingtai_zuobiao_idx(kdx, :))< 1e10
                        dis(idx, kdx) = compute_distance(jing_zuobiao_idx(idx, :), pingtai_zuobiao_idx(kdx, :));
                    else
                        dis(idx, kdx) = 10000000;
                    end
                end
            end
            % 提取平台与哪个井相连,并进行连接
            [vals,index] = min(dis, [], 2);
            count_jing = zeros(1, pingtaishu_pai);
            for idx=1:jingshu_pai
                count_jing(index(idx)) = 1; % 记录哪个平台被连接了
            end

            chengben_pingtai = zeros(1, pingtaishu_pai);
            for idx=1:pingtaishu_pai % 准备计算每个平台的成本
                if length(jing_zuobiao_idx(index==idx, :)) ~= 0
                    jingzuobiao_pingtai_hebing = jing_zuobiao_idx(index==idx, :); % 获取与idx平台连接的井
                    pingtaizuobiao_hebing = pingtai_zuobiao_idx(idx, :);
                    jingchang_hebing = zuiyou_jingchang_idx(index==idx);
                    chengben_pingtai(idx) = qukuai_zuanjing(jingzuobiao_pingtai_hebing, jingchang_hebing, pingtaizuobiao_hebing);
                end
            end
            revisit_flag = zeros(1, pingtaishu_pai); % 标记一下某个平台是否被合并了
            lianjie_flag = zeros(1, jingshu_pai);% 标记一下哪个井连的是哪个平台
            for idx=1:pingtaishu_pai-1
                flag_wucaozuo = 1;
                if ~revisit_flag(idx) && count_jing(idx) % 判断该idx平台否被合并过，以及是否有井相连
                    pingtaizuobiao_idx = pingtai_zuobiao_idx(idx, :);
                    pingtaichengben_idx = chengben_pingtai(idx);
                    jingzuobiao_pingtai_idx = jing_zuobiao_idx(index==idx, :);
                    jingchang_idx = zuiyou_jingchang_idx(index==idx);
        %             filledCircle([jingzuobiao_pingtai_idx(1), jingzuobiao_pingtai_idx(2)], 344, 1024, 'b');
                    for kdx=idx+1:idx+1
                        if ~revisit_flag(kdx) && count_jing(kdx)% 判断该kdx平台否被合并过，以及是否有井相连
                            pingtaizuobiao_kdx = pingtai_zuobiao_idx(kdx, :);
                            pingtaichengben_kdx = chengben_pingtai(kdx);
                            jingzuobiao_pingtai_kdx = jing_zuobiao_idx(index==kdx, :);
                            jingchang_kdx = zuiyou_jingchang_idx(index==kdx);
        %                     filledCircle([jingzuobiao_pingtai_kdx(1), jingzuobiao_pingtai_kdx(2)], 344, 1024, 'b');
                            % 判断两个平台是否满足要求,满足要求进行合并
                            chengben_twopingtai = pingtaichengben_idx + pingtaichengben_kdx;
                            jingzuobiao_xin = [jingzuobiao_pingtai_idx; jingzuobiao_pingtai_kdx];
                            pingtaizuobiao_xin = oushu_mogu(jingzuobiao_xin, zuiyou_banchang_idx(1));
                            if length(pingtaizuobiao_xin) ==0
                                continue;
                            end
                            jingchang_xin = [jingchang_idx, jingchang_kdx];
                            % 逐个的计算新平台坐标的成本，留下成本最低的那个
                            [xinpingtaishu, temp] = size(pingtaizuobiao_xin);
                            chengben_onepingtais = 0;
                            for qdx=1:xinpingtaishu
                                chengben_onepingtais(qdx) = qukuai_zuanjing(jingzuobiao_xin, jingchang_xin, pingtaizuobiao_xin(qdx, :));
                            end
                            [chengben_onepingtai, index_value] = min(chengben_onepingtais);
                            pingtaizuobiao_xin = pingtaizuobiao_xin(index_value, :);
    %                         filledCircle([pingtaizuobiao_xin(1), pingtaizuobiao_xin(2)], 16, 1024, 'r');
                            if chengben_onepingtai < chengben_twopingtai &&  panduan(jingzuobiao_xin, pingtaizuobiao_xin)% 满足成本降低的要求，进行合并,得到新的平台阻坐标
                                flag_wucaozuo = 0;
                                revisit_flag(idx) = 1;
                                revisit_flag(kdx) = 1;
                                lianjie_flag(index==idx) = count_pingtai;
                                lianjie_flag(index==kdx) = count_pingtai;
                                count_pingtai = count_pingtai+1;
                                pingtaizuobiao_ceng = [pingtaizuobiao_ceng; pingtaizuobiao_xin];
                                break;
                            end
                        end
                    end
                end
                % 处理没有合并的井
                if flag_wucaozuo && count_jing(idx) && ~revisit_flag(idx)
                    lianjie_flag(index==idx) = count_pingtai;
                    count_pingtai = count_pingtai+1;
                    pingtaizuobiao_xin = pingtai_zuobiao_idx(idx, :);
                    pingtaizuobiao_ceng = [pingtaizuobiao_ceng; pingtaizuobiao_xin];
                end
            end
            % 处理最后一口井
            if isempty(idx) && pingtaishu_pai==1
                lianjie_flag(index==1) = count_pingtai;
                count_pingtai = count_pingtai+1;
                pingtaizuobiao_xin = pingtai_zuobiao_idx(1, :);
                pingtaizuobiao_ceng = [pingtaizuobiao_ceng; pingtaizuobiao_xin];
            elseif flag_wucaozuo && count_jing(idx + 1) && ~revisit_flag(idx + 1)
                lianjie_flag(index==idx+1) = count_pingtai;
                count_pingtai = count_pingtai+1;
                pingtaizuobiao_xin = pingtai_zuobiao_idx(idx + 1, :);
                pingtaizuobiao_ceng = [pingtaizuobiao_ceng; pingtaizuobiao_xin];
            end
            pingtaizuobiao_ceng = double(pingtaizuobiao_ceng);
            [pingtaishu, temp] = size(pingtaizuobiao_ceng);
            chengben_pingtai_after = 0;
            if jdx ==1
                for idx=1:pingtaishu
                    jingzuobiao_pingtai = jing_zuobiao_idx(lianjie_flag==idx, :);
                    jingchang_doudong = zuiyou_jingchang_idx(lianjie_flag==idx); 
%                     rectangle('position',[pingtaizuobiao_ceng(idx, 1)-50, pingtaizuobiao_ceng(idx, 2), 100, 100], 'FaceColor',[1 0 0]);
                    chengben_pingtai_after(idx) = qukuai_zuanjing(jingzuobiao_pingtai, jingchang_doudong, pingtaizuobiao_ceng(idx, :));
                end   
            else
                for idx=1:pingtaishu
                    jingzuobiao_pingtai = jing_zuobiao_idx(lianjie_flag==idx + max(lianjie_flagzong), :);
                    jingchang_doudong = zuiyou_jingchang_idx(lianjie_flag==idx + max(lianjie_flagzong)); 
%                     rectangle('position',[pingtaizuobiao_ceng(idx, 1)-50, pingtaizuobiao_ceng(idx, 2), 100, 100], 'FaceColor',[1 0 0]);
                    chengben_pingtai_after(idx) = qukuai_zuanjing(jingzuobiao_pingtai, jingchang_doudong, pingtaizuobiao_ceng(idx, :));
                end  
            end
            if sum(chengben_pingtai_after) < chengben_minceng
                chengben_minceng = sum(chengben_pingtai_after);
                lianjie_flag_temp = lianjie_flag;
                pingtaizuobiao_ceng_temp = pingtaizuobiao_ceng;
                jingzuobiao_temp = jing_zuobiao_idx;
                flag_topdown = repmat(weizhi, 1, jingshu_pai);
                flag_ceng = repmat(jdx, 1, jingshu_pai);
                pingtai_ceng = repmat(jdx, 1, pingtaishu);
            end
            %%%%%%%%%%%%%%%%%%%%回复原始数据
            if weizhi ==2
                x_por = -x_por;
                y_por = -y_por;
                x_sg = -x_sg;
                y_sg = -y_sg;
                x_za = -x_za;
                y_za = -y_za;
                x_dengzhixian = -x_dengzhixian;
                y_dengzhixian = -y_dengzhixian;
            end

        end
        if tiaoguo_flag
            tiaoguo_flag = 0;
            x_por = -x_por;
            y_por = -y_por;
            x_sg = -x_sg;
            y_sg = -y_sg;
            x_za = -x_za;
            y_za = -y_za;
            x_dengzhixian = -x_dengzhixian;
            y_dengzhixian = -y_dengzhixian;
        end
        if chengben_minceng >= 10e10
            wufabujing(jdx) = 1;
            lianjie_flagzong = repmat([1], 1, jingshu_pai);
            continue;
        else
           wufabujing(jdx) = 0;

        end
        chengben_wudianfa = [chengben_wudianfa, chengben_minceng];
        zuiyou_jingchang_reshape = [zuiyou_jingchang_reshape, zuiyou_jingchang_idx];
        lianjie_flagzong = [lianjie_flagzong, lianjie_flag_temp];
        pingtaizuobiao_xiaohui = [pingtaizuobiao_xiaohui; pingtaizuobiao_ceng_temp];
        jing_zuobiao_reshape = [jing_zuobiao_reshape; jingzuobiao_temp];
        flag_topdown_zong = [flag_topdown_zong, flag_topdown];
        flag_ceng_zong = [flag_ceng_zong, flag_ceng];
        pingtai_ceng_zong = [pingtai_ceng_zong, pingtai_ceng];
    end
    strcat('chengben of after wudianfa is ---', num2str(sum(chengben_wudianfa)))

    lianjie_flagzong_temp = lianjie_flagzong;
    pingtaizuobiao_xiaohui_temp = pingtaizuobiao_xiaohui;
    jing_zuobiao_reshape_temp = jing_zuobiao_reshape;
    zuiyou_jingchang_reshape_temp = zuiyou_jingchang_reshape;


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%开始漂移
    zongchengben = [];
    zonglirun = [];
    lianjie_flagzong = [];
    pingtai_zong = [];
    jingzuobiao_zong = [];
    jingchang_zong = [];
    pingtai_ceng_temp = [];
    for ceng=1:max(flag_ceng_zong)
        if wufabujing(ceng)
            zongchengben = 10e10;
            continue;
        end
        jing_zuobiao_reshape = jing_zuobiao_reshape_temp(flag_ceng_zong==ceng, :);
        pingtai_zuobiao = pingtaizuobiao_xiaohui_temp(pingtai_ceng_zong==ceng, :);
        zuiyou_jingchang_reshape = zuiyou_jingchang_reshape_temp(flag_ceng_zong==ceng);
        jing_zuobiao = jing_zuobiao_reshape;

        topdown = max(flag_topdown_zong(flag_ceng_zong==ceng));
        [jingshu, temp] = size(jing_zuobiao);
        [pingtaishu, temp] = size(pingtai_zuobiao);
        if topdown == 2
            x_por = -x_por;
            y_por = -y_por;
            x_sg = -x_sg;
            y_sg = -y_sg;
            x_za = -x_za;
            y_za = -y_za;
            x_dengzhixian = -x_dengzhixian;
            y_dengzhixian = -y_dengzhixian;
        end    

        for qdx=1:3 % 迭代次数
%             figure()
%             hold on;

            for idx=1:jingshu
    %             plot_danjing(jing_zuobiao_reshape(idx, 1) - zuiyou_banchang(idx), jing_zuobiao_reshape(idx, 2), zuiyou_banchang(idx), zuiyou_jingchang_reshape(idx))
%                 rectangle('position',[jing_zuobiao_reshape(idx, 1)-zuiyou_banchang(idx), jing_zuobiao_reshape(idx, 2), zuiyou_banchang(idx)*2, zuiyou_jingchang_reshape(idx)], 'EdgeColor','r');
%                 text(jing_zuobiao_reshape(idx, 1)-zuiyou_banchang(idx), jing_zuobiao_reshape(idx, 2)+zuiyou_jingchang_reshape(idx)/2, num2str(round(zuiyou_jingchang_reshape(idx))))
            end
            for idx=1:pingtaishu
%                 rectangle('position',[double(pingtai_zuobiao(idx, 1))-50, double(pingtai_zuobiao(idx, 2)), 100, 100], 'FaceColor',[0 1 0]);
            end

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % 计算每口井与平台的距离，并将井与最近的平台连起来
            count_update = 1;
            while (count_update<10)
                count_update = count_update + 1;
                dis = zeros(jingshu, pingtaishu);
                for idx=1:jingshu
                    for kdx=1:pingtaishu
                        if panduan(jing_zuobiao(idx, :), pingtai_zuobiao(kdx, :)) && qukuai_zuanjing(jing_zuobiao(idx, :), zuiyou_jingchang_reshape(idx), pingtai_zuobiao(kdx, :))< 1e10
                            dis(idx, kdx) = compute_distance(jing_zuobiao(idx, :), pingtai_zuobiao(kdx, :));
                        else
                            dis(idx, kdx) = 10000000;
                        end
                    end
                end

                % 提取平台与哪个井相连,并进行连接
                [vals,index] = min(dis, [], 2);
                if sum(vals >= 10000000)
                    jing_zuobiao_yichang = jing_zuobiao(vals >= 10000000, :);
                    jing_zuobiao_yichang(:, 2) = jing_zuobiao_yichang(:, 2) - 344;
                    pingtai_zuobiao = [pingtai_zuobiao; jing_zuobiao_yichang];
                    pingtaishu = length(pingtai_zuobiao);
                else
                    break;
                end
            end
            count_jing = zeros(1, pingtaishu);
            lianjie_flag = zeros(1, jingshu);% 标记一下哪个井连的是哪个平台
            for idx=1:jingshu
                count_jing(index(idx)) = 1; % 记录哪个平台被连接了
                lianjie_flag(idx) = index(idx);
%                 hold on;
%                 plot([jing_zuobiao(idx, 1), pingtai_zuobiao(index(idx), 1)], [jing_zuobiao(idx, 2), pingtai_zuobiao(index(idx), 2)]);
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % 准备合并
            chengben_pingtai = zeros(1, pingtaishu);
            for idx=1:pingtaishu % 准备计算每个平台的成本
                if length(jing_zuobiao(index==idx, :)) ~= 0
                    jingzuobiao_pingtai_hebing = jing_zuobiao(index==idx, :); % 获取与idx平台连接的井
                    pingtaizuobiao_hebing = pingtai_zuobiao(idx, :);
                    jingchang_hebing = zuiyou_jingchang_reshape(index==idx);
                    chengben_pingtai(idx) = qukuai_zuanjing(jingzuobiao_pingtai_hebing, jingchang_hebing, pingtaizuobiao_hebing);
%                     text(pingtaizuobiao_hebing(1), pingtaizuobiao_hebing(2), num2str(round(chengben_pingtai(idx) / 1e6)))
                end
            end
            revisit_flag = zeros(1, pingtaishu); % 标记一下某个平台是否被合并了
            pingtaizuobiao_xiaohui = []; % 保存合并后井的坐标
            count_pingtai = 1;
            if pingtaishu > 1
                for idx=1:pingtaishu-1
                    flag_wucaozuo = 1;
                    if ~revisit_flag(idx) && count_jing(idx) % 判断该idx平台否被合并过，以及是否有井相连
                        pingtaizuobiao_idx = pingtai_zuobiao(idx, :);
                        pingtaichengben_idx = chengben_pingtai(idx);
                        jingzuobiao_pingtai_idx = jing_zuobiao(index==idx, :);
                        jingchang_idx = zuiyou_jingchang_reshape(index==idx);
                        for kdx=idx+1:pingtaishu
                            if ~revisit_flag(kdx) && count_jing(kdx)% 判断该kdx平台否被合并过，以及是否有井相连
                                pingtaizuobiao_kdx = pingtai_zuobiao(kdx, :);
                                pingtaichengben_kdx = chengben_pingtai(kdx);
                                jingzuobiao_pingtai_kdx = jing_zuobiao(index==kdx, :);
                                jingchang_kdx = zuiyou_jingchang_reshape(index==kdx);

                                %判断两个平台是否满足要求,满足要求进行合并
                                chengben_twopingtai = pingtaichengben_idx + pingtaichengben_kdx;
                                pingtaizuobiao_xin(1) = (pingtaizuobiao_idx(1) + pingtaizuobiao_kdx(1)) / 2;
                                pingtaizuobiao_xin(2) = min(pingtaizuobiao_idx(2), pingtaizuobiao_kdx(2))-100;
                                jingzuobiao_xin = [jingzuobiao_pingtai_idx; jingzuobiao_pingtai_kdx];
                                jingchang_xin = [jingchang_idx, jingchang_kdx];
                                chengben_onepingtai = qukuai_zuanjing(jingzuobiao_xin, jingchang_xin, pingtaizuobiao_xin);
                                if chengben_onepingtai < chengben_twopingtai &&  panduan(jingzuobiao_xin, pingtaizuobiao_xin)% 满足成本降低的要求，进行合并,得到新的平台阻坐标
                                    flag_wucaozuo = 0;
                                    hebingkuang(1) = min(pingtaizuobiao_idx(1), pingtaizuobiao_kdx(1));
                                    hebingkuang(2) = min(pingtaizuobiao_idx(2), pingtaizuobiao_kdx(2));
                                    kuandu = abs(pingtaizuobiao_idx(1) - pingtaizuobiao_kdx(1));
                                    gaodu = abs(pingtaizuobiao_idx(2) - pingtaizuobiao_kdx(2));
            %                             chengben_onepingtai
            %                             chengben_twopingtai
%                                     rectangle('position',[hebingkuang(1)-100, hebingkuang(2)-50, kuandu+200, gaodu+200], 'EdgeColor','b');
                                    revisit_flag(idx) = 1;
                                    revisit_flag(kdx) = 1;
                                    lianjie_flag(index==idx) = count_pingtai;
                                    lianjie_flag(index==kdx) = count_pingtai;
                                    count_pingtai = count_pingtai+1;
                                    pingtaizuobiao_xiaohui = [pingtaizuobiao_xiaohui; pingtaizuobiao_xin];
                                    break;
                                end
                            end
                        end
                    end
                    if flag_wucaozuo && count_jing(idx) && ~revisit_flag(idx)
                        lianjie_flag(index==idx) = count_pingtai;
                        count_pingtai = count_pingtai+1;
                        pingtaizuobiao_xin = pingtai_zuobiao(idx, :);
                        pingtaizuobiao_xiaohui = [pingtaizuobiao_xiaohui; pingtaizuobiao_xin];
                    end
                end
                if isempty(count_jing) || isempty(revisit_flag)
                    disp('haha')
                end
                if flag_wucaozuo && count_jing(idx + 1) && ~revisit_flag(idx + 1)
                    lianjie_flag(index==idx+1) = count_pingtai;
                    count_pingtai = count_pingtai+1;
                    pingtaizuobiao_xin = pingtai_zuobiao(idx + 1, :);
                    pingtaizuobiao_xiaohui = [pingtaizuobiao_xiaohui; pingtaizuobiao_xin];
                end
            end


            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % 更新平台坐标，然后删除没有连接的井
            if sum(revisit_flag) ~= 0
                pingtai_zuobiao = double(pingtaizuobiao_xiaohui);
            end
            [pingtaishu, temp] = size(pingtai_zuobiao);
            chengben_pingtai_after = 0;
            for idx=1:pingtaishu
                jingzuobiao_pingtai = jing_zuobiao(lianjie_flag==idx, :);
                jingchang_doudong = zuiyou_jingchang_reshape(lianjie_flag==idx); 
                pingtai_zuobiao(idx, :) = update_pingtai_function(jingzuobiao_pingtai, pingtai_zuobiao(idx, :));
%                 rectangle('position',[pingtai_zuobiao(idx, 1)-50, pingtai_zuobiao(idx, 2), 100, 100], 'FaceColor',[1 0 0]);
                chengben_pingtai_after(idx) = qukuai_zuanjing(jingzuobiao_pingtai, jingchang_doudong, pingtai_zuobiao(idx, :));
            end   
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%计算利润
        PERM_mean = 0.00003;
        result_npv = 0;
        for zdx=1:jingshu
            POR_mean = compute_meanvalue(jing_zuobiao(zdx, 1), jing_zuobiao(zdx, 2), x_por, y_por, zuiyou_banchang(zdx), zuiyou_jingchang_reshape(zdx), value_por);
            SG_mean = compute_meanvalue(jing_zuobiao(zdx, 1), jing_zuobiao(zdx, 2), x_sg, y_sg, zuiyou_banchang(zdx), zuiyou_jingchang_reshape(zdx), value_sg);

            result_npv(zdx) = NPV0719([POR_mean, PERM_mean, SG_mean, zuiyou_banchang(zdx), zuiyou_jianju(1), zuiyou_jingchang_reshape(zdx), zuiyou_daoliu(1)], [jing_zuobiao(zdx, 1), jing_zuobiao(zdx, 2)], zuiyou_jingchang_reshape(zdx), pingtai_zuobiao(lianjie_flag(zdx), :));
        end
        result_all = sum(result_npv);
        zonglirun = [zonglirun, result_all];
        if topdown == 2
            x_por = -x_por;
            y_por = -y_por;
            x_sg = -x_sg;
            y_sg = -y_sg;
            x_za = -x_za;
            y_za = -y_za;
            x_dengzhixian = -x_dengzhixian;
            y_dengzhixian = -y_dengzhixian;
            pingtai_zuobiao = -pingtai_zuobiao;
            jing_zuobiao_reshape = -jing_zuobiao;
        end
        zongchengben = [zongchengben, sum(chengben_pingtai_after)];
        if ceng > 1
            lianjie_flag = max(lianjie_flagzong) + lianjie_flag;
        end
        lianjie_flagzong = [lianjie_flagzong, lianjie_flag];
        pingtai_zong = [pingtai_zong; pingtai_zuobiao];
        jingzuobiao_zong = [jingzuobiao_zong; jing_zuobiao_reshape];
        jingchang_zong = [jingchang_zong, zuiyou_jingchang_reshape];
        pingtai_ceng_temp = [pingtai_ceng_temp, repmat(ceng, 1, pingtaishu)];
    end
end
zongchengben = sum(zongchengben);
maolirun = sum(zonglirun);
zhenlirun = maolirun - zongchengben;