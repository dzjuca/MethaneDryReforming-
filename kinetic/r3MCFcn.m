function r3 = r3MCFcn( PCH4, PH2, kinetic, T ) 
% -------------------------------------------------------------------------
    % r3MCFcn - is a function that calculates the reaction rate of 
    % the methane cracking reaction MC
    % ----------------------------| input |--------------------------------
    %     PCH4-PH2 = partial pressures of gases                       [bar] 
    %     kinetic = a structure that contains the kinetic constants
    %           T = phase temperature                                   [K]
    % -----
    %     R = 8.314472e-3; % Universal Gas Constant               [kJ/molK] 
    %    Tc = reference temperature                                     [K]
    %    k3o-Ea3-KH2o-EaKH2-KCH4o-EaKCH4-KP3o-EaKP3 = kinetic constants 
    % ----------------------------| output |-------------------------------
    %   r3 = the reaction rate of MC                           [mol/gcat s]
% -------------------------------------------------------------------------

    R      = kinetic.R;
    Tc     = kinetic.Tc;
    k3o    = kinetic.k3o;
    Ea3    = kinetic.Ea3;
    KH2o   = kinetic.KH2o;
    EaKH2  = kinetic.EaKH2;
    KCH4o  = kinetic.KCH4o;
    EaKCH4 = kinetic.EaKCH4;
    KP3o   = kinetic.KP3o;
    EaKP3  = kinetic.EaKP3;

% -------------------------------------------------------------------------

    tmp_K3  = exp((-Ea3/R)  *((1/T)-(1/Tc)));
    if(isinf(tmp_K3)), tmp_K3 = 1; end
    k3      =    k3o*tmp_K3;

    tmp_KH2 = exp((EaKH2/R) *((1/T)-(1/Tc)));
    if(isinf(tmp_KH2)), tmp_KH2 = 1; end
    KH2     =  KH2o*tmp_KH2;

    tmp_KCH4 = exp((EaKCH4/R)*((1/T)-(1/Tc)));
    if(isinf(tmp_KCH4)), tmp_KCH4 = 1; end
    KCH4     = KCH4o*tmp_KCH4;

    tmp_KP3 = exp((-EaKP3/R)*((1/T)-(1/Tc)));
    if(isinf(tmp_KP3)), tmp_KP3 = 1; end
    KP3     =  KP3o*tmp_KP3;

% -------------------------------------------------------------------------

    factor1 = KP3*PCH4;
    factor2 = PH2^2/factor1;

    if factor1 == 0, factor2 = 0; end
    factor3     = KH2^(-1.5);
    factor4     = (PH2^(1.5))/factor3;

    if factor3 == 0, factor4 = 0; end
    if ~isreal(factor4), factor4 = 0; end

    r3          = ((k3*KCH4*PCH4)/(1+KCH4*PCH4+factor4)^2)*(1-factor2);

% -------------------------------------------------------------------------
end