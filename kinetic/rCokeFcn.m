function rCoke = rCokeFcn( Cc, PCH4, PCO2, PCO, PH2, kinetic, T )
% -------------------------------------------------------------------------
    % rCokeFcn - is a function that calculates the reaction rate of 
    % the methane cracking reaction MC
    % ----------------------------| input |--------------------------------
    %   Cc = coke concentration                              [g-coke/g-cat] 
    %     PCH4-PCO2-PCO-PH2 = partial pressures of gases              [bar] 
    %     kinetic = a structure that contains the kinetic constants
    %           T = phase temperature                                   [K]
    % -----
    %     R = 8.314472e-3; % Universal Gas Constant               [kJ/molK] 
    %    Tc = reference temperature                                     [K]
    % CcMax = max coke concentration                         [g-coke/g-cat]
    % KD1o-EaKD1-KD2o-EaKD2-KR1o-KAD1o-EaKAD1-KAD2o-EaKAD2-KAD3o-EaKAD3....
    % =  kinetic constants 
    % ----------------------------| output |-------------------------------
    %   rCoke = the reaction rate of coke formation        [g-coke/g-cat s]
% -------------------------------------------------------------------------
    R      = kinetic.R;
    Tc     = kinetic.Tc;
    CcMax  = kinetic.CcMax;
% -------------------------------------------------------------------------
    KD1o   = kinetic.KD1o;
    EaKD1  = kinetic.EaKD1;
    KD2o   = kinetic.KD2o;
    EaKD2  = kinetic.EaKD2;
    KR1o   = kinetic.KR1o;
    EaKR1  = kinetic.EaKR1;
    KAD1o  = kinetic.KAD1o;
    EaKAD1 = kinetic.EaKAD1;
    KAD2o  = kinetic.KAD2o;
    EaKAD2 = kinetic.EaKAD2;
    KAD3o  = kinetic.KAD3o;
    EaKAD3 = kinetic.EaKAD3;
% -------------------------------------------------------------------------
    KD1    = KD1o*exp((-EaKD1/R) *((1/T)-(1/Tc)));
    KD2    = KD2o*exp((-EaKD2/R) *((1/T)-(1/Tc)));
    KR1    = KR1o*exp((-EaKR1/R) *((1/T)-(1/Tc)));
    KAD1   = KAD1o*exp((EaKAD1/R)*((1/T)-(1/Tc)));
    KAD2   = KAD2o*exp((EaKAD2/R)*((1/T)-(1/Tc)));
    KAD3   = KAD3o*exp((EaKAD3/R)*((1/T)-(1/Tc)));
% -------------------------------------------------------------------------
    FId    = (KD1*KAD1*PCH4^2 + KD2*KAD2*PCO^2*PH2^2)/((1 + KAD3*PCO2)^2);    
    FIr    = (KR1*KAD3*PCO2)/(1+KAD3*PCO2); 
% -------------------------------------------------------------------------
    Factor1 = (Cc/CcMax);
    if Factor1 > 1, Factor1 = 1; end
    Factor2 = 2*(CcMax-Cc);
    Factor3 = CcMax^2/Factor2;
    if Factor2 == 0, Factor3 = 0; end
    rCoke = Factor3*(FId*(1-Factor1)^3-FIr*(1-Factor1)+FIr*(1-Factor1)^2);
    if Cc > CcMax, rCoke = 0; end
% -------------------------------------------------------------------------
end