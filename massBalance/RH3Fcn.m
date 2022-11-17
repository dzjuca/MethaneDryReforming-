function RH3 = RH3Fcn(alpha, db, ub, CiBW, CiE, CTBW, ...
                      Global, caracter1, caracter2)
% -------------------------------------------------------------------------
    % RH3Fcn - function allows to obtain the third term (Right Hand Side)
    % of the mass balance model
    % ----------------------------| inlet |--------------------------------
    %     alpha = fraction of bubbles in bed                           f(z)
    %        db = bubble diameter                                      f(z)
    %        ub = bubbles velocity                              f(z) [cm/s]
    %      CiBW = concentration (i species) bubble & wake phases       f(z)
    %       CiE = concentration (i species) emulsion phases            f(z)
    %      CTBW = a vector with all concentrations species - bubble & wake
    %    Global = constants structure
    % caracter1 = phase identifier (Gas,Solid)
    % caracter2 = species identifier (CH4,CO2, ...)
    % ----------------------------| outlet |-------------------------------
    %       RH3 = right-hand side term-3
% -------------------------------------------------------------------------
    fw   = Global.fw;
    Emf  = Global.Emf;
    Dcat = Global.Dcat;

    if    strcmp(caracter1,'FGas')
            temporal = (alpha+alpha*fw*Emf).*(CiBW-CiE);
                KBE = KBEFcn(db,ub,CTBW,Global,caracter2);
                RH3 = KBE.*temporal;
    elseif strcmp(caracter1,'FSolido')
            temporal = Dcat*alpha*fw*(1-Emf).*(CiBW-CiE);
                KWE = KWEFcn(db,Global);
                RH3 = KWE.*temporal;
    else
        disp('Error - Ingresar un caracter correcto RH2Fcn.m')
    end
% -------------------------------------------------------------------------   
end

% -------------------------------------------------------------------------

% ----------------------------| KBEFcn sub-function |----------------------
function KBE = KBEFcn( db, ub ,CTBW ,Global ,caracter2 ) 
% -------------------------------------------------------------------------
    % KBEFcn - function allows to obtain the gas exchange coefficient 
    % between bubble-emulsion [s-1]
    % ----------------------------| inlet |--------------------------------
    %        db = bubble diameter                                  f(z)[cm]
    %        ub = bubbles velocity                              f(z) [cm/s]
    %      CTBW = a vector with all concentrations species - bubble & wake
    %    Global = constants structure
    % caracter2 = species identifier (CH4,CO2, ...)
    %        zg = height for each mesh point                       f(z)[cm]
    %     SIGMA = Potentials for each compound - LENNARD-JONES          [A]
    %        EK =                                                       [K]
    %         T = Temperatura                                           [K]
    %         P = Pressure                                            [bar]
    %     MMASS = molar mass vector                                 [g/mol]
    %         g = standard acceleration of gravity                  [cm/s2]
    %       umf = minimum fluidization velocity                      [cm/s]
    %       Emf = minimum fluidization porosity                         [ ]
    % ----------------------------| outlet |-------------------------------
    %       KBE = gas exchange coefficient between bubble-emulsion    [s-1]
% -------------------------------------------------------------------------
    zg     = Global.zg;
    SIGMA  = Global.SIGMA;
    EK     = Global.EK;
    T      = Global.T;
    P      = Global.P;
    MMASS  = Global.MMASS;
    g      = Global.g;
    umf    = Global.umf;
    Emf    = Global.Emf;
    MASS   = MMASS(1:end-1);
    index1 = length(EK);    %                           number of compounds
    index2 = length(zg);    %                  number of points in the mesh
    kbc    = zeros(index2,1);
    kce    = zeros(index2,1);
    KBE    = zeros(index2,1);
% -------------------------------------------------------------------------
    for k = 1:index2
         CTij = CTBW(k,1:index1);
        for nn = 1:index1
            if CTij(nn) < 0, CTij(nn) = 0; end
        end
           CT = sum(CTij); 
        if CT == 0
            kbc(k) = 0;
            kce(k) = 0;
        elseif isnan(CT)
            kbc(k) = 0;
            kce(k) = 0;
            disp('KBE (NaN) en RH3Fcn.m')    
        elseif CT > 0
% ---------- constants values - Neufield, et al. (1972) -------------------
            A = 1.06036; B = 0.15610; 
            C = 0.19300; D = 0.47635; 
            E = 1.03587; F = 1.52996; 
            G = 1.76474; H = 3.89411;
