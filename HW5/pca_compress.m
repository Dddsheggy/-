function [pcs,cprs_data,cprs_c] = pca_compress(data,rerr)
% 规范化处理
X=data';
[N,n]=size(X);
avr_X=mean(X,1);
sigma_X=sqrt(var(X,1));

tmp_X1=zeros(N,n);
tmp_X2=zeros(N,n);
for i=1:N
    tmp_X1(i,:)=avr_X;
    tmp_X2(i,:)=sigma_X;
end
normal_X=(X-tmp_X1)./tmp_X2;

% 判断是否为病态问题
A=normal_X'*normal_X;
[V,D]=eig(A);
eigenvalue=diag(D);
for i=n:-1:1
    if sum(eigenvalue(i:n))/ sum(eigenvalue)>= 1-rerr
        break;
    end
end
m=n-i+1;

for i=1:m
    pcs(:,i)=V(:,n-i+1);
end
cprs_data=pcs'*normal_X';
cprs_c(1,:)=avr_X;
cprs_c(2,:)=sigma_X;

end

