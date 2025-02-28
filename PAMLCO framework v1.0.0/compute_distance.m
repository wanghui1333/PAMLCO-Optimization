function [distance] = compute_distance(a, b)
distance = sum((a-b).^2);
distance = sqrt(distance);
end