function cinetica = CineticaFcn(Cgas, Global, Tbe, caracter2)
% -------------------------------------------------------------------------
  % CineticaFcn function 
  % ----------------------------| input |----------------------------------
  %        Cgas = concentration vector of each species            [mol/cm3]
  %      Global = constant values structure 
  %         Tbe = phase temperature                                     [K]
  %   caracter2 = species|reaction identifier
  % ----------------------------| output |---------------------------------
  %  cinetica = right-hand side term-3                            [J/s cm3]
% -------------------------------------------------------------------------
    zg     = Global.zg;
    index1 = length(zg);
    r1     = zeros(index1,1);
    r2     = zeros(index1,1);
    r3     = zeros(index1,1);
    rCoke  = zeros(index1,1);
    kinetic = Global.kinetic;

    for  i = 1:index1 

        CT   = Cgas(i,:);
        Cc   = CT(7); 
        PPT  = partialPressureFcn(CT(1:6));
        PCH4 = PPT(1); PCO2 = PPT(2); PCO = PPT(3); 
        PH2  = PPT(4); PH2O = PPT(5);  
        T    = Tbe(i);
        a        = activityFcn( Cc, Global);   
        r1(i)    = r1DRMFcn(PCH4, PCO2, PCO, PH2, kinetic, T)*a; % ========> aqui quedamos, falta arreglar los otros factores y hacer reverso
        r2(i)    = r2RWGSFcn(PCO2,PCO,PH2,PH2O,Global)*a;
        r3(i)    = r3MCFcn(PCH4,PH2,Global)*a;
        rCoke(i) = rCokeFcn(Cc,PCH4,PCO2,PCO,PH2,Global)*a;

    end

    if     strcmp(caracter2,'CH4')
            cinetica =  -r1 - r3;
    elseif strcmp(caracter2,'CO2')
            cinetica =  -r1 - r2;
    elseif strcmp(caracter2, 'CO')
            cinetica = 2*r1 + r2;
    elseif strcmp(caracter2, 'H2')
            cinetica = 2*r1 - r2 + 2*r3;
    elseif strcmp(caracter2,'H2O')
            cinetica = r2;
    elseif strcmp(caracter2, 'N2')
            cinetica = 0;
    elseif strcmp(caracter2, 'Cc')
            cinetica = rCoke;
    elseif strcmp(caracter2, 'DRM')
            cinetica = r1;
    elseif strcmp(caracter2, 'RWGS')
            cinetica = r2;
    elseif strcmp(caracter2, 'MC')
            cinetica = r3;
    else
           disp('CineticaFcn.m error')
    end   
% ------------------------------------------------------------------------- 
end











