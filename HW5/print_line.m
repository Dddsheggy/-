function [final_X_new,const] = print_line(X,Y,pcs,cprs_c,cprs_data,alpha)
[N,n]=size(X);
avr_X=mean(X,1);
avr_y=mean(Y);
sigma_X=sqrt(var(X,1));
sigma_y=sqrt(var(Y));

normal_Y=(Y-avr_y)/sigma_y;
fprintf('利用主成分进行非病态的多元线性回归的中间结果：\n')
final_X=linear_regression(normal_Y,cprs_data',0.05);

final_X=final_X*pcs';
for i=1:n
    final_X(i)=final_X(i)/cprs_c(2,i);
end
final_X_new=final_X*sigma_y;
c=final_X_new.*sigma_X/sigma_y;
const=avr_y;
for i=1:n
    const=const-c(i)*avr_X(i)*sigma_y/sigma_X(i);
end

est_Y=zeros(N,1);
for i=1:N
    tmp=X(i,:);
    est_Y(i)=const+final_X_new*tmp';
end
RSS=sum((Y-est_Y).^2);
S=sqrt(RSS/(N-n-1));
Z_half_alpha=norminv(1-alpha/2,0,1);

fprintf('最终结果：\n')
fprintf('回归方程为y =\n%.10f\n',const);
for i=1:n
    if(final_X_new(i)>0)
        fprintf('+%.10f * x%d\n ',final_X_new(i),i);
    else
        fprintf('%.10f * x%d\n',final_X_new(i),i);
    end
end
fprintf('置信区间为（y-%.5f, y+%.5f)\n\n',S*Z_half_alpha,S*Z_half_alpha);
end

