function arquimedes = arquimedesFcn(Global, T, Cgas)
% -------------------------------------------------------------------------
    % arquimedes-function calculates the arquimedes number
    % ----------------------------| input |--------------------------------
    %     Global = constant values structure 
    %          T = phase temperature                                    [K]
    %       Cgas = concentration vector of each species 
    %                                   (bubble|emulsion)         [mol/cm3]
    % -----
    %          g = gravity                                          [cm/s2]
    %         dp = particle diameter                                   [cm]
    %       Dsol = solid density                                    [g/cm3]
    %  D_gas_mix = gas mixing density                               [g/cm3]
    % mu_gas_mix = gas mixing viscosity                            [g/cm s] 
    % ----------------------------| output |-------------------------------
    % arquimedes = the arquimedes number                                 []  
% -------------------------------------------------------------------------

    g          = Global.g; 
    dp         = Global.dparticle;
    Dsol       = Global.Dcat;
    MM         = Global.MM;
% ---------------------------------------------------------------------
    C_gas_mix  = cGasMixFcn(Cgas);                                     % ==================> queda solo para sacar comparaciones
% ---------------------------------------------------------------------
 
    D_gas_mix  = densityGasMixFcn(Cgas, MM);
    mu_gas_mix = viscosityGasMixFcn(Global, T, Cgas );

    tmp_1 = g.*(dp^3).*(Dsol - D_gas_mix).*D_gas_mix;
    tmp_2 = mu_gas_mix.^2;

    arquimedes = (tmp_1./tmp_2);
% ------------------------------------------------------------------------- 
end