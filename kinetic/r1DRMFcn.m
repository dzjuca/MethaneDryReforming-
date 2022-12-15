function r1 = r1DRMFcn( PCH4, PCO2, PCO, PH2, Global )

    % -------------------- MODELO DRM -----------------------------------------

    k1      = Global.k1;
    KCH4    = Global.KCH4;
    KCO2    = Global.KCO2;
    KP1     = Global.KP1;
    factor1 = PCH4*PCO2*KP1;
    factor2 = PCO^2*PH2^2/factor1;  

    if factor1 == 0, factor2 = 0; end
    factor3     = (1 + KCH4*PCH4 + KCO2*PCO2)^2;
    r1          = (k1*KCH4*KCO2*PCH4*PCO2/factor3)*(1-factor2);

end