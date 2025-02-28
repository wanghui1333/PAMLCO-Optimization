
clc;
clear all;
x_train=[32.34946	1652	1769.090909	63.00909091	3.77231969	61.58534116	9.838984432	77.06	50.62	6.2	0.134020426	0.000458442
33.5985533	1666	1842.380952	62.38095238	3.723396871	60.0456327	11.49810413	66.17142857	35.91666667	6.3	0.134930796	0.000289136
35.4594851	1566	1759.444444	64.09444444	3.770854085	54.00761584	27.53443448	81.08947368	56.48421053	6.11	0.133698298	0.001082237
35.5598126	1514	1825	66.265	4.379242144	61.00335483	9.386883011	78.37368421	46.14736842	6.2	0.135986723	6.73079E-05
36.2978408	1757	1846.363636	62.72727273	3.852205974	61.29135742	11.42035604	72.46454545	37.51363636	6.4	0.134930796	0.000289136
37.6810863	1513	1893.684211	67.1	4.11327959	51.98363993	8.184878724	66.67736842	37.2	6.1	0.136434389	1.68031E-06
38.1638049	1062	1838	62.5	3.037129641	60.67151537	15.5658503	82.94666667	46.32	5.8	0.134960261	0.00027874
38.8625302	1413	1781.111111	62.82222222	4.245621097	59.29335014	14.08346594	74.60555556	34.29444444	5.9	0.134552403	0.000326079
39.4022603	1542	1849.5	63	3.515653202	64.95749533	13.79400593	57.1085	32.8	6.0 	0.121536904	0.001797637
39.6153368	1717	1845	62.60869565	3.697259021	67.91501628	21.66123129	79.42652174	42.45434783	5.73	0.133698298	0.001082237
42.07645	1500	1761.65	62.5	3.898086301	49.67423255	13.58490485	75.733	45.555	6.23	0.136434389	1.68031E-06
42.1463289	1406	1893.684211	67.1	3.786084952	62.83335515	27.53443448	79.02631579	44.37894737	6.03	0.134587569	0.000235177
42.2058884	1500	1912.5	69.77	3.141314284	58.2898506	37.34928225	82.045	36.16	5.73	0.128099271	0.000229497
43.9057229	1596	1870	60	4.049829337	65.74880042	20.78787762	70.26818182	42.27272727	5.75	0.121536904	0.001797637
44.0739546	1560	1869.761905	65.12380952	3.84570416	74.40861701	21.63776027	76.39047619	39.31428571	5.72	0.113886105	0.00020584
44.4612506	1232	1900	70	3.278476555	56.04827074	48.37452496	64.69411765	33.49411765	5.82	0.113028911	0.001026862
44.6477642	1500	1919.25	71	3.652866845	58.60657422	13.54545807	80.59473684	44.42105263	5.83	0.128099271	0.000229497
46.5463427	1800	1870	60	3.572034827	48.60827475	18.24980327	78.40521739	45.20869565	5.86	0.134676426	0.001216765
47.9869182	1403	2115.789474	70.78947368	3.808894215	70.16073444	25.05292111	95.30952381	60.58095238	5.61	0.113570857	0.000364575
48.0327822	1494	2114.285714	70.71428571	3.969915205	70.27215362	26.23674912	89.38095238	57.83809524	5.81	0.113028911	0.001026862
48.6689541	1500	1873.043478	66.40434783	3.586857769	63.22715246	24.49234027	94.36521739	61.99130435	5.55	0.117223674	0.000145551

    ];
y_train=[1.44
1.0622
0.8566
1.384
1.1554
1.05738
1.1572
1.1
1.4399
1.4228
0.6794
0.8092
1.132
1.161
0.8334
0.9074
1.0051
1.4688
0.74704
1.244
0.68616

    ];
%x_test=[0.04, 0.002,   x(1),  x(2)];
% scale = [10, 1000, 1, 0.001, 0.0001, 0.1];
% for idx=1:length(scale)
%     x_train(:, idx) = x_train(:, idx) * scale(idx);
%      x_test(:, idx) = x_test(:, idx) * scale(idx);
% end
%  x_test=zscore(x_test);
%  x_train=zscore(x_train);
% factor = 0.1;
% regua=[0.000780967823085971];
% kparams0=[8.87046300623582,1.68959160641905,4.95873670316361,8.75443395666459,5.79311884023257,10.2760630968636,7.44394730711642];
% sigmaN0=[1.14002451990162];

%kernel = [{'exponential'},{'squaredexponential'},{'matern32'},{'matern52'},{'rationalquadratic'},{'ardexponential'},{'ardsquaredexponential'},{'ardmatern32'},{'ardmatern52'},{'ardrationalquadratic'}];

gprMdl_idx = fitrgp(x_train, y_train,'KernelFunction','ardrationalquadratic' ,'FitMethod','sr','PredictMethod','fic', 'Standardize',1,'regularization', 0.1);
cvgprMdl_idx = crossval(gprMdl_idx,'KFold',10);
 L1 = kfoldLoss(cvgprMdl_idx,'mode','individual');
 L2 = kfoldLoss(cvgprMdl_idx);
 mse = mean(L1);
 ypred_idx(:,1) = kfoldPredict(cvgprMdl_idx);
 output_train = ypred_idx(:,1);
 RMSE = sqrt(mean((y_train-output_train).^2))
 

 
 
 
 
 
 
 


