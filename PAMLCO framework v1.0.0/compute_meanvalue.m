function [result] = compute_meanvalue(x_position, y_position, x_base, y_base, halflength, jinglength, canshu)

% canshu = 2:101;
% x_base = 1:100;
% y_base = 1:100;
% 
% x_position = [50, 40];
% y_position = [40, 50];
% 
% halflength = [20, 15];
% jiangchang = [10, 15];

for i=1:length(x_position)
    
    x_range = [x_position(i) - halflength, x_position(i)+halflength];
    y_range = [y_position(i), y_position(i)+jinglength];

    x_indexes = x_base>= x_range(1) & x_base<= x_range(2);
    y_indexes = y_base>= y_range(1) & y_base<= y_range(2);
    indexes = x_indexes & y_indexes;
    if sum(indexes) > 0
        result(i) = mean(canshu(indexes));
    else
        result(i) = 0;
    end
end

