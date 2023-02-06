function RH1 = RH1Fcn(alpha,ubes,Ci,Global,caracter)
% -------------------------------------------------------------------------
   % RH1Fcn - function allows to obtain the first term (Right Hand Side)
   % of the mass balance model
   % ----------------------------| inlet |---------------------------------
   %    alpha = fraction of bubbles in bed                             f(z)
   %     ubes = velocity (gas-bubble/gas-emulsion/solid)               f(z)
   %       Ci = species concentrations                                 f(z)
   %   Global = constants structure
   % caracter = phase identifier (Gas,Solid,Bubble,Emulsion)
   % ----------------------------| outlet |--------------------------------
   %      RH1 = right-hand side term-1
% -------------------------------------------------------------------------
       fw   = Global.fw;
       Emf  = Global.Emf;
       zg   = Global.zg; 
       Dcat = Global.Dcat;
       xl   = zg(1);
       xu   = zg(end);
       n    = length(zg);

       if     strcmp(caracter,'FGBurbuja')
              temporal = (alpha+alpha*fw*Emf).*ubes.*Ci;
                     % RH1 = dss004(xl,xu,n,temporal)';
                     % RH1 = dss020(xl,xu,n,temporal, 1)';
                       RH1 = dss012(xl,xu,n,temporal, 1);
       elseif strcmp(caracter,'FGEmulsion')
              temporal = (1-alpha-alpha*fw)*Emf.*ubes.*Ci;
                     % RH1 = dss004(xl,xu,n,temporal)';
                     % RH1 = dss020(xl,xu,n,temporal, 1)';
                       RH1 = dss012(xl,xu,n,temporal, 1);
       elseif strcmp(caracter,'FSEstela')
              temporal = Dcat*(1-Emf)*alpha*fw.*ubes.*Ci;
                     % RH1 = dss004(xl,xu,n,temporal)';
                     % RH1 = dss020(xl,xu,n,temporal, 1)';
                       RH1 = dss012(xl,xu,n,temporal, 1);
       elseif strcmp(caracter,'FSEmulsion')
              temporal = (1-alpha-alpha*fw)*(1-Emf)*Dcat.*ubes.*Ci;
                     % RH1 = dss004(xl,xu,n,temporal)';
                     % RH1 = dss020(xl,xu,n,temporal, -1)';
                       RH1 = dss012(xl,xu,n,temporal, -1);
       else
              disp('Error - Ingresar un caracter correcto RH1Fcn.m')
       end
end