function [ub,db,us,ue,alpha]= ubFcn
% Función ubFcn.m permite el cáculo del diámetro y velocidad de burbuja en 
% función de la altura del reactor(z).
% ----------------------------| ENTRADAS |---------------------------------
%     usg0 = velocidad del gas reactante                    [cm/s]
%      umf = velocidad mínima de fluidización               [cm/s]
%        g = aceleración de la gravedad                     [cm/s2]
%       Di = Diámetro interno del reactor                   [cm]
%       zg = Valores del mallado del reactor                [cm]
%       fw = Fracción de la burbuja ocupada por la estela   [  ]
%      Emf = Porosidad mínima de fluidización               [  ]
% ----------------------------| SALIDAS |----------------------------------
%       ub = vector - velocidad de ascenso de la burbuja           [cm/s]
%       db = vector - diámetro de la burbuja                       [cm]
%       us = vector - velocidad de descenso del solido (emulsión)  [cm/s]
%       ue = vector - velocidad del gas en la emulsión             [cm/s]
%    alpha = vector - fracción de burbujas en la fase densa        [  ]
% -------------------------------------------------------------------------
global usg0 umf g Di zg fw Emf
    db = zeros(length(zg),1); 
    ub = zeros(length(zg),1);
    us = zeros(length(zg),1);
    ue = zeros(length(zg),1);
 alpha = zeros(length(zg),1);
 index = length(zg);
% ---------- Diámetro de burbuja ------------------------------------------  
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