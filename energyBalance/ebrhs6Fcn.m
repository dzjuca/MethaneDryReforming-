function ebrhs6 = ebrhs6Fcn(alpha, Global, T)
% -------------------------------------------------------------------------
    % ebrhs6Fcn function 
    % ----------------------------| input |--------------------------------
    %   alpha = fraction of bubbles in bed                               []
    %  Global = constant values structure 
    %       T = phase temperature                                       [K]
    % -----
    %       Hd = dense phase height                                    [cm]
    %    Twall = Wall temperature                                       [K]
    %        U = overall heat transfer coeficient                     [xxx]
    % ----------------------------| output |-------------------------------
    %   ebrhs6 = right-hand side term-6 - emulsion phase          [J/s cm3]
% -------------------------------------------------------------------------

    Hd     = Global.zl;
    Twall  = Global.Twall;
    U      = overallHTCFcn();

    ebrhs6 = U.*(Twall - T)./Hd;
% -------------------------------------------------------------------------
end