function CR = CR_test(A)
% 一致性检验
% 输入待检验矩阵A
% 判断是否具有一致性
% 返回矩阵A的检测结果CR

RI=[0 0 0.58 0.90 1.12 1.24 1.32 1.41 1.25];
max_lumda=max(eig(A));
CI=(max_lumda-size(A,1))/(size(A,1)-1);
CR=CI/RI(size(A,1));
if CR>=0.1
    fprintf('该矩阵不具有一致性，请重新构造\n');
end
end

