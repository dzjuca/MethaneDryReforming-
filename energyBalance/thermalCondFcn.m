function kgi = thermalCondFcn(T, Tb, Tc, Pc, Vc, mu, M, Cp_const)
% -------------------------------------------------------------------------
    % thermalCondFcn-function calculates the thermal conductivity of 
    % unique gas specie
    % ----------------------------| input |--------------------------------
    % Tc  = temperature, critical constant for each specie              [k]
    % Pc  = pressure, critical constant for each specie               [bar]
    % Tb  = temperature experimental was used to determine Tc and Pc,   [k]
    % T   = bubble|emulsion temperature                                 [K]
    % Vc  = volume, critical constant for each specie             [cm3/mol]
    % mu  = dipole moment                                          [debyes]
    % k   = factor correction, k = 0                                     []
    % M   = molecular weight                                        [g/mol]
    % M_a = molegular weight                                       [Kg/mol]
    % Cp  = heat capacity (volume = constant)                     [J/mol K]
    % Cv  = heat capacity (pressure = constant)                   [J/mol K]
    % R   = universal constant                                    [J/mol K]
    % Cp_const = vector with heat capacity constants
    % ----------------------------| output |-------------------------------
    % kgi = thermal conductivity of pure gas species              [W/ cm K] ### revisar unidades
% -------------------------------------------------------------------------

    kgi = zeros(1,6);

    for l = 1:6

        Tbr = Tb/Tc;
        Tao  = (1 - Tbr);
            Tr = T/Tc;
            k  = 0;
            R  = 8.3144626;
    
        % -------------------------------------------------------------------------
            a0 = Cp_const(1); a1 = Cp_const(2); a2 = Cp_const(3) ; a3 = Cp_const(4);
            a4 = Cp_const(5);
        Cp = (a0 + a1*T + a2*T^2 + a3*T^3 + a4*T^4)*R;
        Cv = Cp - R;
    
        % -------------------------------------------------------------------------
    
        f0 = (- 5.97616*(Tao) + 1.29874*(Tao)^(1.5) - 0.60394*(Tao)^(2.5) ... 
                - 1.06841*(Tao)^(5))/Tbr;
    
        f1 = (- 5.03365*(Tao) + 1.11505*(Tao)^(1.5) - 5.41217*(Tao)^(2.5) ...
                - 7.46628*(Tao)^(5))/Tbr;
    
        omega = - (log(Pc/1.01325) + f0)/(f1);
        % -------------------------------------------------------------------------
                A = 1.16145; B = 0.14874; C = 0.52487; 
                D = 0.77320; E = 2.16178; F = 2.43787;
    
                Ta = 1.2593*Tr;
    
        omega_v = (A*(Ta)^(-B)) + (C*(exp(-D*Ta))) + (E*(exp(-F*Ta)));
        % -------------------------------------------------------------------------
        mu_r = 131.3*(mu/((Vc*Tc)^(0.5)));
    
            Fc = 1 - 0.2756*omega + 0.059035*(mu_r^4) + k;
    
        % -------------------------------------------------------------------------
    
        eta = 40.785*(Fc*(M*T)^(1/2))/((Vc^(2/3))*omega_v)*1e-7;
    
        % -------------------------------------------------------------------------
            M_a = M/1000;
            kgi(1,l) = (1.15*Cv + R*2.03)*eta/(M_a);

        
    end   
end