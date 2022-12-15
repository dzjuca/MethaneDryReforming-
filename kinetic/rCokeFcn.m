function rCoke = rCokeFcn( Cc, PCH4, PCO2, PCO, PH2, Global )

    % -------------------- MODELO DE FORMACI�N DE COQUE ---------------------


    KD1   = Global.KD1;
    KD2   = Global.KD2;
    KR1   = Global.KR1;
    KAD1  = Global.KAD1;
    KAD2  = Global.KAD2;
    KAD3  = Global.KAD3;
    CcMax = Global.CcMax;

    FId   = (KD1*KAD1*PCH4^2 + KD2*KAD2*PCO^2*PH2^2)/((1 + KAD3*PCO2)^2);    
    FIr   = (KR1*KAD3*PCO2)/(1+KAD3*PCO2); 

    Factor1 = (Cc/CcMax);
    if Factor1 > 1, Factor1 = 1; end
    Factor2 = 2*(CcMax-Cc);
    Factor3 = CcMax^2/Factor2;
    if Factor2 == 0, Factor3 = 0; end
    rCoke = Factor3*(FId*(1-Factor1)^3-FIr*(1-Factor1)+FIr*(1-Factor1)^2);
    if Cc > CcMax, rCoke = 0; end

end