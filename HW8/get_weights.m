function weights = get_weights(A)
% 获取相对权重
% 计算矩阵A的最大特征值及其对应的特征向量
% 归一化特征向量
% 返回相对权重weights

[x, lumda]=eig(A);
r=abs(sum(lumda));
n=find(r==max(r));
max_lumda=lumda(n,n);
max_x=x(:,n);
sum_x=sum(max_x);
weights=max_x./sum_x;
end

