function hgc = hgcFcn(Global, T, Cgas, db)
% -------------------------------------------------------------------------
    % hgc-function calculates the gas convective heat transfer coefficient
    % ----------------------------| input |--------------------------------
    %     Global = constant values structure 
    %          T = phase temperature                                    [K]
    %       Cgas = phase matrix concentration of each species     [mol/cm3]
    %         db = bubble diameter                                     [cm]
    % -----
    %         dp = particle diameter                                   [cm]
    %         Ar = the arquimedes number                                 []
    %         kg = thermal conductivity for a gas mixture         [W/ cm K]
    % ----------------------------| output |-------------------------------
    %        hgc = the gas convective heat transfer coefficient   [W/cm2 K]
% -------------------------------------------------------------------------

    dp    = Global.dparticle;
    Ar    = arquimedesFcn(Global, T, Cgas);
    kg    = thermalCondMixGasFcn(Global, T, Cgas); 
    tmp_1 = 0.3.*((Ar).^(0.39)).*kg;
    tmp_2 = (dp.*db)^(1/2);

    hgc   = tmp_1./tmp_2;
% -------------------------------------------------------------------------
end