function hpc = hpcFcn(alpha, Global, T, Cgas, db)
% -------------------------------------------------------------------------
    % hpc-function calculates the particle convective HTC
    % ----------------------------| input |--------------------------------
    %      alpha = fraction of bubbles in bed                            []
    %     Global = constant values structure 
    %          T = phase temperature                                    [K]
    %       Cgas = phase matrix concentration of each species     [mol/cm3]
    %         db = bubble diameter                                     [cm]
    % -----
    %           E = constant near unity, for design purposes = 0.4       []
    %           m = constant, for design purposes m = 6                  [] 
    %         umf = minimum fluidization velocity                    [cm/s] 
    %          dp = particle diameter                                  [cm]
    %       Dsol = solid density                                    [g/cm3]
    %        Emf = minimum fluidization porosity                         []
    %          u = initial flow rate                                 [cm/s]
    % C_gas_mix  = gas mixing concentration                       [mol/cm3]
    % Cp_gas_mix = gas mixing heat capacity                       [J/mol K]
    % Cp_sol_mix = solid mixing heat capacity                   [J/g-cat K]
    %         kg = thermal conductivity for a gas mixture         [W/ cm K]
    %         ks = thermal conductivity for a solid mixture       [W/ cm K]
    % ----------------------------| output |-------------------------------
    %        hpc = the particle heat transfer coefficient         [W/cm2 K]
% -------------------------------------------------------------------------
    E          = Global.OHTC.E;
    m          = Global.OHTC.m;
    umf        = Global.umf;
    dp         = Global.dparticle; 
    Dsol       = Global.Dcat;
    Emf        = Global.Emf;
    u          = Global.usg0;
% -------------------------------------------------------------------------
    C_gas_mix  = cGasMixFcn(Cgas);
    Cp_gas_mix = cpGasMixFcn(Global, Cgas, T);
    Cp_sol_mix = cpSolMixFcn(Global, T);
    kg = thermalCondMixGasFcn(Global, T, Cgas);
    ks = thermalCondMixSolFcn(Global, T);                                
% -------------------------------------------------------------------------
    ks_kg = ks./kg;
    tmp_1 = 0.28 - 0.757.*log10(E) - 0.057.*log10(ks_kg);
    keo = kg.*(ks_kg).^(tmp_1);
    kmf = keo + 0.1.*C_gas_mix.*Cp_gas_mix.*dp.*umf;
    tmp_2 = Dsol.*(1 - Emf).*Cp_sol_mix;
    tmp_3 = kmf.*tmp_2.*(u - umf)./(pi.*db);
    h1 = 2.*(tmp_3).^(1/2);
% -------------------------------------------------------------------------
    h2 = m.*kg./dp;
% -------------------------------------------------------------------------

    hpc = (1 - alpha)./((1./h1)+(1./h2));

% -------------------------------------------------------------------------
end

