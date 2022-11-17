function RH4 = RH4Fcn(alpha, CT, Global, caracter1, caracter2)
% -------------------------------------------------------------------------
     % RH4Fcn - function allows to obtain the fourth term (Right Hand Side)
     % of the mass balance model
     % ----------------------------| inlet |-------------------------------
     %     alpha = fraction of bubbles in bed                          f(z)                 
     %        CT = a vector with all concentrations species 
     %             - bubble - wake - emulsion                          f(z)
     %    Global = constants structure
     % caracter1 = phase identifier (Gas,Solid)
     % caracter2 = species identifier (CH4,CO2, ...)
     %        fw = fraction of wake in bubbles                          [ ]
     %       Emf = minimum fluidization porosity                        [ ]
     %      Dcat = catalyst density                                 [g/cm3]
     % ----------------------------| outlet |------------------------------
     %       RH4 = right-hand side term-4
% -------------------------------------------------------------------------
     fw   = Global.fw;
     Emf  = Global.Emf;
     Dcat = Global.Dcat;

     if     strcmp(caracter1,'FGBurbuja')
            temporal = Dcat*(1-Emf)*fw*alpha;
            cinetica = CineticaFcn(CT,caracter2);
                 RH4 = temporal.*cinetica;
     elseif strcmp(caracter1,'FGEmulsion')
            temporal = Dcat*(1-alpha-alpha*fw)*(1-Emf);
            cinetica = CineticaFcn(CT,caracter2);
                 RH4 = temporal.*cinetica;
     elseif strcmp(caracter1,'FSEstela')
            temporal = Dcat*(1-Emf)*fw*alpha;                                   
            cinetica = CineticaFcn(CT,caracter2);
                 RH4 = temporal.*cinetica;
     elseif strcmp(caracter1,'FSEmulsion')
            temporal = Dcat*(1-Emf)*(1-alpha-alpha*fw);         
            cinetica = CineticaFcn(CT,caracter2);
                 RH4 = temporal.*cinetica; 
     else
            disp('Error - Ingresar un caracter correcto RH4Fcn.m')
     end
% -------------------------------------------------------------------------
end