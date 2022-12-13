function ebrhs3 = ebrhs3Fcn(alpha, Global, Tbe)
% -------------------------------------------------------------------------
  % ebrhs3 function 
  % ----------------------------| input |----------------------------------
  %   alpha = fraction of bubbles in bed                                 []
  %  Global = constant values structure 
  %     Tbe = bubble|emulsion temperature                               [K]
  % -----
  %      fw = fraction of wake in bubbles                                []
  %     Emf = minimum fluidization porosity                              []
  %    Dsol = solid density                                         [g/cm3]
  %      nR = number of reactions                                        []
  %      To = standar temperature = 298                                 [K]
  %       n = number of grid points in the z domain including the
  %           boundary points                                            []



  % ----------------------------| output |---------------------------------
  %  ebrhs3 = right-hand side term-3                              [J/s cm3]
% -------------------------------------------------------------------------

  fw      = Global.fw;
  Emf     = Global.Emf;
  Dsol    = Global.Dcat;
  nR      = Global.HR.nReactions;
  nPoints = Global.n;

  heatReaction = zeros(nPoints, nR);
  kinetic      = zeros(nPoints, nR);
  r_fields     = fields(Global.HR.reactions);

  for i = 1:nR

    reaction = Global.HR.reactions.(r_fields{i});
    heatReaction(:, i) = heatReactionFcn(reaction, To, Tbe);
         kinetic(:, i) = kineticFcn();

  end

  temporal_1 = sum((heatReaction.*kinetic),2);
      ebrhs3 = alpha.*fw.*(1 - Emf).*temporal_1.*Dsol;

end
