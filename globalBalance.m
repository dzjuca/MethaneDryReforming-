% -------------------------------------------------------------------------
% ------------------------ FLUIDIZED BED REACTOR --------------------------
%                      DRY REFORMING OF METHANE (DRM)
%                         GLOBAL BALANCE SOLUTION
%     Author: Daniel Z. Juca
% ------------------------ | initiation | ---------------------------------
  close all
  clear all
  clc
% ---------- global constants ---------------------------------------------
     Global = globalData();
        NoN = (1:Global.n*Global.Num_esp);
% ---------- initial condition --------------------------------------------
         u0 = initialConditions(Global);
% ---------- time simulation (s) ------------------------------------------
    t0 = 0.0; 
    tf = 1800; 
  tout = linspace(t0,tf,100)';
% ---------- Implicit (sparse stiff) integration --------------------------
   reltol = 1.0e-6; abstol = 1.0e-6;  
  options = odeset('RelTol',reltol,'AbsTol',abstol,'NonNegative',NoN);
        S = JPatternFcn(Global);
  options = odeset(options,'JPattern',S); 
 pdeModel = @(t,u)pdeFcn(t,u,Global);
    [t,u] = ode15s(pdeModel,tout,u0,options);  
% -----
[CiBW,CiE] = SkinFcnMac(t,u,Global);
% ----
skinTemperatureFcn(t, u, Global)
% ---------------------------| End Program |-------------------------------