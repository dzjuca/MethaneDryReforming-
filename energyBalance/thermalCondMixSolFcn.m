function thermalCondMixSol = thermalCondMixSolFcn(Global, T)

    tcAluminaFit = Global.tcAluminaFit;
    tcCeriaFit   = Global.tcCeriaFit;
    tcNickelFit  = Global.tcNickelFit;

    tcAlumina = tcAluminaFit(T);
    tcCeria   = tcCeriaFit(T);
    tcNickel  = tcNickelFit(T);

    cAl2O3   = Global.cAl2O3;
    cNickel  = Global.cNickel;
    cCeria   = Global.cCeria;

    mMolarAl2O3  = Global.mMolarAl2O3;
    mMolarNickel = Global.mMolarNickel;
    mMolarCeria  = Global.mMolarCeria;







thermalCondMixSol = 0;
end