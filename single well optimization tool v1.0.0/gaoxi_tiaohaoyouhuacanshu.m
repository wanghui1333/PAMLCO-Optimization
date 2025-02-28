clear all;
clc;
x_train=[0.07	0.008	225	2500
0.04	0.0043	225	2500
0.04	0.008	225	1000
0.04	0.0005	225	4000
0.04	0.0043	225	2500
0.04	0.0043	400	4000
0.07	0.0043	225	4000
0.04	0.0043	50	4000
0.04	0.0043	50	1000
0.07	0.0005	225	2500
0.01	0.0043	400	2500
0.04	0.0005	50	2500
0.04	0.0043	225	2500
0.07	0.0043	225	1000
0.01	0.0043	225	1000
0.04	0.008	50	2500
0.07	0.0043	400	2500
0.01	0.0043	50	2500
0.04	0.0043	225	2500
0.01	0.008	225	2500
0.04	0.008	225	4000
0.04	0.008	400	2500
0.01	0.0043	225	4000
0.04	0.0043	400	1000
0.04	0.0043	225	2500
0.07	0.0043	50	2500
0.04	0.0005	225	1000
0.01	0.0005	225	2500
0.04	0.0005	400	2500
0.04	0.002	120	1000
0.04	0.002	120	1600
0.04	0.002	120	2000
0.04	0.002	120	3000
0.04	0.002	120	4000
0.04	0.002	120	5000
0.04	0.002	60	2000
0.04	0.002	100	2000
0.04	0.002	160	2000
0.04	0.002	200	2000
0.04	0.002	300	2000
0.04	0.002	400	2000
0.04	0.002	60	4000
0.04	0.002	100	4000
0.04	0.002	160	4000
0.04	0.002	200	4000
0.04	0.002	300	4000
0.04	0.002	400	4000
    ];

y_train=[3.7419
2.7309
1.1277
3.9866
2.7309
5.4392
5.7796
1.8234
0.46346
3.286
2.1209
0.93718
2.7309
1.4781
0.62601
1.2093
4.3721
0.61929
2.7309
1.5732
4.4107
3.4848
2.461
1.3888
2.7309
1.6149
1.0002
1.4307
3.2389
0.7217
1.1494
1.4345
2.147
2.8554
3.5558
0.85131
1.2534
1.7531
2.0164
2.464
2.7105
1.696
2.4957
3.4875
4.0049
4.8791
5.3599
];

%x_test=[0.04, 0.002,  120,  1600];
% scale = [10, 1000, 1, 0.001, 0.01, 0.0001, 0.01];
% for idx=1:length(scale)
%     x_train(:, idx) = x_train(:, idx) * scale(idx);
%      x_test(:, idx) = x_test(:, idx) * scale(idx);
% end
%   x_test=zscore(x_test);
%   x_train=zscore(x_train);
% factor = 0.1;
 regua=[0.127979907183517];
kparams0=[10.3340148333187,4.12373612441174,13.8547808259742,9.07789138024964,14.9999291164811];
sigmaN0=[3.66492292447437];
%kernel = [{'exponential'},{'squaredexponential'},{'matern32'},{'matern52'},{'rationalquadratic'},{'ardexponential'},{'ardsquaredexponential'},{'ardmatern32'},{'ardmatern52'},{'ardrationalquadratic'}];

%gprMdl_idx = fitrgp(x_train, y_train,'KernelFunction','ardmatern52' ,'FitMethod','sr','PredictMethod','fic', 'Standardize',1);
gprMdl_idx = fitrgp(x_train, y_train,'KernelFunction','ardmatern52' ,'KernelParameters',kparams0,'Sigma',sigmaN0,'BasisFunction','constant','FitMethod','sr','PredictMethod','fic', 'Standardize',1,'regularization', regua);

 cvgprMdl_idx = crossval(gprMdl_idx,'KFold',47);

%  cvgprMdl_jdx = crossval(gprMdl_jdx,'KFold',25);
L = kfoldLoss(cvgprMdl_idx,'mode','individual')
L2 = kfoldLoss(cvgprMdl_idx)
mse = mean(L)

ypred_idx(:,1) = kfoldPredict(cvgprMdl_idx);
% ypred_jdx(:,1) = kfoldPredict(cvgprMdl_jdx);
% output_train = ypred_idx * factor + ypred_jdx * (1-factor);
 output_train = ypred_idx ;
RMSE = sqrt(mean((y_train-output_train).^2))
 %error=mean(abs(y_train-output_train)./y_train)
%≤‚ ‘ ˝æ›‘§≤‚
% ypred_idx = predict(gprMdl_idx,x_test)
% ypred_jdx = predict(gprMdl_jdx,x_test);
% output_train = (ypred_idx * factor + ypred_jdx * (1-factor))


% gprMdl = fitrgp(x_train, y_train,'KernelFunction','ardrationalquadratic','FitMethod','sr','PredictMethod','fic', 'Standardize',1);
% rng('default')
% cvgprMdl = crossval(gprMdl,'KFold',60);
% L = kfoldLoss(cvgprMdl,'mode','individual')
% L2 = kfoldLoss(cvgprMdl)
% mse = mean(L)
% ypred = kfoldPredict(cvgprMdl);
% plot(y_train,'r.');
% hold on;
% plot(ypred,'b--.');
% axis([0 62 0 10]);
% legend('True response','GPR prediction','Location','Best');
% hold off;


