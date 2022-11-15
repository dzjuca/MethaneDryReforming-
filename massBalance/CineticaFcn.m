function cinetica = CineticaFcn(CTglobal,caracter2)
global zg
% --------------------| CONFIGURACIÓN DE PARÁMETROS |----------------------
  index1 = length(zg);
      r1 = zeros(index1,1);
      r2 = zeros(index1,1);
      r3 = zeros(index1,1);
   rCoke = zeros(index1,1);
for  i = 1:index1  %                          inicio - bucle espacial f(z)
    CT = CTglobal(i,:);
% -------------------- CONCENTRACIONES DE COQUE ---------------------------
    Cc = CT(7); 
% -------------------- PRESIONES PARCIALES [bar]---------------------------
   PPT = PPTFcn(CT(1:6));
  PCH4 = PPT(1); PCO2 = PPT(2); PCO = PPT(3); PH2 = PPT(4); PH2O = PPT(5);  
% -------------------- MODELO DE ACTIVIDAD --------------------------------
         a = actFun(Cc);
% --------------------| VELOCIDADES DE REACCIÓN |--------------------------
% -------------------- VELOCIDAD [r1] DRM ---------------------------------    
     r1(i) = R1Fcn(PCH4,PCO2,PCO,PH2)*a;
% -------------------- VELOCIDAD [r2] RWGS --------------------------------
     r2(i) = R2Fcn(PCO2,PCO,PH2,PH2O)*a;
% -------------------- VELOCIDAD [r3] CRACKING ----------------------------
     r3(i) = R3Fcn(PCH4,PH2)*a;
% -------------------- VELOCIDAD [rCoke] FORMACIÓN COQUE ------------------
  rCoke(i) = RCokeFcn2(Cc,PCH4,PCO2,PCO,PH2)*a;
% -------------------------------------------------------------------------
end
% ---------------| VELOCIDAD DE REACCIÓN DE CADA ELEMENTO |----------------
    if     strcmp(caracter2,'CH4')
            cinetica =  -r1 - r3;
%            cinetica =  0;
    elseif strcmp(caracter2,'CO2')
            cinetica =  -r1 - r2;
%            cinetica =  0;
    elseif strcmp(caracter2, 'CO')
            cinetica = 2*r1 + r2;
%            cinetica =  0;
    elseif strcmp(caracter2, 'H2')
            cinetica = 2*r1 - r2 + 2*r3;
%            cinetica =  0;
    elseif strcmp(caracter2,'H2O')
            cinetica = r2;
%            cinetica =  0;
    elseif strcmp(caracter2, 'N2')
            cinetica = 0;
    elseif strcmp(caracter2, 'Cc')
            cinetica = rCoke;
%             cinetica = 0.0;
    else
           disp('ERROR Inconsistencia en la entrada de : CineticaFcn.m')
    end    
end % -----------------------| END - CineticaFcn.m |-----------------------
% -------------------------------------------------------------------------
% ----------| MODELOS CINÉTICOS - DRY REFORMING OF METHANE |---------------
% -------------------- MODELO DRM -----------------------------------------
function r1 = R1Fcn(PCH4,PCO2,PCO,PH2)
global k1 KCH4 KCO2 KP1 
          factor1 = PCH4*PCO2*KP1;
          factor2 = PCO^2*PH2^2/factor1;           
      if factor1 == 0, factor2 = 0; end
          factor3 = (1 + KCH4*PCH4 + KCO2*PCO2)^2;
               r1 = (k1*KCH4*KCO2*PCH4*PCO2/factor3)*(1-factor2);
end
% -------------------- MODELO WGSR ----------------------------------------
function r2 = R2Fcn(PCO2,PCO,PH2,PH2O)
global k2 KP2 KCO2 KH2             
          factor1 = KP2*PCO2*PH2;
          factor2 = PCO*PH2O/factor1;
      if factor1 == 0, factor2 = 0; end
          factor3 = (1 + KCO2*PCO2 + KH2*PH2)^2;
               r2 = (k2*KCO2*KH2*PCO2*PH2/factor3)*(1-factor2);
