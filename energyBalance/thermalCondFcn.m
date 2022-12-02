function kgi = thermalCondFcn(T, Tb, Tc, Pc, Vc, mu, M, Hcc, R, k)
% -------------------------------------------------------------------------
    % thermalCondFcn-function calculates the thermal conductivity of 
    % unique gas specie
    % ----------------------------| input |--------------------------------
    % T   = bubble|emulsion temperature                                 [K]
    % Tb  = temperature experimental was used to determine Tc and Pc,   [k]
    % Tc  = temperature, critical constant for each specie              [k]
    % Pc  = pressure, critical constant for each specie               [bar]
    % Vc  = volume, critical constant for each specie             [cm3/mol]
    % mu  = dipole moment                                          [debyes]
    % M   = molecular weight                                        [g/mol]
    % Hcc = vector with heat capacity constants                          []
    % R   = Universal Gas Constant                                 [J/molK]
    % k   = factor correction, k = 0                                     []
    % -----
    % Cp  = heat capacity (volume = constant)                     [J/mol K]
    % Cv  = heat capacity (pressure = constant)                   [J/mol K]
    % ----------------------------| output |-------------------------------
    % kgi = thermal conductivity of pure gas species               [W/cm K]
% -------------------------------------------------------------------------

    [~, n] = size(Tc);
    kgi    = zeros(1,n);

    for i = 1:n

        Tbr = Tb(i)/Tc(i);
        Tao = (1 - Tbr);
        Tr  = T/Tc(i);
        a   = Hcc(i,:);
        Cp  = cpGasFcn(T, R, a);
        Cv  = Cp - R;
% -------------------------------------------------------------------------
        f0 = (- 5.97616*(Tao) + 1.29874*(Tao)^(1.5) ...
              - 0.60394*(Tao)^(2.5) - 1.06841*(Tao)^(5))/Tbr;
    
        f1 = (- 5.03365*(Tao) + 1.11505*(Tao)^(1.5) ...
              - 5.41217*(Tao)^(2.5) - 7.46628*(Tao)^(5))/Tbr;
    
        omega = - (log(Pc(i)/1.01325) + f0)/(f1);
% -------------------------------------------------------------------------
        A = 1.16145; B = 0.14874; C = 0.52487; 
        D = 0.77320; E = 2.16178; F = 2.43787;

             Ta = 1.2593*Tr;
        omega_v = (A*(Ta)^(-B)) + (C*(exp(-D*Ta))) + (E*(exp(-F*Ta)));
% -------------------------------------------------------------------------
        mu_r = 131.3*(mu(i)/((Vc(i)*Tc(i))^(0.5)));
        Fc   = 1 - 0.2756*omega + 0.059035*(mu_r^4) + k;
% -------------------------------------------------------------------------
        eta  = (40.785*(Fc*(M(i)*T)^(1/2))/((Vc(i)^(2/3))*omega_v))*1e-6;
% -------------------------------------------------------------------------
        kgi(1,i) = ((1.15*Cv + R*2.03)*eta/(M(i))); 
    end  
% -------------------------------------------------------------------------
end