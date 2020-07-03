function final_X=linear_regression(Y,X,alpha)
% 规范化处理
avr_X=mean(X,1);
avr_y=mean(Y);
sigma_X=sqrt(var(X,1));
sigma_y=sqrt(var(Y));

[N,n]=size(X);
tmp_X1=zeros(N,n);
tmp_X2=zeros(N,n);
for i=1:N
    tmp_X1(i,:)=avr_X;
    tmp_X2(i,:)=sigma_X;
end

normal_X=(X-tmp_X1)./tmp_X2;
normal_Y=(Y-avr_y)/sigma_y;

% 判断是否为病态问题
% 特征值阈值设为0.05
threshold=0.05;
A=normal_X'*normal_X;
[V,D]=eig(A);
eigenvalue=diag(D);
for i=n:-1:1
    if sum(eigenvalue(i:n))/ sum(eigenvalue)>= 1-threshold
        break;
    end
end
m=n-i+1;

% 对于是否是病态问题给出提示
if m<n
    fprintf('此问题是病态线性回归问题，需要从%d维降至%d维\n',n,m); 
else
    fprintf('此问题不是病态线性回归问题\n');
end

% 参数求解
B=normal_X'*normal_Y;
inv_ZZ=zeros(m,m);
Qm=zeros(n,m);
for i=1:m
    inv_ZZ(i,i)=1/D(n-i+1,n-i+1);
    Qm(:,i)=V(:,n-i+1);
end
d=inv_ZZ*Qm'*B;
c=Qm*d;
    
% 还原
final_X=c'*sigma_y./sigma_X;
const=avr_y;
for i=1:n
    const=const-c(i)*avr_X(i)*sigma_y/sigma_X(i);
end

% 显著性检验
est_Y=zeros(N,1);
for i=1:N
    tmp=X(i,:);
    est_Y(i)=const+final_X*tmp';
end
ESS=sum((est_Y-avr_y).^2);
RSS=sum((Y-est_Y).^2);
F=(N-n-1)*ESS/n/RSS;
Fa=finv(1-alpha,n,N-n-1);
if F>Fa
    fprintf('F=%.5f, Fa=%.5f, F>Fa, 即存在线性关系\n',F,Fa);
    % 预测精度
    S=sqrt(RSS/(N-n-1));
    Z_half_alpha=norminv(1-alpha/2,0,1);
    fprintf('回归方程为y =\n%.10f\n',const);
    for i=1:n
        if(final_X(i)>0)
            fprintf('+%.10f * x%d\n ',final_X(i),i);
        else
            fprintf('%.10f * x%d\n',final_X(i),i);
        end
    end
    fprintf('置信区间为（y-%.5f, y+%.5f)\n\n',S*Z_half_alpha,S*Z_half_alpha);
else
    fprintf('不存在线性关系\n');
end

end