end
% -------------------- MODELO CRACKING METANO -----------------------------
function r3 = R3Fcn(PCH4,PH2) 
global k3 KH2 KCH4 KP3
           factor1 = KP3*PCH4;
           factor2 = PH2^2/factor1;
       if factor1 == 0, factor2 = 0; end
           factor3 = KH2^(-1.5);
           factor4 = (PH2^(1.5))/factor3;
       if factor3 == 0,     factor4 = 0; end
       if ~isreal(factor4), factor4 = 0; end
                r3 = ((k3*KCH4*PCH4)/(1+KCH4*PCH4+factor4)^2)*(1-factor2);
end
% -------------------- MODELO DE FORMACIÓN DE COQUE 1 ---------------------
function rCoke = RCokeFcn(Cc,PCH4,PCO2,PCO,PH2)
global KD1 KD2 KR1 KAD1 KAD2 KAD3 CcMax
       FId = (KD1*KAD1*PCH4^2 + KD2*KAD2*PCO^2*PH2^2)/((1 + KAD3*PCO2)^2);    
       FIr = (KR1*KAD3*PCO2)/(1+KAD3*PCO2);  
   Factor1 = (Cc/CcMax);
if Factor1 > 1, Factor1 = 1; end
   Factor2 = 2*(CcMax-Cc);
   Factor3 = CcMax^2/Factor2;
if Factor2 == 0, Factor3 = 0; end
     rCoke = Factor3*(FId*(1-Factor1)^3 - FIr*(1-Factor1));
if Cc > CcMax, rCoke = 0; end
end
% -------------------- MODELO DE FORMACIÓN DE COQUE 2 ---------------------
function rCoke = RCokeFcn2(Cc,PCH4,PCO2,PCO,PH2)
global KD1 KD2 KR1 KAD1 KAD2 KAD3 CcMax
       FId = (KD1*KAD1*PCH4^2 + KD2*KAD2*PCO^2*PH2^2)/((1 + KAD3*PCO2)^2);    
       FIr = (KR1*KAD3*PCO2)/(1+KAD3*PCO2);  
   Factor1 = (Cc/CcMax);
if Factor1 > 1, Factor1 = 1; end
   Factor2 = 2*(CcMax-Cc);
   Factor3 = CcMax^2/Factor2;
if Factor2 == 0, Factor3 = 0; end
     rCoke = Factor3*(FId*(1-Factor1)^3-FIr*(1-Factor1)+FIr*(1-Factor1)^2);
if Cc > CcMax, rCoke = 0; end
end
% -------------------- MODELO DE ACTIVIDAD --------------------------------
function a = actFun(Cc)
global CcMax ncall
         a = (1-(Cc/CcMax))^2;
   if ncall > 435
      if Cc > CcMax, a = 0; end
      if Cc < 0,     a = 1; end
   end
end
% -------------------- PRESIONES PARCIALES --------------------------------
function PPT = PPTFcn(CT)
  CCH4 = CT(1); CCO2 = CT(2); CCO = CT(3); 
   CH2 = CT(4); CH2O = CT(5); CN2 = CT(6);  
CTsuma = sum(CT(1:6));

 if sum(CT(1:6)) == 0
             PCH4 = 0.0; PCO2 = 0.0; PCO = 0.0;
              PH2 = 0.0; PH2O = 0.0; PN2 = 0.0;                  
              PPT = [PCH4,PCO2,PCO,PH2,PH2O,PN2];
 elseif isnan(CT)
             PCH4 = CCH4/CTsuma; PCO2 = CCO2/CTsuma; PCO = CCO/CTsuma;
              PH2 = CH2/CTsuma;  PH2O = CH2O/CTsuma; PN2 = CN2/CTsuma;                   
              PPT = [PCH4,PCO2,PCO,PH2,PH2O,PN2];
                    disp('CT = NaN CineticaFcn.m')
 else
             PCH4 = CCH4/CTsuma; PCO2 = CCO2/CTsuma; PCO = CCO/CTsuma;
              PH2 = CH2/CTsuma;  PH2O = CH2O/CTsuma; PN2 = CN2/CTsuma;                   
              PPT = [PCH4,PCO2,PCO,PH2,PH2O,PN2];
 end
end