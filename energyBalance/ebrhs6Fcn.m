function ebrhs6 = ebrhs6Fcn(alpha, Global, Te)
% -------------------------------------------------------------------------
    % ebrhs6Fcn function 
    % ----------------------------| input |--------------------------------
    %   alpha = fraction of bubbles in bed                               []
    %  Global = constant values structure 
    %      Te = emulsion temperature                                    [K]

    %      ub = bubble velocity                                      [cm/s]
    % -----
    %       Hd = dense phase height                                    [cm]
    %    Twall = Wall temperature                                       [K]
    %       fw = fraction of wake in bubbles                             []
    %      Emf = minimum fluidization porosity                           []
    %     Dsol = solid density                                      [g/cm3]
    %       zg = height for each mesh point                            [cm]
    %       zl = lower boundary value of T                               []
    %       zu = upper boundary value of T                               []
    %        n = number of grid points in the z domain including the
    %            boundary points                                         []
    %    Cps_b = solid mixing heat capacity | bubble            [J/g-cat K]
    %    Cps_e = solid mixing heat capacity | emulsion          [J/g-cat K]
    % ----------------------------| output |-------------------------------
    %  ebrhs6 = right-hand side term-6 - emulsion phase           [J/s cm3]
% -------------------------------------------------------------------------
    Hd     = Global.zl;
    U      = overallHTCFcn();
    Twall  = Global.Twall;

    ebrhs6 = U.*(Twall - Te)./Hd;
% -------------------------------------------------------------------------
end