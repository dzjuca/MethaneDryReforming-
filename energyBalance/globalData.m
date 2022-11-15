function Global = globalData()
% ---------- Datos constantes de operaci�n --------------------------------
      R = 8.314472e-3;      % Constante Universal                [kJ/molK]    
      Global.P = 1.01325;          % Presi�n                                [bar]   
      Global.T = 525.0 + 273.15;   % Temperatura                              [K]
      Global.g = 981.0;            % gravedad                             [cm/s2]
      Global.Tref = (475.0 + 273.15); % Temperatura de referencia                [K]
      Global.Tc = (512.5 + 273.15); % Temperatura de referencia                [K]
      Global.Num_esp = 14;               % FBR                                      [#]
% ---------- C�lculo de caudales y concentraciones ------------------------
% CAUDAL TOTAL DE ALIMENTACI�N - PARTE INFERIOR DEL REACTOR (in)
Global.QT_in = 247.5;   %                                          [STP ml/min]
% RATIOS DE ALIMENTACI�N DE CADA ESPECIE - in (ENTRADA)
 CH4in_rat = 40.0; % CH4                                               [%]
 CO2in_rat = 40.0; % CO2                                               [%]
  N2in_rat = 20.0; % N2                                                [%]
  COin_rat = 0.00; % CO                                                [%]
  H2in_rat = 0.00; % H2                                                [%]
 H2Oin_rat = 0.00; % H2O                                               [%]
  O2in_rat = 0.00; % O2                                                [%]
% FLUJOS DE ALIMENTACI�N DE CADA ESPECIE - (in) 
 FCH4in = (CH4in_rat/100)*QT_in/(22.4*1000*60); %                  [mol/s]
 FCO2in = (CO2in_rat/100)*QT_in/(22.4*1000*60); %                  [mol/s]
  FN2in = ( N2in_rat/100)*QT_in/(22.4*1000*60); %                  [mol/s]
  FCOin = ( COin_rat/100)*QT_in/(22.4*1000*60); %                  [mol/s]
  FH2in = ( H2in_rat/100)*QT_in/(22.4*1000*60); %                  [mol/s]
 FH2Oin = (H2Oin_rat/100)*QT_in/(22.4*1000*60); %                  [mol/s]
  FO2in = ( O2in_rat/100)*QT_in/(22.4*1000*60); %                  [mol/s]
% CONCENTRACI�N DE ALIMENTACI�N DE CADA ESPECIE - (in)
Global.CH4in = (FCH4in*60/QT_in); %                                   [mol/cm3]
Global.CO2in = (FCO2in*60/QT_in); %                                   [mol/cm3]
Global.COin = ( FCOin*60/QT_in); %                                   [mol/cm3]
Global.H2in = ( FH2in*60/QT_in); %                                   [mol/cm3]
Global.H2Oin = (FH2Oin*60/QT_in); %                                   [mol/cm3]
Global.N2in = ( FN2in*60/QT_in); %                                   [mol/cm3]
Global.O2in = ( FO2in*60/QT_in); %                                   [mol/cm3]

if Global.QT_in == 0, 
    Global.CH4in = 0; 
    Global.CO2in = 0; 
    Global.COin = 0; 
    Global.H2in = 0;
    Global.H2Oin = 0;  
    Global.N2in = 0;  
    Global.O2in = 0; 
end
% ---------- Datos constantes del mallado espacial (z) --------------------
Global.n = 30;      % n�mero de puntos del mallado                       [#]
% ---------- Datos constantes del Reactor ---------------------------------
Global.Di = 2.7;     % Di�metro interno del reactor                      [cm]
Global.zl = 6.0;     % altura de la zona de reacci�n                     [cm]
Global.zg = linspace(0,zl,n)';  % altura para cada punto del mallado     [cm]
Global.A = pi*(Di/2)^2;       % Secci�n transversal del reactor        [cm2]
% ---------- Datos constantes del catalizador -----------------------------
Global.W  = 30.000;   % Peso del catalizador                              [g]
Global.WIn = 67.500;   % Peso del inerte (al�mina)                         [g]
Global.Dcat = 0.8730;   % Densidad del s�lido (densidad de catalizador) [g/cm3]
Global.DIn = 0.7300;   % Densidad del soporte alpha-al�mina            [g/cm3]
Global.CcMax = 0.3051;   % Concentraci�n de coque m�ximo         [g.coque/g.cat]
% ---------- Datos constantes del lecho fluidizado ------------------------
Global.umf = (16.093/60.0); % Velocidad m�nima de fluidizaci�n          [cm/s] 
Global.fw = 0.15;         % Fracci�n de la burbuja ocupada por la estela  [ ]
Global.Emf = 0.45;         % Porosidad del lecho a umf                     [ ]
% ---------- Datos fluidodin�micos ----------------------------------------
Global.usg0 = QT_in./(A*60.0); % Velocidad de flujo inicial              [cm/s]
% ---------- Constantes cin�ticas - Factor Pre - exponencial --------------
    k1o = (10.87270/3600);% - DRM                             [mol/gcat.s]
    k2o = (716.0353/3600);% - WGSR                            [mol/gcat.s]
    k3o = (0.542000/3600);% - Cracking                        [mol/gcat.s]
% ---------- Constantes cin�ticas - Energ�a de activaci�n -----------------
    Ea1 = (127.1485);     % - DRM                                 [kJ/mol]
    Ea2 = (115.6120);     % - WGSR                                [kJ/mol]
    Ea3 = (41.92570);     % - Cracking                            [kJ/mol]
% ---------- Constantes de adsorci�n - Factor Pre - exponencial -----------
  KCH4o = (3.02410);      %                                        [bar-1]
  KCO2o = (0.43630);      %                                        [bar-1]
   KH2o = (39.9319);      %                                        [bar-1]
% ---------- Constantes de adsorci�n - Entalp�a de adsorci�n --------------
  EaKCH4 = (202.1454);    %                                       [kJ/mol]
  EaKCO2 = (25.33140);    %                                       [kJ/mol] 
   EaKH2 = (102.7949);    %                                       [kJ/mol]
% -- Constantes Equilibrio termodin�mico - Factor Pre - exponencial -------
   KP1o = (0.0055);      % - DRM                                   [bar^2]
   KP2o = (0.2266);      % - WGSR                                      [ ]
   KP3o = (0.0259);      % - Cracking                                [bar]
% -- Constantes Equilibrio termodin�mico - Energ�a de activaci�n ----------
  EaKP1 = (265.6100);    % - DRM                                  [kJ/mol]
  EaKP2 = (38.06000);    % - WGSR                                 [kJ/mol]
  EaKP3 = (143.4945);    % - Cracking                             [kJ/mol]
% ---------- Constantes de desactivaci�n - Factor Pre Exponencial ---------
   KD1o = (1.076200/60); %                                           [s-1]
   KD2o = (242.6530/60); %                                           [s-1]
   KR1o = (0.430300/60); %                                           [s-1]
  KAD1o = (0.1419);      %                                         [bar-2]
  KAD2o = (0.7747);      %                                         [bar-4]
  KAD3o = (0.0710);      %                                         [bar-1]
% ---------- Constantes de desactivacion - Entalp�a de adsorci�n ----------
   EaKD1 = (131.9587);   %                                        [kJ/mol]
   EaKD2 = (195.8497);   %                                        [kJ/mol]
   EaKR1 = (503.3361);   %                                        [kJ/mol]
  EaKAD1 = (267.8376);   %                                        [kJ/mol]
  EaKAD2 = (572.8522);   %                                        [kJ/mol]
  EaKAD3 = (570.9836);   %                                        [kJ/mol]
% ---------- C�lculo de las constantes cin�ticas --------------------------
  Global.k1 =   k1o*exp((-Ea1/R)  *((1/T)-(1/Tc)));
  Global.k2 =   k2o*exp((-Ea2/R)  *((1/T)-(1/Tc)));
  Global.k3 =   k3o*exp((-Ea3/R)  *((1/T)-(1/Tc)));
Global.KCH4 = KCH4o*exp((EaKCH4/R)*((1/T)-(1/Tc)));
Global.KCO2 = KCO2o*exp((EaKCO2/R)*((1/T)-(1/Tc)));
 Global.KH2 =  KH2o*exp((EaKH2/R) *((1/T)-(1/Tc)));
 Global.KP1 =  KP1o*exp((-EaKP1/R)*((1/T)-(1/Tc)));
 Global.KP2 =  KP2o*exp((-EaKP2/R)*((1/T)-(1/Tc))); 
 Global.KP3 =  KP3o*exp((-EaKP3/R)*((1/T)-(1/Tc)));
% ----------- C�lculo de las constantes de desactivaci�n ------------------         
 Global.KD1 = KD1o*exp((-EaKD1/R) *((1/T)-(1/Tc)));
 Global.KD2 = KD2o*exp((-EaKD2/R) *((1/T)-(1/Tc)));
 Global.KR1 = KR1o*exp((-EaKR1/R) *((1/T)-(1/Tc)));
Global.KAD1 = KAD1o*exp((EaKAD1/R)*((1/T)-(1/Tc)));
Global.KAD2 = KAD2o*exp((EaKAD2/R)*((1/T)-(1/Tc)));
Global.KAD3 = KAD3o*exp((EaKAD3/R)*((1/T)-(1/Tc)));
% ---------- Masa molar de los compuestos ---------------------------------
Global.MMASS(1) = 16.0426;      % - CH4                                   [g/mol]
Global.MMASS(2) = 44.0090;      % - CO2                                   [g/mol]
Global.MMASS(3) = 28.0100;      % - CO                                    [g/mol]
Global.MMASS(4) = 2.01580;      % - H2                                    [g/mol]
Global.MMASS(5) = 18.0148;      % - H2O                                   [g/mol]
Global.MMASS(6) = 28.0140;      % - N2                                    [g/mol] 
Global.MMASS(7) = 12.0110;      % - C(s)                                  [g/mol]
% ---------- Potenciales para cada compuesto - LENNARD-JONES --------------
Global.SIGMA(1) = 3.758;        % - CH4                                       [A]
Global.SIGMA(2) = 3.941;        % - CO2                                       [A]
Global.SIGMA(3) = 3.690;        % - CO                                        [A]
Global.SIGMA(4) = 2.827;        % - H2                                        [A]
Global.SIGMA(5) = 2.641;        % - H2O                                       [A]
Global.SIGMA(6) = 3.798;        % - N2                                        [A]
   Global.EK(1) = 148.6;        % - CH4                                       [K]
   Global.EK(2) = 195.2;        % - CO2                                       [K]
   Global.EK(3) = 91.70;        % - CO                                        [K]
   Global.EK(4) = 59.70;        % - H2                                        [K]
   Global.EK(5) = 809.1;        % - H2O                                       [K]
   Global.EK(6) = 71.40;        % - N2                                        [K]
% ------------------------- FIN constantesFBR.m ---------------------------



end