% ---------- diffusion coefficient calculate [cm2/s] ----------------------
                Eij = [];
            SIGMAij = [];
             MASSij = [];
                Xij = [];
                for i = 1:index1
                    for j = 1:index1
                        if i~=j
                        Eij_temp = (EK(i)*EK(j))^(0.5);
                             Eij = [Eij;Eij_temp];
                    SIGMAij_temp = ((SIGMA(i)+SIGMA(j))/2);
                         SIGMAij = [SIGMAij;SIGMAij_temp];
                     MASSij_temp = 2*((1/MASS(i))+(1/MASS(j)))^(-1);
                          MASSij = [MASSij;MASSij_temp];
                        Xij_temp = CTij(j)/CT;
                             Xij = [Xij;Xij_temp];
                        end
                    end
                end
        Eij = reshape(Eij,index1-1,index1);
    SIGMAij = reshape(SIGMAij,index1-1,index1);
     MASSij = reshape(MASSij,index1-1,index1);
        Xij = reshape(Xij,index1-1,index1);
       TAST = T./Eij;
      OMEGA = (A./((TAST).^(B)))+(C./exp(D*TAST))+(E./exp(F*TAST))+...
              (G./exp(H*TAST));
        Dij = (0.00266*(T)^(3/2))./(P*MASSij.^(1/2).*SIGMAij.^2.*OMEGA);
        [id1,id2] = size(Xij);
        Yij = zeros(id1,id2);
     for l = 1:id2
         for m = 1:id1
%       Yij(m,l) = (Xij(m,l))/(sum(Xij(:,l)));
                 tem_sum = sum(Xij(:,l));
             if tem_sum == 0
                Yij(m,l) = 0;
             else
                Yij(m,l) = (Xij(m,l))/tem_sum;
             end
         end
     end       
       suma = (sum(Yij./Dij));
     Dif_ij = zeros(1,index1);
     for  nn = 1:index1
         if suma(nn) == 0
           Dif_ij(nn) = 0;
         else
           Dif_ij(nn) = (suma(nn))^-1;
         end
     end
% ---------- gas exchange coefficient between bubble-emulsion claculate ---
                if     strcmp(caracter2,'CH4') 
                          Dif = Dif_ij(1);
                elseif strcmp(caracter2,'CO2')
                          Dif = Dif_ij(2);
                elseif strcmp(caracter2,'CO')
                          Dif = Dif_ij(3);
                elseif strcmp(caracter2,'H2')
                          Dif = Dif_ij(4);
                elseif strcmp(caracter2,'H2O')
                          Dif = Dif_ij(5);
                elseif strcmp(caracter2,'N2')
                          Dif = Dif_ij(6);
                else
                    disp('Error - Inconsistencia en KBEFcn.m')
                end
       kbc(k) = 4.5*(umf/db(k))+5.85*((Dif^(0.5)*g^(0.25))/(db(k)^(5/4)));
       kce(k) = 6.78*(Emf*Dif*ub(k)/db(k)^(3))^(1/2);
       factor = (1/kbc(k))+(1/kce(k));
       KBE(k) = (factor)^-1;
        else
            disp('Error KBE en RH3Fcn.m')
        end 
    end 
% -------------------------------------------------------------------------
end 

% -------------------------------------------------------------------------

% ----------------------------| KWEFcn sub-function |----------------------
function [KWE] = KWEFcn(db, Global)
% -------------------------------------------------------------------------
    % KWEFcn - function allows to obtain the solid exchange coefficient 
    % between wake-emulsion [s-1]
    % ----------------------------| inlet |--------------------------------
    %        db = bubble diameter                                  f(z)[cm]
    %    Global = constants structure
    %       umf = minimum fluidization velocity                      [cm/s]
    %      usg0 = initial superficial gas velocity                   [cm/s]
    %         n = mesh points number                                    [#]
    % ----------------------------| outlet |-------------------------------
    %       KWE = solid exchange coefficient between wake-emulsion    [s-1]  
% -------------------------------------------------------------------------
    umf    = Global.umf;
    usg0   = Global.usg0;
    n      = Global.n;
    factor = usg0/umf;
    KWE    = zeros(n,1);

    if     factor <= 3
        for j = 1:n
                KWE(j) = 100*0.075*(usg0-umf)/(umf*db(j));
            if db(j) == 0, KWE(j) = 0; end
        end                            
    elseif factor > 3
        for j = 1:n
                KWE(j) = (100*0.15/db(j));
            if db(j) == 0, KWE(j) = 0; end
        end
    else
        disp('Error - Inconsistencia en KWEFcn.m')
    end
% -------------------------------------------------------------------------    
end