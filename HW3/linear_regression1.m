function linear_regression1(data,alpha)

N = size(data,1);

% 作出原始数据
figure(1),
plot(data(:,2),data(:,1),'g*');
grid on,
hold on,

% 得到回归直线方程
% 计算平均值
mean_x = mean(data(:,2));
mean_y = mean(data(:,1));

% 计算Lxy,Lxx,Lyy
Lxy = sum((data(:,1)-mean_y) .* (data(:,2)-mean_x));
Lxx = sum((data(:,2)-mean_x).^2);

% 计算a,b
b = Lxy/Lxx;
a = mean_y - b * mean_x;

% F检验
% 计算ESS和RSS
est_y = a + b * data(:,2);
ESS = sum((est_y - mean_y).^2);
RSS = sum((data(:,1) - est_y).^2);

% 计算F和Fa
F = (N - 2) * ESS / RSS;
Fa = finv(1-alpha,1,N-2);

% 判断是否接受原假设
% 不符合
if F <= Fa
    fprintf("否定原假设，认为x与y不存在线性关系");
% 符合
else
    % 打印回归直线
    x1 = min(data(:,2)) - 0.05 * (max(data(:,2))- min(data(:,2)));
    x2 = max(data(:,2)) + 0.05 * (max(data(:,2)) - min(data(:,2)));
    x = x1 : 0.001 : x2;
    y = a + b * x;
    plot(x,y,'r','LineWidth',2),
    hold on,
    
    % 求取置信区间
    % 求S和Z
    S = sqrt(RSS/(N-2));
    Z = norminv(1-alpha/2,0,1);
    
    % 求置信区间上下界
    y1 = a + b * x - Z * S;
    y2 = a + b * x + Z * S;
    plot(x,y1,'b--'),hold on,
    plot(x,y2,'b--'),hold on,
    
    % 打印方程
    if b>=0
        L1 = sprintf('回归直线方程：y=%f+%fx',a,b);
        L2 = sprintf('置信区间：y=%f+%fx±%f',a,b,Z*S);
    else
        L1 = sprintf('回归直线方程：y=%f%fx',a,b);
        L2 = sprintf('置信区间：y=%f%fx±%f',a,b,Z*S);
    end
    legend('原始数据',L1,L2);
    title(sprintf('一元线性回归曲线（显著性水平α=%.3f）',alpha));
end

end

