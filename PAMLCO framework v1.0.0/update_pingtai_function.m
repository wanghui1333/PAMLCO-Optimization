function [pingtaizuobiao_anchor] = update_pingtai_function(jingzuobiao_pingtai, pingtaizuobiao_anchor) % 更新一次平台坐标

[jingshu, temp]= size(jingzuobiao_pingtai); % 得到该组有多少口井

%根据台内的井计算位移
buchang = 0.1;
vectors_displace = (jingzuobiao_pingtai - repmat(pingtaizuobiao_anchor, jingshu, 1));
weights = compute_weight(vectors_displace);
weights = repmat(weights, 1, 2);
move_jing = buchang * (weights .* vectors_displace);
move_jing = sum(move_jing, 1);

% distance = sum(sqrt(sum((jingzuobiao_pingtai-repmat(pingtaizuobiao_anchor, jingshu, 1)).^2, 2)))

pingtaizuobiao_anchor = pingtaizuobiao_anchor + move_jing;
%判断是否符合条件，不符合的话，停止不动
if ~panduan(jingzuobiao_pingtai, pingtaizuobiao_anchor)
    pingtaizuobiao_anchor = pingtaizuobiao_anchor - move_jing;
end
% distance = sum(sqrt(sum((jingzuobiao_pingtai-repmat(pingtaizuobiao_anchor, jingshu, 1)).^2, 2)))


