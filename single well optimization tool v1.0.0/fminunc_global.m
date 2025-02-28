function [x,f0]=fminunc_global (f,xm,xn,n,N,varargin)
k0=0; f0=Inf; 

if strcmp (class(f),'struct'), k0=1;   %处理结构体
end

for i=1:N
    x0=xm+(xn-xm).*rand (n,1) %用循环结构尝试不同的随机搜索初值
    if k0==1, f.x0=x0; [x1 f1 key]=fminunc (f); %结构体问题求解
    else, [x1 f1 key]=fminunc (f,x0, varargin{:});  %非结构体问题求解
    end
    if key>0 & f1<f0, x=x1; f0=f1; 
    end                                       %如果找到更好的解，保存该解
end


% if k0==1, f.x0=x0; [x f0,flag]=fmincon(f); %结构体描述的问题直接求解
% else
%     [x f0, flag] =fmincon (f,x0, varargin{:});   %非结构体描述的直接求解
% end
% if flag==0, f0=1e10;
% end
%         