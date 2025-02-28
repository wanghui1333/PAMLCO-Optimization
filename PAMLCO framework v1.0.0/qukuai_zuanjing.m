function [pingtai_chengben] = qukuai_zuanjing(jingzuobiao_pingtai_hebing, jingchang_hebing, pingtaizuobiao_hebing) % A靶点坐标，井长，平台坐标
[jingshu, temp] = size(jingzuobiao_pingtai_hebing);
% ZA=3500;
% ZB=3500;
jing_chengben = 0;
global x_za
global y_za
global value_za
global x_dengzhixian
global y_dengzhixian
global value_dengzhixian

for idx=1:jingshu
    bar_a = jingzuobiao_pingtai_hebing(idx, :);
    pingtai_zuobiao = pingtaizuobiao_hebing;

    [XA, YA]=deal(bar_a(1), bar_a(2));
    [Xi, Yi]=deal(pingtai_zuobiao(1), pingtai_zuobiao(2));
    changdu = (x_dengzhixian - XA).^2 + (y_dengzhixian - YA).^2;
    [value, index_min] = min(changdu);
    % A 靶点坐标
    zuobiaox_true = x_dengzhixian(index_min);
    zuobiaoy_true = y_dengzhixian(index_min);
    value_true = value_dengzhixian(index_min);
    % 得到那一列信息
    candidate_y = y_dengzhixian(zuobiaox_true == x_dengzhixian);
    candidate_x = x_dengzhixian(zuobiaox_true == x_dengzhixian);
    candidate_value = value_dengzhixian(zuobiaox_true == x_dengzhixian);
    candidate_by = candidate_y(candidate_y > zuobiaoy_true);
    candidate_bvalue = candidate_value(candidate_y > zuobiaoy_true);
    candidate_bx = candidate_x(candidate_y > zuobiaoy_true);
    % 求取最近的值
    changdu = sqrt((candidate_by - zuobiaoy_true).^2 + (candidate_bvalue - value_true).^2);
    [value, index_min] = min(abs((changdu - jingchang_hebing(idx))));
    zuobiaox_trueb = candidate_bx(index_min);
    zuobiaoy_trueb = candidate_by(index_min);
    value_trueb = candidate_bvalue(index_min);
    XA = zuobiaox_true;
    YA = zuobiaoy_true;
    changdu = (x_za - XA).^2 + (y_za - YA).^2;
    [value, index_min] = min(changdu);
    ZA = value_za(index_min);

    XB = zuobiaox_trueb;
    YB = zuobiaoy_trueb;
   if isempty(XB) || isempty(YB)
        jing_chengben(idx) = 10e10;
        continue;
    end
    changdu = (x_za - XB).^2 + (y_za - YB).^2;
    [value, index_min] = min(changdu);
    ZB = value_za(index_min);
    
    L=sqrt((XA-XB)^2+(YA-YB)^2+(ZA-ZB)^2);
    Lpianyiju=abs((XB-XA)*Yi-(YB-YA)*Xi-YA*(XB-XA)+XA*(YB-YA))/sqrt((XA-XB)^2+(YA-YB)^2);
    Lbaqianju=sqrt((Xi-XA)^2+(Yi-YA)^2-Lpianyiju^2);
    Djinchi=ZA+226.23+0.268*sqrt((Lbaqianju-343.77)^2+Lpianyiju^2)+L;
    DA=ZA+226.23+0.268*sqrt((Lbaqianju-343.77)^2+Lpianyiju^2);
    
     if Djinchi<=5000 %Djinchi<5000m
        jing_chengben(idx)=6419249+1682.6937*Djinchi+0.3024432575*Djinchi^2 + 0.0000072470369*Djinchi^3-0.0000059816812*Djinchi^2*DA+859.21936*DA-0.253570107*Djinchi*DA+0.1362177047*DA^2+0.0000029908406*Djinchi*DA^2 ;

    elseif Djinchi<=7000     %5000m<Djinchi<7000m
        jing_chengben(idx)=7477591+1523.8474*Djinchi+0.3406464357*Djinchi^2+0.0000072470369*Djinchi^3-0.0000059816812*Djinchi^2*DA+958.66891*DA-0.285102889*Djinchi*DA+0.1519840957*DA^2+0.0000029908406*Djinchi*DA^2;

   elseif  Djinchi>7000 
        jing_chengben(idx) = 10e10;
    end    
end
pingtai_chengben = sum(jing_chengben) + 300000*jingshu+8000000;
    

