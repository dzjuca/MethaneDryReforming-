function ebrhs3 = ebrhs3Fcn(alpha, Global, Cgas, Tbe, identifier)
% -------------------------------------------------------------------------
  % ebrhs3 function 
  % ----------------------------| input |----------------------------------
  %       alpha = fraction of bubbles in bed                             []
  %      Global = constant values structure 
  %        Cgas = a vector with all concentrations species 
  %               bubble|emulsion                                 [mol/cm3] 
  %         Tbe = bubble|emulsion temperature                           [K]
  %  identifier = phase identifier (bubble|emulsion)                     []
  % -----
  %      fw = fraction of wake in bubbles                                []
  %     Emf = minimum fluidization porosity                              []
  %    Dsol = solid density                                         [g/cm3]
  %      nR = number of reactions                                        []
  %      To = standar temperature = 298                                 [K]
  % nPoints = number of grid points in the z domain including the
  %           boundary points                                            []
  %       R = Universal Gas Constant                              [kJ/molK] 
  % ----------------------------| output |---------------------------------
  %  ebrhs3 = right-hand side term-3                              [J/s cm3]
% -------------------------------------------------------------------------

  fw           = Global.fw;
  Emf          = Global.Emf;
  Dsol         = Global.Dcat;
  nR           = Global.HR.nReactions;
  To           = Global.HR.To;
  nPoints      = Global.n;
  R            = Global.R;
  hcc          = Global.HR.HCC;
  heatReaction = zeros(nPoints, nR);
  kinetic      = zeros(nPoints, nR);
  r_fields     = fields(Global.HR.reactions);

  for i = 1:nR

    reaction = Global.HR.reactions.(r_fields{i});
    heatReaction(:, i) = heatReactionFcn(reaction, To, Tbe, R, hcc);
         kinetic(:, i) = CineticaFcn(Cgas, Global, Tbe, r_fields{i});

  end

  temporal_1 = sum((heatReaction.*kinetic),2);

  if strcmp( identifier, 'bubble')

    temporal_2 = alpha.*fw.*(1 - Emf).*Dsol;

  elseif strcmp( identifier, 'emulsion')

    temporal_2 = (1 - alpha - alpha.*fw).*(1 - Emf).*Dsol;

  else

    disp('Error - ebrhs1Fcn function - identifier')

  end

  ebrhs3 = temporal_1.*temporal_2;
% -------------------------------------------------------------------------
end
