clc 
clear 
close all

A       = [-3, 4, -5, 6, -7, -8, -9, -7, -10, 10];
index   = find(A<0);
[m, n]  = size(A);
lambda1 = zeros(m,n);
lambda2 = ones(m,n);

lambda1(index) = 1;
lambda2(index) = 0;






