function PPT = partialPressureFcn(CT)

% -------------------- PRESIONES PARCIALES --------------------------------


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