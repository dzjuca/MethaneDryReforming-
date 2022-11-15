function u = inicial()
% Función que permite determinar las condiciones iniciales para cada
% variable dependiente del modelo.
% ----------------------------| ENTRADAS |---------------------------------
%      C(i)in = Concentración de entrada de las especies               i
%          zg = altura para cada punto del mallado                    [cm]
%     Num_esp = número de especies                                     [#]
% ----------------------------| SALIDAS |----------------------------------
%       u = vector con los valores iniciales de cada variable dependiente
%   ncall = valor inicial de llamadas a la función pdeDRM
% -------------------------------------------------------------------------
global ncall zg Num_esp CH4in CO2in N2in
    n = length(zg);
    u = zeros((Num_esp*n),1);
% ---------- Inicio - Especies - Fase Gas - Burbuja & Estela --------------
  u1b = zeros(n,1); u2b = zeros(n,1); 
  u3b = zeros(n,1); u4b = zeros(n,1);
  u5b = zeros(n,1); u6b = zeros(n,1);
% ---------- Inicio - Especies - Fase Gas - Emulsión ----------------------
  u1e = zeros(n,1); u2e = zeros(n,1); 
  u3e = zeros(n,1); u4e = zeros(n,1);
  u5e = zeros(n,1); u6e = zeros(n,1);  
% ---------- Inicio - Especies - Fase Sólido - Estela ---------------------
  u7w = zeros(n,1); 
% ---------- Inicio - Especies - Fase Sólido - Emulsión -------------------
  u7e = zeros(n,1); 
% ----------------------------| FASE GAS |---------------------------------
% ---------- u1b = CH4 burbuja --------------------------------------------
    for i = 1:n, u1b(i) = 2e-6;    u(i+0*n) = u1b(i);     end
% ---------- u2b = CO2 burbuja --------------------------------------------
    for i = 1:n, u2b(i) = 2e-6;    u(i+1*n) = u2b(i);     end
% ---------- u3b = CO burbuja --------------------------------------------- 
    for i = 1:n, u3b(i) = 0.000;   u(i+2*n) = u3b(i);     end
% ---------- u4b = H2 burbuja ---------------------------------------------
    for i = 1:n, u4b(i) = 0.000;   u(i+3*n) = u4b(i);     end
% ---------- u5b = H2O burbuja --------------------------------------------
    for i = 1:n, u5b(i) = 0.000;   u(i+4*n) = u5b(i);     end
% ---------- u6b = N2 burbuja ---------------------------------------------
    for i = 1:n, u6b(i) = 1e-7;    u(i+5*n) = u6b(i);     end
% ---------- u1e = CH4 emulsión -------------------------------------------
    for i = 1:n, u1e(i) = 2e-6;    u(i+6*n) = u1e(i);     end
% ---------- u2e = CO2 emulsión -------------------------------------------
    for i = 1:n, u2e(i) = 2e-6;    u(i+7*n) = u2e(i);     end
% ---------- u3e = CO emulsión --------------------------------------------
    for i = 1:n, u3e(i) = 0.000;   u(i+8*n) = u3e(i);     end
% ---------- u4e = H2 emulsión --------------------------------------------
    for i = 1:n, u4e(i) = 0.000;   u(i+9*n) = u4e(i);     end
% ---------- u5e = H2O emulsión -------------------------------------------
    for i = 1:n, u5e(i) = 0.000;   u(i+10*n) = u5e(i);    end
% ---------- u6e = N2 emulsión --------------------------------------------
    for i = 1:n, u6e(i) = 1e-7;    u(i+11*n) = u6e(i);    end
% ---------- u7w = Coque Estela -------------------------------------------
    for i = 1:n, u7w(i) = 1e-7;    u(i+12*n) = u7w(i);    end
% ---------- u6e = Coque Emulsión -----------------------------------------
    for i = 1:n, u7e(i) = 1e-7;    u(i+13*n) = u7e(i);    end
% ---------- Número de llamadas a la función pdeDRM -----------------------
    ncall = 0;
end