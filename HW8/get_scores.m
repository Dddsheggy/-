function scores = get_scores(WA,WB,WC1,WC2,WC3,WC4,WC5)
% 获取各个方案的分数
% 利用各判断矩阵对应的相对权重进行计算
% 返回各分数值

W=[(WA(1:2))' WA(3)*WB'];
for i=1:4
    scores(i)=W*[WC1(i) WC2(i) WC3(i) WC4(i) WC5(i)]';
end

end

