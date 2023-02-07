function ebrhs6 = ebrhs6Fcn(alpha, Global, T, Cgas, db)
% -------------------------------------------------------------------------
    % ebrhs6Fcn function calculates the right-hand side term-6 - emulsion
    % phase 
    % ----------------------------| input |--------------------------------
    %    alpha = fraction of bubbles in bed                              []
    %   Global = constant values structure 
    %        T = phase temperature                                      [K]
    %     Cgas = phase matrix concentration of each species       [mol/cm3]
    %       db = bubble diameter                                       [cm]
    % -----
    %      gen = gas species number                                      []
    %       Hd = dense phase height                                    [cm]
    %    Twall = Wall temperature                                       [K]
    %        U = overall heat transfer coeficient                     [xxx]
    % ----------------------------| output |-------------------------------
    %   ebrhs6 = right-hand side term-6 - emulsion phase          [J/s cm3]
% -------------------------------------------------------------------------

    gen     = Global.gen;
    Hd      = Global.zl;
    Twall   = Global.Twall;
    C_gas_i = Cgas(:,1:gen);

          U = (overallHTCFcn(alpha, Global, T, C_gas_i, db)).*1;

    ebrhs6  = U.*(Twall - T)./Hd;
% -------------------------------------------------------------------------
end