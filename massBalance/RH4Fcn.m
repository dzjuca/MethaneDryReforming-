function RH4 = RH4Fcn(alpha,CT,caracter1,caracter2)
% Función RH4Fcn.m permite obtener un término auxiliar RH4 que es parte de
% la ecuación principal de diseño del reactor TZFBR.
% ----------------------------| ENTRADAS |---------------------------------
%     alpha = Fracción del lecho ocupado por las burbujas     f(z)
%        fw = Fracción de la burbuja ocupada por la estela
%       Emf = Porosidad de mínima fluidización
%      Dcat = Densidad del catalizador                        [g/cm3]
%        CT = Concentraciones de todos los compuestos en: 
%             Burbuja - Estela - Emulsión                     f(z)
% caracter1 = Identificador de la Fase (Gas,Sólido)
% caracter2 = Identificador del compuesto
% ----------------------------| SALIDAS |----------------------------------
%      RH4 = vector con el valor parcial de la ecuación de diseño
% -------------------------------------------------------------------------
global fw Emf Dcat
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
end