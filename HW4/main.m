clc
close all;
clear all;

% Êý¾Ý
X=xlsread('counties.xlsx','C2:P3115');
Y=xlsread('counties.xlsx','Q2:Q3115')
alpha=0.05;

linear_regression(Y,X,alpha);