clear all;
clc;
close all;

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
plot(x_base, y_base)

for idx = 1:length(x_base)-1
    text(x_base(idx), y_base(idx), num2str(idx))
end
points_n = length(zuobiao);
for idx = 1:points_n-1
    point_a = x_base(idx:idx+1);
    point_b = y_base(idx:idx+1);
    p(idx, :) = polyfit(point_a, point_b, 1);
end
save('xishu3.mat', 'p')

