function ebrhs2 = ebrhs2Fcn(alpha, Global, Cgas_b, Cgas_e, Tb, Te, ub, db)
% -------------------------------------------------------------------------
  % ebrhs2 function 
  % ----------------------------| input |----------------------------------
  %   alpha = fraction of bubbles in bed                                 []
  %  Global = constant values structure 
  %  Cgas_b = concentration vector of each species (bubble)       [mol/cm3]
  %  Cgas_e = concentration vector of each species (emulsion)     [mol/cm3]
  %      Tb = bubble temperature                                        [K]
  %      Te = emulsion temperature                                      [K]
  %      ub = bubble velocity                                        [cm/s]
  %      db = bubble diameter                                          [cm]
  % -----
  %      fw = fraction of wake in bubbles                                []
  %     Emf = minimum fluidization porosity                              []
  %     gen = gas species number                                         []
  %     Hbe = heat exchange coefficient between bubble-emulsion [J/cm3 s K]        
  % ----------------------------| output |---------------------------------
  %  ebrhs2 = right-hand side term-2                              [J/s cm3]
% -------------------------------------------------------------------------

    fw  = Global.fw;
    Emf = Global.Emf;
    gen = Global.gen;

    Hbe = heatExchangeCoefBEFcn(Global, Cgas_b(:,1:gen), ...
                                Cgas_e(:,1:gen), Tb, Te, ub, db);

    ebrhs2 = (alpha + alpha.*fw.*Emf).*Hbe.*(Te - Tb);
% -------------------------------------------------------------------------
end
