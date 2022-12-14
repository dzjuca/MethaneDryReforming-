function heatReaction = heatReactionFcn(reaction, To, T, R, hcc)
% -------------------------------------------------------------------------
  % heatReaction function 
  % ----------------------------| input |----------------------------------
  % reaction = reaction-values structure                                 []
  %       To = standar temperature                                      [K]
  %        T =  bubble|emulsion temperature                             [K]
  %        R = Universal Gas Constant                            [kJ/mol K] 
  %      hcc = heat capacity constants for each species                  []
  % -----


  
  % ----------------------------| output |---------------------------------
  %  heatReaction = heat reaction                                   [J/mol]
% -------------------------------------------------------------------------
    r         = reaction.nReactans;
    p         = reaction.nProducts;
    stqR      = reaction.stqReactants;
    stqP      = reaction.stqProducts;
    reactants = reaction.reactants;
    products  = reaction.products;
    standarHR = reaction.standarHR;


    n = length(T);
    cpIntegrated_n_r = zeros(n, r);
    cpIntegrated_n_p = zeros(n, p);

    for i = 1:r 

      a = hcc.(reactants{i});
      cpIntegrated_n_r(:,i) = cpIntegratedFcn(T, To, R, a).*stqR(i);

    end

    for j = 1:p

      a = hcc.(products{j});
      cpIntegrated_n_p(:,j) = cpIntegratedFcn(T, To, R, a).*stqP(j);

    end

    deltaCp      = sum(cpIntegrated_n_p, 2) - sum(cpIntegrated_n_r, 2);
    heatReaction = (standarHR + deltaCp).*1000;

% -------------------------------------------------------------------------
end