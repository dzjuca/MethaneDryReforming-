function heatReaction = heatReactionFcn(reaction, To, T, R, hcc)
% -------------------------------------------------------------------------
  % heatReaction function 
  % ----------------------------| input |----------------------------------
  % reaction = reaction-values structure                                 []
  %       To = standar temperature                                      [K]
  %        T =  bubble|emulsion temperature                             [K]
  %        R = Universal Gas Constant                             [kJ/molK] 
  %      hcc = heat capacity constants for gas species                   []
  % -----
  % ----------------------------| output |---------------------------------
  %  heatReaction = heat reaction                              [ xxxxx]
% -------------------------------------------------------------------------
    r    = reaction.nReactans;
    p    = reaction.nProducts;
    stqR = reaction.stqReactants;
    stqP = reaction.stqProducts;
    reactants = reaction.reactants;
    products  = reaction.products;
    standarHR = reaction.standarHR;


    speciesStateReactants = reaction.speciesStateReactants;
    speciesStateProducts  = reaction.speciesStateProducts;

    if (speciesStateReactants == speciesStateProducts)






    else


    end






    heatReaction = 0;

% -------------------------------------------------------------------------
end