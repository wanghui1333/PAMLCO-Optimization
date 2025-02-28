function [weights] = compute_weight(distances)
    weights = sqrt(sum(distances.^2, 2));
    weights = weights / sum(weights);
end
