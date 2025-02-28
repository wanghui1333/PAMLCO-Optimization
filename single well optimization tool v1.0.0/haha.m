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
0.04	0.002	400	4000];

y_train=[374.19
273.09
112.77
398.66
273.09
543.92
577.96
182.34
46.346
328.6
212.09
93.718
273.09
147.81
62.601
120.93
437.21
61.929
273.09
157.32
441.07
348.48
246.1
138.88
273.09
161.49
100.02
143.07
323.89
72.17
114.94
143.45
214.7
285.54
355.58
85.131
125.34
175.31
201.64
246.4
271.05
169.6
249.57
348.75
400.49
487.91
535.99
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
       
cvgprMdl_idx = crossval(gprMdl_idx,'KFold',29);
L1 = kfoldLoss(cvgprMdl_idx,'mode','individual');
L2 = kfoldLoss(cvgprMdl_idx);
mse = mean(L1);
ypred_idx(:,1) = kfoldPredict(cvgprMdl_idx);
        gprMdl_jdx = fitrgp(x_train, y_train,'KernelFunction',char(kernel(jdx)) ,'FitMethod','sr','PredictMethod','fic', 'Standardize',1);
         rng('default')
        
cvgprMdl_jdx = crossval(gprMdl_jdx,'KFold',29);
L3 = kfoldLoss(cvgprMdl_jdx,'mode','individual');
L4 = kfoldLoss(cvgprMdl_jdx);
mse = mean(L3);
ypred_jdx(:,1) = kfoldPredict(cvgprMdl_jdx);
        for kdx=1:length(factor)
            output_train = ypred_idx * factor(kdx) + ypred_jdx * (1-factor(kdx));
            
            if mean(abs(y_train-output_train)./y_train) <0.03
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


