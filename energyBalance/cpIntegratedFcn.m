function cpIntegrated = cpIntegratedFcn(T, To, R, a)
% -------------------------------------------------------------------------
  % cpIntegrated function 
  % ----------------------------| input |----------------------------------
  %        T =  bubble|emulsion temperature                             [K]
  %       To = standar temperature                                      [K]
  %        R = Universal Gas Constant                             [kJ/molK] 
  %        a = heat capacity constant values                             []
  % ----------------------------| output |---------------------------------
  % cpIntegrated = pure gas heat capacity                          [KJ/mol]
% -------------------------------------------------------------------------

    m = length(a);
    n = length(T);

    cpInt_i = zeros(n, m);

    for i = 1:m 

        cpInt_i(:,i) = (a(i)./i).*(T.^(i) - To.^(i));

    end

    cpIntegrated = R.*sum(cpInt_i, 2);

% -------------------------------------------------------------------------
end








