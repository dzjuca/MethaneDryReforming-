function cinetica = CineticaFcn(Cgas, Global, Tbe, caracter2)
% -------------------------------------------------------------------------
  % CineticaFcn function 
  % ----------------------------| input |----------------------------------
  %        Cgas = concentration vector of each species            [mol/cm3]
  %      Global = constant values structure 
  %         Tbe = phase temperature                                     [K]
  %   caracter2 = species|reaction identifier
  % ----------------------------| output |---------------------------------
  %   cinetica = reaction rate of each species                 [mol/gcat s]                       
% -------------------------------------------------------------------------
    zg     = Global.zg;
    index1 = length(zg);
    r1     = zeros(index1,1);
    r2     = zeros(index1,1);
    r3     = zeros(index1,1);
    rCoke  = zeros(index1,1);
    kinetic = Global.kinetic;
% -------------------------------------------------------------------------
     T_be = Tbe;

%      if (strcmp(caracter2,'DRM')  || ...
%          strcmp(caracter2,'RWGS') || ...
%          strcmp(caracter2,'MC'))
%  
%              T_be = Tbe;
%  
%      else
%              
%              T_be    = zeros(index1,1);
%              T_be(:,1) = Global.Tbed;
%  
%      end
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
    for  i = 1:index1 

        CT   = Cgas(i,:);
        Cc   = CT(7); 
        PPT  = partialPressureFcn(CT(1:6));
        PCH4 = PPT(1); PCO2 = PPT(2); PCO = PPT(3); 
        PH2  = PPT(4); PH2O = PPT(5);  
        T    = T_be(i);
        a        = activityFcn( Cc, kinetic);   
        r1(i)    = r1DRMFcn(PCH4, PCO2, PCO, PH2, kinetic, T)*a;
        r2(i)    = r2RWGSFcn(PCO2, PCO, PH2, PH2O, kinetic, T)*a;
        r3(i)    = r3MCFcn(PCH4, PH2, kinetic, T)*a;
        rCoke(i) = rCokeFcn(Cc, PCH4, PCO2, PCO, PH2, kinetic, T)*a;

    end
% -------------------------------------------------------------------------
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
            % cinetica = 0;
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











