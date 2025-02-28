function [juli, bottom]=juli_bottom2(x)
zuobiao = [18.7168	3.23136
18.7186	3.23332
18.717	3.23438
18.7167	3.23374
18.7168	3.23136
]*1e6;
x_bases = zuobiao(:,1);
y_bases = zuobiao(:,2);
sita = 30;
x_base = cosd(sita) * x_bases -sind(sita) * y_bases;
y_base = sind(sita) * x_bases + cosd(sita) * y_bases;
p = load('xishu2.mat');
p = p.p;
values = [];
if x_base(1) <= x & x < x_base(2)
    temp = polyval(p(1, :), x);
    values = [values, temp];
end
if x_base(3) <= x & x < x_base(2)
    temp = polyval(p(2, :), x);
    values = [values, temp];
end
if x_base(3) <= x & x < x_base(4)
    temp = polyval(p(3, :), x);
    values = [values, temp];
end
if x_base(4) <= x & x < x_base(1)
    temp = polyval(p(4, :), x);
    values = [values, temp];
end
bottom = min(values);
juli = abs(values(1) - values(2));