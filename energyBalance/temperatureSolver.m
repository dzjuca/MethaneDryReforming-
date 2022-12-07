clc
clear 
close all

Global = globalData();
T0     = 800;
constant = 58.291773769832010;

R = Global.R*1000;
a = Global.HCC.CH4;

cpInicial = cpGasFcn(T0, R, a);

funTemp = @(T)opTemperatureFcn(T, Global);

T2 = fzero(funTemp, T0);