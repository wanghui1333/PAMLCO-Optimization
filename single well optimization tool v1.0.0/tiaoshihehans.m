clear all;
clc;


x_train=[
];

y_train=[3.6222
2.0191
0.65946
1.5839
1.3083
1.8307
1.8905
6.5448
1.6441
3.3568
0.62042
4.1434
7.3059
5.578
5.0536
1.8664
4.9852
2.8591
1.4274
0.50902
0.73444
3.3568
1.9307
3.3568
4.5721
1.783
2.7912
1.2618
1.4493
7.601
0.98263
5.5559
5.4044
1.9868
1.2169
3.3568
1.0141
3.1686
1.4039
3.3568
4.829
2.4538
1.0085
3.3568
1.6554
4.7678
];



%对原始数据处理
% scale = [0.01, 0.0001, 0.01, 0.0001, 0.01, 0.1,1, 0.01];
% for idx=1:length(scale)
%     x_train(:, idx) = x_train(:, idx) * scale(idx);    
% end
%x_train=zscore(x_train);
% x_train=mapminmax(x_train,0,1);

% meanX = mean(x_train);
% stdX = std(x_train);
% x_train = bsxfun(@rdivide,bsxfun(@minus,x_train,meanX),stdX); 

kernel = [{'exponential'},{'squaredexponential'},{'matern32'},{'matern52'},{'rationalquadratic'},{'ardexponential'},{'ardsquaredexponential'},{'ardmatern32'},{'ardmatern52'},{'ardrationalquadratic'}];
N_kernels = length(kernel);
factor=[1,0.9,0.8,0.7,0.6,0.5,0.4,0.3,0.2,0.1,0];
for idx=1:N_kernels-1
    for jdx=idx+1:N_kernels
        gprMdl_idx = fitrgp(x_train, y_train,'KernelFunction',char(kernel(idx)) ,'FitMethod','sr','PredictMethod','fic', 'Standardize',1);

        rng('default')
       
cvgprMdl_idx = crossval(gprMdl_idx,'KFold',46);
L1 = kfoldLoss(cvgprMdl_idx,'mode','individual');
L2 = kfoldLoss(cvgprMdl_idx);
mse = mean(L1);
ypred_idx(:,1) = kfoldPredict(cvgprMdl_idx);
        gprMdl_jdx = fitrgp(x_train, y_train,'KernelFunction',char(kernel(jdx)) ,'FitMethod','sr','PredictMethod','fic', 'Standardize',1);
         rng('default')
        
cvgprMdl_jdx = crossval(gprMdl_jdx,'KFold',46);
L3 = kfoldLoss(cvgprMdl_jdx,'mode','individual');
L4 = kfoldLoss(cvgprMdl_jdx);
mse = mean(L3);
ypred_jdx(:,1) = kfoldPredict(cvgprMdl_jdx);
        for kdx=1:length(factor)
            output_train = ypred_idx * factor(kdx) + ypred_jdx * (1-factor(kdx));
            
            if mean(abs(y_train-output_train)./y_train) <0.032
                save(strcat('results\', 'xiaohui', num2str(factor(kdx)), char(kernel(idx)), char(kernel(jdx))), 'factor');
            end
        end
    end
end




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


