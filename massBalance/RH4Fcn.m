function RH4 = RH4Fcn(alpha,CT,caracter1,caracter2)
% Funci�n RH4Fcn.m permite obtener un t�rmino auxiliar RH4 que es parte de
% la ecuaci�n principal de dise�o del reactor TZFBR.
% ----------------------------| ENTRADAS |---------------------------------
%     alpha = Fracci�n del lecho ocupado por las burbujas     f(z)
%        fw = Fracci�n de la burbuja ocupada por la estela
%       Emf = Porosidad de m�nima fluidizaci�n
%      Dcat = Densidad del catalizador                        [g/cm3]
%        CT = Concentraciones de todos los compuestos en: 
%             Burbuja - Estela - Emulsi�n                     f(z)
% caracter1 = Identificador de la Fase (Gas,S�lido)
% caracter2 = Identificador del compuesto
% ----------------------------| SALIDAS |----------------------------------
%      RH4 = vector con el valor parcial de la ecuaci�n de dise�o
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