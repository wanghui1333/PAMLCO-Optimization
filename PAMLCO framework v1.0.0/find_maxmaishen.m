function [max_maishen, min_maishen] = find_maxmaishen(anchor)
global x_za
global y_za
global value_za
changdu = abs(x_za - anchor);
[value, index_min] = min(changdu);
zuobiaox_true = x_za(index_min);
candidate_y = value_za(zuobiaox_true == x_za);
max_maishen = max(candidate_y);
min_maishen = min(candidate_y);



