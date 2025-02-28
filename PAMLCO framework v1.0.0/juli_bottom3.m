function [juli, bottom]=juli_bottom3(x)
zuobiao = [18.7105	3.22676
18.7129	3.22765
18.7132	3.22761
18.7142	3.22875
18.7146	3.22918
18.7165	3.2321
18.7167	3.23374
18.717	3.23438
18.7154	3.23538
18.7105	3.22676
]*1e6;
x_bases = zuobiao(:,1);
y_bases = zuobiao(:,2);
sita = 30;
x_base = cosd(sita) * x_bases -sind(sita) * y_bases;
y_base = sind(sita) * x_bases + cosd(sita) * y_bases;
p = load('xishu3.mat');
p = p.p;
values = [];
if x_base(1) <= x & x < x_base(2)
    temp = polyval(p(1, :), x);
    values = [values, temp];
end
if x_base(2) <= x & x < x_base(3)
    temp = polyval(p(2, :), x);
    values = [values, temp];
end
if x_base(3) <= x & x < x_base(4)
    temp = polyval(p(3, :), x);
    values = [values, temp];
end
if x_base(4) <= x & x < x_base(5)
    temp = polyval(p(4, :), x);
    values = [values, temp];
end
if x_base(5) <= x & x < x_base(6)
    temp = polyval(p(5, :), x);
    values = [values, temp];
end
if x_base(7) <= x & x < x_base(6)
    temp = polyval(p(6, :), x);
    values = [values, temp];
end
if x_base(8) <= x & x < x_base(7)
    temp = polyval(p(7, :), x);
    values = [values, temp];
end
if x_base(9) <= x & x < x_base(8)
    temp = polyval(p(8, :), x);
    values = [values, temp];
end
if x_base(9) <= x & x < x_base(1)
    temp = polyval(p(9, :), x);
    values = [values, temp];
end



bottom = min(values);
juli = abs(values(1) - values(2));