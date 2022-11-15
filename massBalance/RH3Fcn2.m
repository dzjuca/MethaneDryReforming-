function RH3 = RH3Fcn2(alpha,db,ub,CiBW,CiE,CTBW,caracter1,caracter2)
% Función RH3Fcn.M permite obtener un término auxiliar RH3 que es parte de
% la ecuación principal de diseño del reactor TZFBR.
% ----------------------------| ENTRADAS |---------------------------------
%     alpha = fracción del lecho ocupado por las burbujas     f(z)
%        db = diámetro de burbujas                            f(z)
%        ub = vector - velocidad de ascenso de la burbuja     f(z) [cm/s]
%      CiBW = Concentraciones en la Burbuja o Estela          f(z)
%       CiE = Concentraciones en la Emulsión                  f(z)
% caracter1 = Identificador de la Fase (Gas,Sólido)
% caracter2 = Identificador del compuesto
%      CTBW = Concentraciones de todos los gases (Burbuja o Estela)(vector)
%       CTE = Concentraciones de todos los gases (Emulsión)        (vector)
% ----------------------------| SALIDAS |----------------------------------
%       RH3 = vector con el valor parcial de la ecuación de diseño
% -------------------------------------------------------------------------
global fw Emf zg Dcat
     n = length(zg);
      if    strcmp(caracter1,'FGas')
             temporal = (alpha+alpha*fw*Emf).*(CiBW-CiE);
                  KBE = KBEFcn(db,ub,CTBW,caracter2);
                  RH3 = KBE.*temporal;
     elseif strcmp(caracter1,'FSolidoEstela')
             temporal = Dcat*alpha*fw*(1-Emf).*(CiBW-CiE);
                  KWE = KWEFcn(db,n);
                  RH3 = KWE.*temporal;
     elseif strcmp(caracter1,'FSolidoEmulsion')
             temporal = Dcat*(1-alpha-alpha*fw)*(1-Emf).*(CiE-CiBW);
                  KWE = KWEFcn(db,n);
                  RH3 = KWE.*temporal;
     else
            disp('Error - Ingresar un caracter correcto RH2Fcn.m')
     end
end
% ----------------------------| SUB-FUNCIÓN |------------------------------
function KBE = KBEFcn(db,ub,CTBW,caracter2) 
global zg SIGMA EK T P MMASS g umf Emf
% ----------------------------| ENTRADAS |---------------------------------
%        db = diámetro de burbujas                        f(z)       [cm]
%        ub = velocidad de ascenso de la burbuja          f(z)     [cm/s]
%      CTBW = Concentración - gases (Burbuja o Estela)    f(z)  [mol/cm3]
% caracter2 = Identificador del compuesto
%        zg = altura para cada punto del mallado          f(z)       [cm]
%     SIGMA = Potenciales para cada compuesto - LENNARD-JONES         [A]
%        EK =                                                         [K]
%         T = Temperatura de reacción                                 [K]
%         P = Presión                                               [bar]
%     MMASS = Masa molar de los compuestos                        [g/mol]
%         g = Aceleración de la gravedad                          [cm/s2]
%       umf = Velocidad de fluidización mínima                     [cm/s]
%       Emf = Porosidad del lecho a umf                               [ ]
% ----------------------------| SALIDAS |----------------------------------
%       KBE = coeficiente de intercambio entre burbuja & emulsión
% -------------------------------------------------------------------------
    MASS = MMASS(1:end-1);
  index1 = length(EK);   % número de compuestos
  index2 = length(zg);   % número de puntos del mallado en z
     kbc = zeros(index2,1);
     kce = zeros(index2,1);
     KBE = zeros(index2,1);
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
% ---------- Constantes - Relación de Neufield, et al. (1972) -------------
            A = 1.06036; B = 0.15610; 
            C = 0.19300; D = 0.47635; 
            E = 1.03587; F = 1.52996; 
            G = 1.76474; H = 3.89411;
% ---------- Cálculo del Coeficiente de Difusión [cm2/s] ------------------
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
     Dif_ij = zeros(1,index1);% Coeficiente de difusión [cm2/s]
     for  nn = 1:index1
         if suma(nn) == 0
           Dif_ij(nn) = 0;
         else
           Dif_ij(nn) = (suma(nn))^-1;
         end
     end
    % ---------- Cálculo de KBE -----------------------------------------------
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
        end % final del condicional
    end % final del bucle
end % final de la fución
% ----------------------------| SUB-FUNCIÓN |------------------------------
function [KWE] = KWEFcn(db,n)
% ----------------------------| ENTRADAS |---------------------------------
%     db = diámetro de la burbuja f(z)                               [cm]
%      n = número de puntos del mallado                               [#]
%    umf = velocidad de fluidización mínima                        [cm/s]
%   usg0 = velocidad de flujo inicial                              [cm/s]
% ----------------------------| SALIDAS |----------------------------------
%    KWE = coeficiente de intercambio sólido                        [s-1]  
% -------------------------------------------------------------------------
global usg0 umf
           factor = usg0/umf;
              KWE = zeros(n,1);
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
end