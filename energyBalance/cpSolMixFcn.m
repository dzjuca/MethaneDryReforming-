function cpSolMix = cpSolMixFcn(Global, T)
% -------------------------------------------------------------------------
    % cpSolMix function 
    % ----------------------------| input |--------------------------------
    %   Global = constant values structure 
    %        T = temperature                                            [K]
    %       cp = heat capacity                                    [J/mol K]
    % ----------------------------| output |-------------------------------
    % cpSolMix = solid mixing heat capacity                     [J/g-cat K]
% -------------------------------------------------------------------------
    cpAl2O3Fit  = Global.cpAl2O3Fit;
    cpNickelFit = Global.cpNickelFit;
    cpCeriaFit  = Global.cpCeriaFit;

    cpAl2O3  = cpAl2O3Fit(T);
    cpNickel = cpNickelFit(T);
    cpCeria  = cpCeriaFit(T);
    cAl2O3   = Global.cAl2O3;
    cNickel  = Global.cNickel;
    cCeria   = Global.cCeria;

    mMolarAl2O3  = Global.mMolarAl2O3;
    mMolarNickel = Global.mMolarNickel;
    mMolarCeria  = Global.mMolarCeria;

    cpSolMix     = (cpAl2O3*cAl2O3/mMolarAl2O3)    +    ...
                   (cpNickel*cNickel/mMolarNickel) +    ...
                   (cpCeria*cCeria/mMolarCeria);
% -------------------------------------------------------------------------
end
