clc
close all;
clear all;

% 数据
X=xlsread('counties.xlsx','C2:P3115');
Y=xlsread('counties.xlsx','Q2:Q3115');
alpha=0.05;

% 病态线性回归
fprintf('病态线性回归（显著性水平α=0.05）：\n');
linear_regression(Y,X,alpha);

% 主成分分析
fprintf('主成分分析（显著性水平α=0.05）：\n');
[pcs,cprs_data,cprs_c] = pca_compress(X',0.05);
recon_data = pca_reconstruct(pcs,cprs_data,cprs_c);
[final_X_new,const] = print_line(X,Y,pcs,cprs_c,cprs_data,alpha);
