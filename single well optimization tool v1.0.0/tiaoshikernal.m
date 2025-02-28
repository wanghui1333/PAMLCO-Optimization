function [S,error] = moxingjicheng(S,options)
kparams0=S(1:7);
sigmaN0 = S(8);
idx_kernel = round(S(9));
jdx_kernel = round(S(10));
regua=S(11);


x_train=[];


y_train=[];


% scale = [0.01, 0.0001, 0.01, 0.0001, 0.01, 0.1,1, 0.01];
% for idx=1:length(scale)
%     x_train(:, idx) = x_train(:, idx) * scale(idx);
%  %    x_test(:, idx) = x_test(:, idx) * scale(idx);
% end
 x_train=zscore(x_train);

factor = 0.1;

kernel_all = [{'none'},{'constant'},{'linear'},{'pureQuadratic'}];
 gprMdl_idx = fitrgp(x_train, y_train,'KernelFunction','ardexponential', 'BasisFunction',char(kernel_all(idx_kernel)), 'KernelParameters',kparams0, 'Sigma',sigmaN0, 'FitMethod','sr','PredictMethod','fic', 'Standardize',true,'regularization', regua);
cvgprMdl_idx = crossval(gprMdl_idx,'KFold',25);
gprMdl_jdx = fitrgp(x_train, y_train,'KernelFunction','ardmatern32','BasisFunction',char(kernel_all(jdx_kernel)), 'KernelParameters',kparams0, 'Sigma',sigmaN0, 'FitMethod','sr','PredictMethod','fic', 'Standardize',true,'regularization', regua);
cvgprMdl_jdx = crossval(gprMdl_jdx,'KFold',25);
% L1 = kfoldLoss(cvgprMdl_idx);
% L2 = kfoldLoss(cvgprMdl_jdx);
% mse = mean(L1);
% mse = mean(L2);

ypred_idx(:,1) = kfoldPredict(cvgprMdl_idx);
ypred_jdx(:,1) = kfoldPredict(cvgprMdl_jdx);
output_train = ypred_idx * factor + ypred_jdx * (1-factor);
%output_train = ypred_jdx;
error=-1 * mean(abs(y_train-output_train)./y_train)
file_name = datetime('now');
if error>-0.2
    save(file_name, 'error', 'cvgprMdl_idx',  'cvgprMdl_jdx')
end






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


