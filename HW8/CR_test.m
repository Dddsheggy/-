function CR = CR_test(A)
% һ���Լ���
% ������������A
% �ж��Ƿ����һ����
% ���ؾ���A�ļ����CR

RI=[0 0 0.58 0.90 1.12 1.24 1.32 1.41 1.25];
max_lumda=max(eig(A));
CI=(max_lumda-size(A,1))/(size(A,1)-1);
CR=CI/RI(size(A,1));
if CR>=0.1
    fprintf('�þ��󲻾���һ���ԣ������¹���\n');
end
end

