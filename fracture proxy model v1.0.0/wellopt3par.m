clear all;
clc;
global gprMdl_1
global gprMdl_2
global gprMdl_3
global gprMdl_4
global gprMdl_5
global gprMdl_6
global gprMdl_7
global gprMdl_8
global gprMdl_9
global gprMdl_10
global gprMdl_11
global gprMdl_12
global gprMdl_13
global gprMdl_14
global gprMdl_15
global gprMdl_16
global gprMdl_17
global gprMdl_18
temp = load('models/model_1');
gprMdl_1 = temp.gprMdl_idx;
temp = load('models/model_2');
gprMdl_2 = temp.gprMdl_idx;
temp = load('models/model_3');
gprMdl_3 = temp.gprMdl_idx;
temp = load('models/model_4');
gprMdl_4 = temp.gprMdl_idx;
temp = load('models/model_5');
gprMdl_5 = temp.gprMdl_idx;
temp = load('models/model_6');
gprMdl_6 = temp.gprMdl_idx;
temp = load('models/model_7');
gprMdl_7 = temp.gprMdl_idx;
temp = load('models/model_8');
gprMdl_8 = temp.gprMdl_idx;
temp = load('models/model_9');
gprMdl_9 = temp.gprMdl_idx;
temp = load('models/model_10');
gprMdl_10 = temp.gprMdl_idx;
temp = load('models/model_11');
gprMdl_11 = temp.gprMdl_idx;
temp = load('models/model_12');
gprMdl_12 = temp.gprMdl_idx;
temp = load('models/model_13');
gprMdl_13 = temp.gprMdl_idx;
temp = load('models/model_14');
gprMdl_14 = temp.gprMdl_idx;
temp = load('models/model_15');
gprMdl_15 = temp.gprMdl_idx;
temp = load('models/model_16');
gprMdl_16 = temp.gprMdl_idx;
temp = load('models/model_17');
gprMdl_17 = temp.gprMdl_idx;
temp = load('models/model_18');
gprMdl_18 = temp.gprMdl_idx;
%FHL£¬HSL£¬CS£¬FC
range = [50 200; 1000 4000; 10 25; 1 20; ];
[a,b,c,d] = gaot (range, 'EUR',[],[],[],'maxGenTerm', 50)
