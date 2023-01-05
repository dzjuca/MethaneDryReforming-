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

    k1     = k1o*exp((-Ea1/R)  *((1/T)-(1/Tc)));
    KCH4   = KCH4o*exp((EaKCH4/R)*((1/T)-(1/Tc)));
    KCO2   = KCO2o*exp((EaKCO2/R)*((1/T)-(1/Tc)));
    KP1    = KP1o*exp((-EaKP1/R)*((1/T)-(1/Tc)));

% -------------------------------------------------------------------------

    factor1 = PCH4*PCO2*KP1;
    factor2 = PCO^2*PH2^2/factor1;  

    if factor1 == 0, factor2 = 0; end
    factor3     = (1 + KCH4*PCH4 + KCO2*PCO2)^2;

    r1          = (k1*KCH4*KCO2*PCH4*PCO2/factor3)*(1-factor2);
% -------------------------------------------------------------------------
end

