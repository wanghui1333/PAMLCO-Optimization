function [flag] = panduan(jingzuobiao_pingtai, pingtaizuobiao_anchor) % 判断是否满足347，角度，井内三个要求
% jingzuobiao_pingtai = [101,540.302305868140;601,-83.9293987848358;1101,-391.940429597104];
% pingtaizuobiao_anchor = [51,-1200];
[jingshu, temp]= size(jingzuobiao_pingtai);
flag=1;
for idx=1:jingshu
    if jingzuobiao_pingtai(idx, 2)-343.77 < pingtaizuobiao_anchor(2)
        flag=0;
        break;
    end
    distance = compute_distance(jingzuobiao_pingtai(idx, :), pingtaizuobiao_anchor);
    if distance < 343.77
        flag=0;
        break;
    end
%     vectors = jingzuobiao_pingtai(idx, :) - pingtaizuobiao_anchor;
%     if abs(vectors(2) / vectors(1))<tand(10)
%         flag = 0;
%     end
end
