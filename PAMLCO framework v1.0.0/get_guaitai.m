function [indexes] = get_guaitai(lianjie_flag)
% lianjie_flag = [1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,3,3,3,3,3,3,3,4,4,5,5,6,7,8,9,10,10,10,10,10,11,11,11,11,11,11,12,13,13,13,14,15,15,15,15,15];
result = [];
for value=1:max(lianjie_flag)
    if sum(lianjie_flag==value) <= 1
        result = [result, value];
    end
end
indexes = [];
for value=1:length(result)
    indexes = [indexes, find(lianjie_flag == result(value))];
end
