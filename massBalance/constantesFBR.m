global T P g Tref Tc Num_esp QT_in                           ...
       CH4in CO2in COin H2in H2Oin N2in O2in                 ...   
       Di zl zg A n                                          ...
       W WIn Dcat DIn                                        ...
       umf fw Emf                                            ...
       usg0                                                  ...
       k1 k2 k3                                              ...
       KCH4 KCO2 KH2                                         ...
       KP1 KP2 KP3                                           ...
       KD1 KD2 KR1                                           ...
       KAD1 KAD2 KAD3                                        ...  
       MMASS SIGMA EK CcMax   
% ---------- Datos constantes de operación --------------------------------
      R = 8.314472e-3;      % Constante Universal                [kJ/molK]    
      P = 1.01325;          % Presión                                [bar]   
      T = 525.0 + 273.15;   % Temperatura                              [K]
      g = 981.0;            % gravedad                             [cm/s2]
   Tref = (475.0 + 273.15); % Temperatura de referencia                [K]
     Tc = (512.5 + 273.15); % Temperatura de referencia                [K]
Num_esp = 14;               % FBR                                      [#]
% ---------- Cálculo de caudales y concentraciones ------------------------
% CAUDAL TOTAL DE ALIMENTACIÓN - PARTE INFERIOR DEL REACTOR (in)
  QT_in = 247.5;   %                                          [STP ml/min]
% RATIOS DE ALIMENTACIÓN DE CADA ESPECIE - in (ENTRADA)
 CH4in_rat = 40.0; % CH4                                               [%]
 CO2in_rat = 40.0; % CO2                                               [%]
  N2in_rat = 20.0; % N2                                                [%]
  COin_rat = 0.00; % CO                                                [%]
  H2in_rat = 0.00; % H2                                                [%]
 H2Oin_rat = 0.00; % H2O                                               [%]
  O2in_rat = 0.00; % O2                                                [%]
% FLUJOS DE ALIMENTACIÓN DE CADA ESPECIE - (in) 
 FCH4in = (CH4in_rat/100)*QT_in/(22.4*1000*60); %                  [mol/s]
 FCO2in = (CO2in_rat/100)*QT_in/(22.4*1000*60); %                  [mol/s]
  FN2in = ( N2in_rat/100)*QT_in/(22.4*1000*60); %                  [mol/s]
  FCOin = ( COin_rat/100)*QT_in/(22.4*1000*60); %                  [mol/s]
  FH2in = ( H2in_rat/100)*QT_in/(22.4*1000*60); %                  [mol/s]
 FH2Oin = (H2Oin_rat/100)*QT_in/(22.4*1000*60); %                  [mol/s]
  FO2in = ( O2in_rat/100)*QT_in/(22.4*1000*60); %                  [mol/s]
% CONCENTRACIÓN DE ALIMENTACIÓN DE CADA ESPECIE - (in)
  CH4in = (FCH4in*60/QT_in); %                                   [mol/cm3]
  CO2in = (FCO2in*60/QT_in); %                                   [mol/cm3]
   COin = ( FCOin*60/QT_in); %                                   [mol/cm3]
   H2in = ( FH2in*60/QT_in); %                                   [mol/cm3]
  H2Oin = (FH2Oin*60/QT_in); %                                   [mol/cm3]
   N2in = ( FN2in*60/QT_in); %                                   [mol/cm3]
   O2in = ( FO2in*60/QT_in); %                                   [mol/cm3]
   if QT_in == 0, CH4in = 0; CO2in = 0; COin = 0; H2in = 0;
       H2Oin = 0;  N2in = 0;  O2in = 0; end
% ---------- Datos constantes del mallado espacial (z) --------------------
     n = 30;      % número de puntos del mallado                       [#]
% ---------- Datos constantes del Reactor ---------------------------------
    Di = 2.7;     % Diámetro interno del reactor                      [cm]
    zl = 6.0;     % altura de la zona de reacción                     [cm]
    zg = linspace(0,zl,n)';  % altura para cada punto del mallado     [cm]
     A = pi*(Di/2)^2;       % Sección transversal del reactor        [cm2]
% ---------- Datos constantes del catalizador -----------------------------
    W  = 30.000;   % Peso del catalizador                              [g]
   WIn = 67.500;   % Peso del inerte (alúmina)                         [g]
  Dcat = 0.8730;   % Densidad del sólido (densidad de catalizador) [g/cm3]
   DIn = 0.7300;   % Densidad del soporte alpha-alúmina            [g/cm3]
 CcMax = 0.3051;   % Concentración de coque máximo         [g.coque/g.cat]
% ---------- Datos constantes del lecho fluidizado ------------------------
   umf = (16.093/60.0); % Velocidad mínima de fluidización          [cm/s] 
    fw = 0.15;         % Fracción de la burbuja ocupada por la estela  [ ]
   Emf = 0.45;         % Porosidad del lecho a umf                     [ ]
% ---------- Datos fluidodinámicos ----------------------------------------
  usg0 = QT_in./(A*60.0); % Velocidad de flujo inicial              [cm/s]
% ---------- Constantes cinéticas - Factor Pre - exponencial --------------
    k1o = (10.87270/3600);% - DRM                             [mol/gcat.s]
    k2o = (716.0353/3600);% - WGSR                            [mol/gcat.s]
    k3o = (0.542000/3600);% - Cracking                        [mol/gcat.s]
% ---------- Constantes cinéticas - Energía de activación -----------------
    Ea1 = (127.1485);     % - DRM                                 [kJ/mol]
    Ea2 = (115.6120);     % - WGSR                                [kJ/mol]
    Ea3 = (41.92570);     % - Cracking                            [kJ/mol]
% ---------- Constantes de adsorción - Factor Pre - exponencial -----------
  KCH4o = (3.02410);      %                                        [bar-1]
  KCO2o = (0.43630);      %                                        [bar-1]
   KH2o = (39.9319);      %                                        [bar-1]
% ---------- Constantes de adsorción - Entalpía de adsorción --------------
  EaKCH4 = (202.1454);    %                                       [kJ/mol]
  EaKCO2 = (25.33140);    %                                       [kJ/mol] 
   EaKH2 = (102.7949);    %                                       [kJ/mol]
% -- Constantes Equilibrio termodinámico - Factor Pre - exponencial -------
   KP1o = (0.0055);      % - DRM                                   [bar^2]
   KP2o = (0.2266);      % - WGSR                                      [ ]
   KP3o = (0.0259);      % - Cracking                                [bar]
% -- Constantes Equilibrio termodinámico - Energía de activación ----------
  EaKP1 = (265.6100);    % - DRM                                  [kJ/mol]
  EaKP2 = (38.06000);    % - WGSR                                 [kJ/mol]
  EaKP3 = (143.4945);    % - Cracking                             [kJ/mol]
% ---------- Constantes de desactivación - Factor Pre Exponencial ---------
   KD1o = (1.076200/60); %                                           [s-1]
   KD2o = (242.6530/60); %                                           [s-1]
   KR1o = (0.430300/60); %                                           [s-1]
  KAD1o = (0.1419);      %                                         [bar-2]
  KAD2o = (0.7747);      %                                         [bar-4]
  KAD3o = (0.0710);      %                                         [bar-1]
% ---------- Constantes de desactivacion - Entalpía de adsorción ----------
   EaKD1 = (131.9587);   %                                        [kJ/mol]
   EaKD2 = (195.8497);   %                                        [kJ/mol]
   EaKR1 = (503.3361);   %                                        [kJ/mol]
  EaKAD1 = (267.8376);   %                                        [kJ/mol]
  EaKAD2 = (572.8522);   %                                        [kJ/mol]
  EaKAD3 = (570.9836);   %                                        [kJ/mol]
% ---------- Cálculo de las constantes cinéticas --------------------------
               k1 =   k1o*exp((-Ea1/R)  *((1/T)-(1/Tc)));
               k2 =   k2o*exp((-Ea2/R)  *((1/T)-(1/Tc)));
               k3 =   k3o*exp((-Ea3/R)  *((1/T)-(1/Tc)));
             KCH4 = KCH4o*exp((EaKCH4/R)*((1/T)-(1/Tc)));
             KCO2 = KCO2o*exp((EaKCO2/R)*((1/T)-(1/Tc)));
              KH2 =  KH2o*exp((EaKH2/R) *((1/T)-(1/Tc)));
              KP1 =  KP1o*exp((-EaKP1/R)*((1/T)-(1/Tc)));
              KP2 =  KP2o*exp((-EaKP2/R)*((1/T)-(1/Tc))); 
              KP3 =  KP3o*exp((-EaKP3/R)*((1/T)-(1/Tc)));
% ----------- Cálculo de las constantes de desactivación ------------------         
              KD1 = KD1o*exp((-EaKD1/R) *((1/T)-(1/Tc)));
              KD2 = KD2o*exp((-EaKD2/R) *((1/T)-(1/Tc)));
              KR1 = KR1o*exp((-EaKR1/R) *((1/T)-(1/Tc)));
             KAD1 = KAD1o*exp((EaKAD1/R)*((1/T)-(1/Tc)));
             KAD2 = KAD2o*exp((EaKAD2/R)*((1/T)-(1/Tc)));
             KAD3 = KAD3o*exp((EaKAD3/R)*((1/T)-(1/Tc)));
% ---------- Masa molar de los compuestos ---------------------------------
MMASS(1) = 16.0426;      % - CH4                                   [g/mol]
MMASS(2) = 44.0090;      % - CO2                                   [g/mol]
MMASS(3) = 28.0100;      % - CO                                    [g/mol]
MMASS(4) = 2.01580;      % - H2                                    [g/mol]
MMASS(5) = 18.0148;      % - H2O                                   [g/mol]
MMASS(6) = 28.0140;      % - N2                                    [g/mol] 
MMASS(7) = 12.0110;      % - C(s)                                  [g/mol]
% ---------- Potenciales para cada compuesto - LENNARD-JONES --------------
SIGMA(1) = 3.758;        % - CH4                                       [A]
SIGMA(2) = 3.941;        % - CO2                                       [A]
SIGMA(3) = 3.690;        % - CO                                        [A]
SIGMA(4) = 2.827;        % - H2                                        [A]
SIGMA(5) = 2.641;        % - H2O                                       [A]
SIGMA(6) = 3.798;        % - N2                                        [A]
   EK(1) = 148.6;        % - CH4                                       [K]
   EK(2) = 195.2;        % - CO2                                       [K]
   EK(3) = 91.70;        % - CO                                        [K]
   EK(4) = 59.70;        % - H2                                        [K]
   EK(5) = 809.1;        % - H2O                                       [K]
   EK(6) = 71.40;        % - N2                                        [K]
% ------------------------- FIN constantesFBR.m ---------------------------