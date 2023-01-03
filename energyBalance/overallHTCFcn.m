function U = overallHTCFcn(alpha, Global, T, Cgas, db)
% -------------------------------------------------------------------------
    % overallHTC-function calculates the overall heat transfer coefficient
    % ----------------------------| input |--------------------------------
    %    alpha = fraction of bubbles in bed                              []
    %   Global = constant values structure 
    %        T = phase temperature                                      [K]
    %     Cgas = phase matrix concentration of each species       [mol/cm3]
    %       db = bubble diameter                                       [cm]
    % -----
    %      hpc = the particle heat transfer coefficient               [xxx]
    %      hgc = the gas convective heat transfer coefficient         [xxx]
    %       hr = the radiation heat transfer coefficient              [xxx]
    % ----------------------------| output |-------------------------------
    %        U = the overall heat transfer coefficient                [xxx] ========> revisar unidades
% -------------------------------------------------------------------------

    hpc = hpcFcn(alpha, Global, T, Cgas, db);
    hgc = hgcFcn(Global, T, Cgas, db);
    hr  = hrFcn(Global, T);

    U   = hpc + hgc + hr;
% -------------------------------------------------------------------------
end