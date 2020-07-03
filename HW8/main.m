clc
clear
close all

%% 各判断矩阵
A=[1 2 7;1/2 1 5;1/7 1/5 1];
B=[1 1/3 2;3 1 5;1/2 1/5 1];
C1=[1 1/6 1/3 1/4;6 1 5 5;3 1/5 1 2;4 1/5 1/2 1];
C2=[1 2 6 4;1/2 1 6 4;1/6 1/6 1 1/3;1/4 1/4 3 1];
C3=[1 2 6 4;1/2 1 6 4;1/6 1/6 1 1/3;1/4 1/4 3 1];
C4=[1 5 3 5;1/5 1 2 2;1/3 1/2 1 1/2;1/5 1/2 2 1];
C5=[1 1/5 1/3 1;5 1 3 5;3 1/3 1 3;1 1/5 1/3 1];

%% 一致性检验
CR(1)=CR_test(A);
CR(2)=CR_test(B);
CR(3)=CR_test(C1);
CR(4)=CR_test(C2);
CR(5)=CR_test(C3);
CR(6)=CR_test(C4);
CR(7)=CR_test(C5);

%% 获取相对权重
WA=get_weights(A);
WB=get_weights(B);
WC1=get_weights(C1);
WC2=get_weights(C2);
WC3=get_weights(C3);
WC4=get_weights(C4);
WC5=get_weights(C5);

%% 获取各方案分数值
scores=get_scores(WA,WB,WC1,WC2,WC3,WC4,WC5);