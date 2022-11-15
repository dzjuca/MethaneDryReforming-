function RH2 = RH2Fcn(alpha,ub,CiBW,CiE,caracter)
% Funci�n RH2Fcn.M permite obtener un t�rmino auxiliar RH2 que es parte de
% la ecuaci�n principal de dise�o del reactor TZFBR.
% ----------------------------| ENTRADAS |---------------------------------
%    alpha = fracci�n del lecho ocupado por las burbujas     f(z)
%       ub = velocidad de ascenso de las burbujas            f(z)
%     CiBW = Concentracione gas en la Burbuja o Estela       f(z)
%      CiE = Concentracione gas en la Emulsi�n               f(z)
% caracter = Identificador de la Fase (Gas,S�lido)
% ----------------------------| SALIDAS |----------------------------------
%      RH2 = vector con el valor parcial de la ecuaci�n de dise�o
% -------------------------------------------------------------------------
global fw Emf zg Dcat
      xl = zg(1);
      xu = zg(end);
       n = length(zg);
 lambda1 = zeros(n,1);
 lambda2 = zeros(n,1);
     if     strcmp(caracter,'FGas')
            temporal1 = (alpha+alpha*fw*Emf).*ub;
            temporal2 = dss004(xl,xu,n,temporal1)';
            for i = 1:n
                if      temporal2(i) < 0
                          lambda1(i) = 1;          
                          lambda2(i) = 0;
                elseif temporal2(i) >= 0
                          lambda1(i) = 0;
                          lambda2(i) = 1;
                else
                       disp('Error - Inconsistencia en RH2Fcn.m FGas')
                end
            end
            RH2 = (lambda1.*CiBW + lambda2.*CiE).*temporal2;
     elseif strcmp(caracter,'FSolido')
            temporal1 = (1-Emf)*alpha*fw.*ub*Dcat;
            temporal2 = dss004(xl,xu,n,temporal1)';
            for i = 1:n
                if      temporal2(i) < 0
                          lambda1(i) = 1;
                          lambda2(i) = 0;
                elseif temporal2(i) >= 0
                          lambda1(i) = 0;
                          lambda2(i) = 1;
                else
                       disp('Error - Inconsistencia en RH2Fcn.m FSolido')
                end
            end
            RH2 = (lambda1.*CiBW + lambda2.*CiE).*temporal2;
     else
            disp('Error - Ingresar un caracter correcto RH2Fcn.m')
     end
end