function [ub,db,us,ue,alpha]= ubFcn(Global)
% Funci�n ubFcn.m permite el c�culo del di�metro y velocidad de burbuja en 
% funci�n de la altura del reactor(z).
% ----------------------------| ENTRADAS |---------------------------------
%     usg0 = velocidad del gas reactante                    [cm/s]
%      umf = velocidad m�nima de fluidizaci�n               [cm/s]
%        g = aceleraci�n de la gravedad                     [cm/s2]
%       Di = Di�metro interno del reactor                   [cm]
%       zg = Valores del mallado del reactor                [cm]
%       fw = Fracci�n de la burbuja ocupada por la estela   [  ]
%      Emf = Porosidad m�nima de fluidizaci�n               [  ]
% ----------------------------| SALIDAS |----------------------------------
%       ub = vector - velocidad de ascenso de la burbuja           [cm/s]
%       db = vector - di�metro de la burbuja                       [cm]
%       us = vector - velocidad de descenso del solido (emulsi�n)  [cm/s]
%       ue = vector - velocidad del gas en la emulsi�n             [cm/s]
%    alpha = vector - fracci�n de burbujas en la fase densa        [  ]
% -------------------------------------------------------------------------
    usg0 = Global.usg0;
    umf  = Global.umf;
    g    = Global.g;
    Di   = Global.Di;
    zg   = Global.zg;
    fw   = Global.fw;
    Emf  = Global.Emf;
    
    db = zeros(length(zg),1); 
    ub = zeros(length(zg),1);
    us = zeros(length(zg),1);
    ue = zeros(length(zg),1);
 alpha = zeros(length(zg),1);
 index = length(zg);
% ---------- Di�metro de burbuja ------------------------------------------  
%   dbo = (3.77*(usg0 - umf)^2)/g;   
    dbo = 0.02;
    dbm = 0.652*((pi/4)*(Di^2)*(usg0-umf))^(0.4);
    for  i = 1:index
         db(i) = dbm-(dbm-dbo)*exp(-0.3*zg(i)/Di);
         ub(i) = (usg0-umf)+0.711*(g*db(i))^(0.5);
        alpha(i) = (usg0-umf)/(ub(i)-umf-umf*fw);
         us(i) = ((fw*alpha(i)*ub(i))/(1-alpha(i)-alpha(i)*fw));
         ue(i) = (umf/Emf)-us(i);
    end
end