function mui = viscosityGasFcn( T, Tb, Tc, Pc, Vc, mu, M, k)
% -------------------------------------------------------------------------
    % viscosityGasFcn-function calculates the viscosity of unique gas
    % specie
    % ----------------------------| input |--------------------------------
    % T   = bubble|emulsion temperature                                 [K]
    % Tb  = temperature experimental was used to determine Tc and Pc,   [k]
    % Tc  = temperature, critical constant for each specie              [k]
    % Pc  = pressure, critical constant for each specie               [bar]
    % Vc  = volume, critical constant for each specie             [cm3/mol]
    % mu  = dipole moment                                          [debyes]
    % M   = molecular weight                                        [g/mol]
    % k   = factor correction, k = 0                                     []
    % ----------------------------| output |-------------------------------
    % mui = viscosity of pure gas species                           [xxxxx]  % ==================> revisar valor
% -------------------------------------------------------------------------
    Tbr = Tb/Tc;
    Tao = (1 - Tbr);
    Tr  = T./Tc;                                      % ==================> revisar valor
% -------------------------------------------------------------------------
    f0 = (- 5.97616*(Tao) + 1.29874*(Tao)^(1.5) ...
          - 0.60394*(Tao)^(2.5) - 1.06841*(Tao)^(5))/Tbr;

    f1 = (- 5.03365*(Tao) + 1.11505*(Tao)^(1.5) ...
          - 5.41217*(Tao)^(2.5) - 7.46628*(Tao)^(5))/Tbr;

    omega = - (log(Pc/1.01325) + f0)/(f1);
% -------------------------------------------------------------------------
    A = 1.16145; B = 0.14874; C = 0.52487; 
    D = 0.77320; E = 2.16178; F = 2.43787;

         Ta = 1.2593.*Tr;
    omega_v = (A.*(Ta).^(-B)) + (C.*(exp(-D.*Ta))) + (E.*(exp(-F.*Ta)));
% -------------------------------------------------------------------------
    mu_r = 131.3*(mu/((Vc*Tc)^(0.5)));
    Fc   = 1 - 0.2756*omega + 0.059035*(mu_r^4) + k;
% -------------------------------------------------------------------------
    mui  = (40.785.*(Fc.*(M.*T).^(1/2))./((Vc^(2/3)).*omega_v)).*1e-6;
% -------------------------------------------------------------------------
end
