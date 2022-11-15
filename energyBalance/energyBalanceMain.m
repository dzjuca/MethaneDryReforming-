% ----------------- SIMULACI�N - REACTOR LECHO FLUIDIZADO -----------------
%                      REFORMADO SECO DE METANO (DRM)
% Proyecto BioRefinEr - Laboratorio de Reactores Qu�micos - CREG - I3A 
%     Daniel Z. Juca  - Estudiante de Doctorado
%     Miguel Men�ndez - Director
%     Jaime Soler     - Co-director
% ------------------------ | INICIO RLF.m | -------------------------------
  close all
  clear;
  clc
% ---------- Constantes de tipo global ------------------------------------
  global ncall n Num_esp
           constantesFBR
  NoN = (1:n*Num_esp);
% ---------- Inicio de constantes iniciales -------------------------------
    u0 = inicial;
% ---------- tiempo de simulaci�n (s) -------------------------------------
    t0 = 0.0; 
    tf = 3600*1000; 
  tout = linspace(t0,tf,100)';
% ---------- Integraci�n Ecuaciones Diferenciales Ordianarias (ODEs) ------ 
  reltol = 1.0e-6; abstol = 1.0e-6;  
 options = odeset('RelTol',reltol,'AbsTol',abstol,'NonNegative',NoN);
% ---------- Implicit (sparse stiff) integration --------------------------
        S = JPatternDRM;
  options = odeset(options,'JPattern',S); 
    [t,u] = ode15s(@pdeDRM,tout,u0,options);  
% ---------- Salidas ------------------------------------------------------
  [CiBW,CiE] = SkinFcnMac(t,u);
   fprintf('\n ncall = %4d\n',ncall);
% ---------------------------| FIN RLF.m |---------------------------------