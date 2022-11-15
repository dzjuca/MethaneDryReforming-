% -------------------------------------------------------------------------
% ------------------------ FLUIDIZED BED REACTOR --------------------------
%                      DRY REFORMING OF METHANE (DRM)
%                         ENERGY BALANCE SOLUTION
%     Author: Daniel Z. Juca
% ------------------------ | initiation | ---------------------------------
  close all
  clear
  clc
% ---------- Constantes de tipo global ------------------------------------
  g = globalData();
  NoN = (1:g.n*g.Num_esp);
% ---------- initial condition --------------------------------------------
    u0 = inicial;
% ---------- time simulation (s) ------------------------------------------
    t0 = 0.0; 
    tf = 3600*1000; 
  tout = linspace(t0,tf,100)';
% ---------- Implicit (sparse stiff) integration --------------------------
   reltol = 1.0e-6; abstol = 1.0e-6;  
  options = odeset('RelTol',reltol,'AbsTol',abstol,'NonNegative',NoN);
        S = JPatternDRM;
  options = odeset(options,'JPattern',S); 
    [t,u] = ode15s(@pdeDRM,tout,u0,options);  
% ---------- Salidas ------------------------------------------------------
  [T_b,T_e,T] = SkinFcnMac(t,u);
% ---------------------------| End Program |-------------------------------