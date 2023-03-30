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
    %      hpc = the particle heat transfer coefficient           [W/cm2 K]
    %      hgc = the gas convective heat transfer coefficient     [W/cm2 K]
    %       hr = the radiation heat transfer coefficient          [W/cm2 K]
    % ----------------------------| output |-------------------------------
    %        U = the overall heat transfer coefficient            [W/cm2 K]
% -------------------------------------------------------------------------

    hpc = hpcFcn(alpha, Global, T, Cgas, db);
    hgc = hgcFcn(Global, T, Cgas, db);
    hr  = hrFcn(Global, T);

    U   = 1./((1./hpc)+(1./hgc)+(1./hr));

    %U   = hpc + hgc + hr;
    %disp([U(1),U(2),U(3),U(14),U(15),U(16),U(28),U(29),U(30)]);
    %U   = 0.0100;
% -------------------------------------------------------------------------
end