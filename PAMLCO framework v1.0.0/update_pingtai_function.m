function [pingtaizuobiao_anchor] = update_pingtai_function(jingzuobiao_pingtai, pingtaizuobiao_anchor) % ����һ��ƽ̨����

[jingshu, temp]= size(jingzuobiao_pingtai); % �õ������ж��ٿھ�

%����̨�ڵľ�����λ��
buchang = 0.1;
vectors_displace = (jingzuobiao_pingtai - repmat(pingtaizuobiao_anchor, jingshu, 1));
weights = compute_weight(vectors_displace);
weights = repmat(weights, 1, 2);
move_jing = buchang * (weights .* vectors_displace);
move_jing = sum(move_jing, 1);

% distance = sum(sqrt(sum((jingzuobiao_pingtai-repmat(pingtaizuobiao_anchor, jingshu, 1)).^2, 2)))

pingtaizuobiao_anchor = pingtaizuobiao_anchor + move_jing;
%�ж��Ƿ���������������ϵĻ���ֹͣ����
if ~panduan(jingzuobiao_pingtai, pingtaizuobiao_anchor)
    pingtaizuobiao_anchor = pingtaizuobiao_anchor - move_jing;
end
% distance = sum(sqrt(sum((jingzuobiao_pingtai-repmat(pingtaizuobiao_anchor, jingshu, 1)).^2, 2)))


