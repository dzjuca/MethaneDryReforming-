function ebrhs2 = ebrhs2Fcn(alpha, Global, Cgas_b, Cgas_e, Tb, Te, ub, db)
% -------------------------------------------------------------------------
  % ebrhs2 function 
  % ----------------------------| input |----------------------------------
  %   alpha = fraction of bubbles in bed                                 []
  %  Global = constant values structure 
  %    Cgas = concentration vector of each species                [mol/cm3]
  %      Tb = bubble temperature                                        [K]
  %      Te = emulsion temperature                                      [K]
  %      ub = bubble velocity                                        [cm/s]
  %      db = bubble diameter                                          [cm]
  %      fw = fraction of wake in bubbles                                []
  %     Emf = minimum fluidization porosity                              []
  %     nge = gas species number                                         []
  %     y_i = molar fraction of each species                             []  
  %     Hbe = heat exchange coefficient between bubble-emulsion [J/cm3 s K]        
  % ----------------------------| output |---------------------------------
  %  ebrhs2 = right-hand side term-2                              [J/cm3 s]
% -------------------------------------------------------------------------

    fw  = Global.fw;
    Emf = Global.Emf;
    nge = Global.nge;
    y_i = molarFractionFcn(Cgas_b(:,1:nge));
    Hbe = heatExchangeCoefBEFcn(Global, Cgas_b(:,1:nge), ...
                                Cgas_e(:,1:nge), Tb, Te, ub, db);

    temporal_1 = (alpha + alpha.*fw.*Emf);
    temporal_2 = y_i.*Hbe.*(Te - Tb);

    ebrhs2 = temporal_1.*(sum(temporal_2,2));
% -------------------------------------------------------------------------
end
