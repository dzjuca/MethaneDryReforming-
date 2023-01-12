function r1 = r1DRMFcn( PCH4, PCO2, PCO, PH2, kinetic, T)
% -------------------------------------------------------------------------
    % r1DRMFcn - is a function that calculates the reaction rate of dry 
    % reforming of methane DRM
    % ----------------------------| input |--------------------------------
    %     PCH4-PCO2-PCO-PH2 = partial pressures of gases              [bar] 
    %     kinetic = a structure that contains the kinetic constants
    %           T = phase temperature                                   [K]
    % -----
    %     R = 8.314472e-3; % Universal Gas Constant               [kJ/molK] 
    %    Tc = reference temperature                                     [K]
    %    k1o-Ea1-KCH4o-EaKCH4-KCO2o-EaKCO2-KP1o-EaKP1 =  kinetic constants 
    % ----------------------------| output |-------------------------------
    %   r1 = the reaction rate of DRM                          [mol/gcat s]
% -------------------------------------------------------------------------

    if (T < 100), T = kinetic.Tpro; end
        
% -------------------------------------------------------------------------

    R      = kinetic.R;
    Tc     = kinetic.Tc;
    k1o    = kinetic.k1o;
    Ea1    = kinetic.Ea1;
    KCH4o  = kinetic.KCH4o;
    EaKCH4 = kinetic.EaKCH4;
    KCO2o  = kinetic.KCO2o;
    EaKCO2 = kinetic.EaKCO2;
    KP1o   = kinetic.KP1o;
    EaKP1  = kinetic.EaKP1;

% -------------------------------------------------------------------------

    tmp_k1 = exp((-Ea1/R)*((1/T)-(1/Tc)));
    if(isinf(tmp_k1)), tmp_k1 = 1; end
    k1     = k1o*tmp_k1;
    %Global.k1   =   k1o*exp((-Ea1/Global.R)  *((1/Global.T)-(1/Global.Tc)));

    tmp_KCH4 = exp((EaKCH4/R)*((1/T)-(1/Tc)));
    if(isinf(tmp_KCH4)), tmp_KCH4 = 1; end
    KCH4     = KCH4o*tmp_KCH4;
    %Global.KCH4 = KCH4o*exp((EaKCH4/Global.R)*((1/Global.T)-(1/Global.Tc)));

    tmp_KCO2 = exp((EaKCO2/R)*((1/T)-(1/Tc)));
    if(isinf(tmp_KCO2)), tmp_KCO2 = 1; end
    KCO2     = KCO2o*tmp_KCO2;
    %Global.KCO2 = KCO2o*exp((EaKCO2/Global.R)*((1/Global.T)-(1/Global.Tc)));

    tmp_KP1 = exp((-EaKP1/R)*((1/T)-(1/Tc)));
    if(isinf(tmp_KP1)), tmp_KP1 = 1; end
    KP1     = KP1o*tmp_KP1;
    %Global.KP1  =  KP1o*exp((-EaKP1/Global.R)*((1/Global.T)-(1/Global.Tc)));

% -------------------------------------------------------------------------

    factor1 = PCH4*PCO2*KP1;
    factor2 = PCO^2*PH2^2/factor1;  

    if factor1 == 0, factor2 = 0; end
    factor3     = (1 + KCH4*PCH4 + KCO2*PCO2)^2;

    r1          = (k1*KCH4*KCO2*PCH4*PCO2/factor3)*(1-factor2);
% -------------------------------------------------------------------------
end


