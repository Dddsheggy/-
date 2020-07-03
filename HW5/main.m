clc
close all;
clear all;

% ����
X=xlsread('counties.xlsx','C2:P3115');
Y=xlsread('counties.xlsx','Q2:Q3115');
alpha=0.05;

% ��̬���Իع�
fprintf('��̬���Իع飨������ˮƽ��=0.05����\n');
linear_regression(Y,X,alpha);

% ���ɷַ���
fprintf('���ɷַ�����������ˮƽ��=0.05����\n');
[pcs,cprs_data,cprs_c] = pca_compress(X',0.05);
recon_data = pca_reconstruct(pcs,cprs_data,cprs_c);
[final_X_new,const] = print_line(X,Y,pcs,cprs_c,cprs_data,alpha);
