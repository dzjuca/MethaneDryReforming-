function r2 = r2RWGSFcn( PCO2, PCO, PH2, PH2O, Global )

    % -------------------- MODELO WGSR ----------------------------------------

    k2      = Global.k2;
    KP2     = Global.KP2;
    KCO2    = Global.KCO2;
    KH2     = Global.KH2;
    factor1 = KP2*PCO2*PH2;
    factor2 = PCO*PH2O/factor1;

    if factor1 == 0, factor2 = 0; end
    factor3     = (1 + KCO2*PCO2 + KH2*PH2)^2;
    r2          = (k2*KCO2*KH2*PCO2*PH2/factor3)*(1-factor2);

end