function r2 = r2RWGSFcn( PCO2, PCO, PH2, PH2O, kinetic, T )
% -------------------------------------------------------------------------
    % r2RWGSFcn - is a function that calculates the reaction rate of 
    % the reverse water gas shift reaction RWGS
    % ----------------------------| input |--------------------------------
    %     PCO2-PCO-PH2-PH2O = partial pressures of gases              [bar] 
    %     kinetic = a structure that contains the kinetic constants
    %           T = phase temperature                                   [K]
    % -----
    %     R = 8.314472e-3; % Universal Gas Constant               [kJ/molK] 
    %    Tc = reference temperature                                     [K]
    %    k2o-Ea2-KP2o-EaKP2-KCO2o-EaKCO2-KH2o-EaKH2 = kinetic constants 
    % ----------------------------| output |-------------------------------
    %   r2 = the reaction rate of RWGS                         [mol/gcat s]
% -------------------------------------------------------------------------

    R      = kinetic.R;
    Tc     = kinetic.Tc;
    k2o    = kinetic.k2o;
    Ea2    = kinetic.Ea2;
    KP2o   = kinetic.KP2o;
    EaKP2  = kinetic.EaKP2;
    KCO2o  = kinetic.KCO2o;
    EaKCO2 = kinetic.EaKCO2;
    KH2o   = kinetic.KH2o;
    EaKH2  = kinetic.EaKH2;
% -------------------------------------------------------------------------

    k2   =   k2o*exp((-Ea2/R)  *((1/T)-(1/Tc)));
    KP2  =  KP2o*exp((-EaKP2/R)*((1/T)-(1/Tc))); 
    KCO2 = KCO2o*exp((EaKCO2/R)*((1/T)-(1/Tc)));
    KH2  =  KH2o*exp((EaKH2/R) *((1/T)-(1/Tc)));

% -------------------------------------------------------------------------
    factor1 = KP2*PCO2*PH2;
    factor2 = PCO*PH2O/factor1;

    if factor1 == 0, factor2 = 0; end
    factor3     = (1 + KCO2*PCO2 + KH2*PH2)^2;
    
    r2          = (k2*KCO2*KH2*PCO2*PH2/factor3)*(1-factor2);
% -------------------------------------------------------------------------
end