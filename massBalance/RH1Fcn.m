function RH1 = RH1Fcn(alpha,ubes,Ci,caracter)
% Funci�n RH1Fcn.M permite obtener un t�rmino auxiliar RH1 que es parte de
% la ecuaci�n principal de dise�o del reactor TZFBR.
% ----------------------------| ENTRADAS |---------------------------------
%    alpha = fracci�n del lecho ocupado por las burbujas               f(z)
%     ubes = velocidad del gas (burbuja/emulsi�n) velocidad del s�lido f(z)
%       Ci = Concentraciones del gas o s�lido                          f(z)
% caracter = Identificador de la Fase (Gas,S�lido,Burbuja,Emulsi�n)
% ----------------------------| SALIDAS |----------------------------------
%      RH1 = vector con el valor parcial de la ecuaci�n de dise�o
% -------------------------------------------------------------------------
global fw Emf zg Dcat
  xl = zg(1);
  xu = zg(end);
   n = length(zg);
     if     strcmp(caracter,'FGBurbuja')
            temporal = (alpha+alpha*fw*Emf).*ubes.*Ci;
                 RH1 = dss004(xl,xu,n,temporal)';
     elseif strcmp(caracter,'FGEmulsion')
            temporal = (1-alpha-alpha*fw)*Emf.*ubes.*Ci;
                 RH1 = dss004(xl,xu,n,temporal)';
     elseif strcmp(caracter,'FSEstela')
            temporal = Dcat*(1-Emf)*alpha*fw.*ubes.*Ci;
                 RH1 = dss004(xl,xu,n,temporal)';
     elseif strcmp(caracter,'FSEmulsion')
            temporal = (1-alpha-alpha*fw)*(1-Emf)*Dcat.*ubes.*Ci;
                 RH1 = dss004(xl,xu,n,temporal)';
     else
            disp('Error - Ingresar un caracter correcto RH1Fcn.m')
     end
end