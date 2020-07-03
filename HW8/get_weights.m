function weights = get_weights(A)
% ��ȡ���Ȩ��
% �������A���������ֵ�����Ӧ����������
% ��һ����������
% �������Ȩ��weights

[x, lumda]=eig(A);
r=abs(sum(lumda));
n=find(r==max(r));
max_lumda=lumda(n,n);
max_x=x(:,n);
sum_x=sum(max_x);
weights=max_x./sum_x;
end

