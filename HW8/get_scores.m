function scores = get_scores(WA,WB,WC1,WC2,WC3,WC4,WC5)
% ��ȡ���������ķ���
% ���ø��жϾ����Ӧ�����Ȩ�ؽ��м���
% ���ظ�����ֵ

W=[(WA(1:2))' WA(3)*WB'];
for i=1:4
    scores(i)=W*[WC1(i) WC2(i) WC3(i) WC4(i) WC5(i)]';
end

end

