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
hold on
start_qu = min(x_base);
end_qu = max(x_base)
for x=start_qu:50:end_qu
    [juli, bottom]=juli_bottom3(x);
    rectangle('Position', [x, bottom, 10, juli], 'FaceColor', 'r');
end