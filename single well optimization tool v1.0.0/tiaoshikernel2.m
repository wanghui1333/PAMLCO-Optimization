function [S,RMSE] = tiaoshikernel2(S, options)

kparams0=S(1:5);
sigmaN0 = S(6);
jdx_kernel = round(S(7));
regua=S(8);


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
0.04	0.002	400	4000];
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
5.3599];


% scale = [0.01, 0.0001, 0.01, 0.0001, 0.01, 0.1,1, 0.01];
% for idx=1:length(scale)
%     x_train(:, idx) = x_train(:, idx) * scale(idx);
%  %    x_test(:, idx) = x_test(:, idx) * scale(idx);
% end
 x_train=zscore(x_train);

factor = 0.1;

kernel_all = [{'none'},{'constant'},{'linear'},{'pureQuadratic'}];
%  gprMdl_idx = fitrgp(x_train, y_train,'KernelFunction','exponential', 'BasisFunction',char(kernel_all(idx_kernel)), 'KernelParameters',kparams1, 'Sigma',sigmaN0, 'FitMethod','sr','PredictMethod','fic', 'Standardize',true,'regularization', regua);
% cvgprMdl_idx = crossval(gprMdl_idx,'KFold',50);
gprMdl_jdx = fitrgp(x_train, y_train,'KernelFunction','ardmatern52','BasisFunction',char(kernel_all(jdx_kernel)), 'KernelParameters',kparams0, 'Sigma',sigmaN0, 'FitMethod','sr','PredictMethod','fic', 'Standardize',true,'regularization', regua);
cvgprMdl_jdx = crossval(gprMdl_jdx,'KFold',46);
% L1 = kfoldLoss(cvgprMdl_idx);
% L2 = kfoldLoss(cvgprMdl_jdx);
% mse = mean(L1);
% mse = mean(L2);

%ypred_idx(:,1) = kfoldPredict(cvgprMdl_idx);
ypred_jdx(:,1) = kfoldPredict(cvgprMdl_jdx);
%output_train = ypred_idx * factor + ypred_jdx * (1-factor);
output_train = ypred_jdx;
%error=1 * mean(abs(y_train-output_train)./y_train)
RMSE = -sqrt(mean((y_train-output_train).^2))
% file_name = datetime('now');
% if error>-0.2
%     save(file_name, 'error', 'cvgprMdl_idx',  'cvgprMdl_jdx')
% end






%≤‚ ‘ ˝æ›‘§≤‚
% ypred_idx = predict(gprMdl_idx,x_test);
% ypred_jdx = predict(gprMdl_jdx,x_test);
% output_train = (ypred_idx * factor + ypred_jdx * (1-factor));


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


