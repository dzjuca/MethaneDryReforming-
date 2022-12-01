function cpGas = cpGasFcn(T, R, a)
% -------------------------------------------------------------------------
    % cpGasFcn - function, calculate the heat capacity for a pure specie
    % ----------------------------| input |--------------------------------
    % T = Temperature                                                   [K]
    % R = Universal Gas Constant                                   [J/molK] 
    % a = heat capacity constant values                                  []
    % ----------------------------| output |-------------------------------
    % cpGas = pure gas heat capacity                              [J/mol K]
% -------------------------------------------------------------------------


    cpGas = R*(a(1) + a(2).*T + a(3).*T.^2 + a(4).*T.^3 + a(5).*T.^4);


% -------------------------------------------------------------------------
end