clc;
clear;
close all;

% Example - Get the thermal conductivity for mix Benzene & Argon
Tb_benzene = 353.24;
Tc_benzene = 562.05;
Pc_benzene = 48.95;
dipole_benzene = 0.0;
Vc_benzene = 256;
M_benzene = 78.114;
Cp_const_b = [3.551 -6.184e-3 14.365e-5 -19.807e-8 8.234e-11];


Tb_argon = 87.270;
Tc_argon = 150.86;
Pc_argon = 48.98;
dipole_argon = 0.0;
Vc_argon = 74.57;
M_argon = 39.948;
Cp_const_a = [2.5 0 0 0 0];

T          = 100.6 + 273.15;
Tc_v = [Tc_benzene Tc_argon];
Pc_v = [Pc_benzene Pc_argon];
M_v  = [M_benzene M_argon];
Y_v = [0.25 0.75];

% -------------------------------------------------------------------------

[lambda_b] = lamPureGasFcn(T, Tb_benzene, Tc_benzene, Pc_benzene, ...
                        Vc_benzene, dipole_benzene, M_benzene, Cp_const_b);
[lambda_a] = lamPureGasFcn(T, Tb_argon,   Tc_argon,   Pc_argon, ...
                        Vc_argon, dipole_argon, M_argon, Cp_const_a);
lambda_v = [lambda_b lambda_a];
% -------------------------------------------------------------------------
[lambdaMix] = lamMixGasFcn(T, Pc_v,Tc_v,  M_v, lambda_v, Y_v);