function r3 = r3MCFcn( PCH4, PH2, Global ) 


    % -------------------- MODELO CRACKING METANO -----------------------------
        % -------------------- MODELO CRACKING METANO -----------------------------

    k3      = Global.k3;
    KH2     = Global.KH2;
    KCH4    = Global.KCH4;
    KP3     = Global.KP3;
    factor1 = KP3*PCH4;
    factor2 = PH2^2/factor1;
    if factor1 == 0, factor2 = 0; end
    factor3     = KH2^(-1.5);
    factor4     = (PH2^(1.5))/factor3;
    if factor3 == 0, factor4 = 0; end
    if ~isreal(factor4), factor4 = 0; end
    r3          = ((k3*KCH4*PCH4)/(1+KCH4*PCH4+factor4)^2)*(1-factor2);

end