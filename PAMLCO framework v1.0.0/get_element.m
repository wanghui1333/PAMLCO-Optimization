function [yalieye, ZHICHENGJI] = get_element(x)
V = 0.1323*x(1)^2 +1.4386*x(1)-3.172;
yalieye=x(2)/77*V;
ZHICHENGJI=yalieye/27;
end