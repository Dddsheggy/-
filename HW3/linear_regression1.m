function linear_regression1(data,alpha)

N = size(data,1);

% ����ԭʼ����
figure(1),
plot(data(:,2),data(:,1),'g*');
grid on,
hold on,

% �õ��ع�ֱ�߷���
% ����ƽ��ֵ
mean_x = mean(data(:,2));
mean_y = mean(data(:,1));

% ����Lxy,Lxx,Lyy
Lxy = sum((data(:,1)-mean_y) .* (data(:,2)-mean_x));
Lxx = sum((data(:,2)-mean_x).^2);

% ����a,b
b = Lxy/Lxx;
a = mean_y - b * mean_x;

% F����
% ����ESS��RSS
est_y = a + b * data(:,2);
ESS = sum((est_y - mean_y).^2);
RSS = sum((data(:,1) - est_y).^2);

% ����F��Fa
F = (N - 2) * ESS / RSS;
Fa = finv(1-alpha,1,N-2);

% �ж��Ƿ����ԭ����
% ������
if F <= Fa
    fprintf("��ԭ���裬��Ϊx��y���������Թ�ϵ");
% ����
else
    % ��ӡ�ع�ֱ��
    x1 = min(data(:,2)) - 0.05 * (max(data(:,2))- min(data(:,2)));
    x2 = max(data(:,2)) + 0.05 * (max(data(:,2)) - min(data(:,2)));
    x = x1 : 0.001 : x2;
    y = a + b * x;
    plot(x,y,'r','LineWidth',2),
    hold on,
    
    % ��ȡ��������
    % ��S��Z
    S = sqrt(RSS/(N-2));
    Z = norminv(1-alpha/2,0,1);
    
    % �������������½�
    y1 = a + b * x - Z * S;
    y2 = a + b * x + Z * S;
    plot(x,y1,'b--'),hold on,
    plot(x,y2,'b--'),hold on,
    
    % ��ӡ����
    if b>=0
        L1 = sprintf('�ع�ֱ�߷��̣�y=%f+%fx',a,b);
        L2 = sprintf('�������䣺y=%f+%fx��%f',a,b,Z*S);
    else
        L1 = sprintf('�ع�ֱ�߷��̣�y=%f%fx',a,b);
        L2 = sprintf('�������䣺y=%f%fx��%f',a,b,Z*S);
    end
    legend('ԭʼ����',L1,L2);
    title(sprintf('һԪ���Իع����ߣ�������ˮƽ��=%.3f��',alpha));
end

end

