function [x,f0]=fminunc_global (f,xm,xn,n,N,varargin)
k0=0; f0=Inf; 

if strcmp (class(f),'struct'), k0=1;   %����ṹ��
end

for i=1:N
    x0=xm+(xn-xm).*rand (n,1) %��ѭ���ṹ���Բ�ͬ�����������ֵ
    if k0==1, f.x0=x0; [x1 f1 key]=fminunc (f); %�ṹ���������
    else, [x1 f1 key]=fminunc (f,x0, varargin{:});  %�ǽṹ���������
    end
    if key>0 & f1<f0, x=x1; f0=f1; 
    end                                       %����ҵ����õĽ⣬����ý�
end


% if k0==1, f.x0=x0; [x f0,flag]=fmincon(f); %�ṹ������������ֱ�����
% else
%     [x f0, flag] =fmincon (f,x0, varargin{:});   %�ǽṹ��������ֱ�����
% end
% if flag==0, f0=1e10;
% end
%         