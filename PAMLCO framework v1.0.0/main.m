clc;
clear all;
close all;

global x_por
global y_por
global value_por
global x_sg
global y_sg
global value_sg
global x_za
global y_za
global value_za
global x_dengzhixian
global y_dengzhixian
global value_dengzhixian
global pingtai_zuobiao
global x_yali
global y_yali
global value_yali

global gprMdl_1
global gprMdl_2
global gprMdl_3


temp = load('models/model_1');
gprMdl_1 = temp.gprMdl_idx;
temp = load('models/model_2');
gprMdl_2 = temp.gprMdl_idx;
temp = load('models/model_3');
gprMdl_3 = temp.gprMdl_idx;


data_por = xlsread('./por.xlsx');
x_por = data_por(:, 1)';
y_por = data_por(:, 2)';
value_por = data_por(:, 3)'*0.01;


data_sg = xlsread('./sg.xlsx');
x_sg = data_sg(:, 1)';
y_sg = data_sg(:, 2)';
value_sg = data_sg(:, 3)';


data_za = xlsread('./za.xlsx');
x_za = data_za(:, 1)';
y_za = data_za(:, 2)';
value_za = data_za(:, 3)';
x_za = round(x_za);

data_dengzhixian = xlsread('./dengzhixian.xlsx');
x_dengzhixian = data_dengzhixian(:, 1)';
y_dengzhixian = data_dengzhixian(:, 2)';
value_dengzhixian = data_dengzhixian(:, 3)';
x_dengzhixian = round(x_dengzhixian);

data_kuangqu = xlsread('./pingtai_zuobiao.xlsx', 'jiaoye');
x_bases = data_kuangqu(:, 4);
y_bases = data_kuangqu(:, 5);
sita = 30;
pingtai_zuobiao(:, 1) = cosd(sita) * x_bases -sind(sita) * y_bases;
pingtai_zuobiao(:, 2) = sind(sita) * x_bases + cosd(sita) * y_bases;

data_yali = xlsread('./yali.xlsx');
x_bases = data_yali(:, 1);
y_bases = data_yali(:, 2);
value_yali = data_yali(:, 3);
sita = 30;
x_yali = cosd(sita) * x_bases -sind(sita) * y_bases;
y_yali = sind(sita) * x_bases + cosd(sita) * y_bases;

global zuiyoulirun
global tail
zuiyoulirun = 0;
tail = 500;
range_jinglength = [50, 200; 10, 25; 1, 20];
results = [];
data = [];

[a,b,c,d]=gaot(range_jinglength, 'fitness', data, [], [], 'maxGenTerm', 50);
results = [results, a(1:2)];

