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
    %  C_gas_mix = gas mixing concentration                       [mol/cm3]
    % mu_gas_mix = gas mixing viscosity                             [xxxxx] % ==================> comprobar valor
    % ----------------------------| output |-------------------------------
    % arquimedes = the arquimedes number                                 []  % ==================> comprobar valor
% -------------------------------------------------------------------------

    g          = Global.g; 
    dp         = Global.dparticle;
    Dsol       = Global.Dcat;
    C_gas_mix  = cGasMixFcn(Cgas);
    mu_gas_mix = viscosityGasMixFcn(Global, T, Cgas );

    tmp_1 = g.*(dp^3).*(Dsol - C_gas_mix).*C_gas_mix;
    tmp_2 = mu_gas_mix.^2;


    arquimedes = (tmp_1./tmp_2);
% ------------------------------------------------------------------------- 
end