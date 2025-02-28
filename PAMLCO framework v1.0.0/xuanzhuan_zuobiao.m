function [a, b]=xuanzhuan_zuobiao(x, y, sita)
a = cosd(sita) * x -sind(sita) * y;
b = sind(sita) * x + cosd(sita) * y;
end