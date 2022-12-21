function eblhs = eblhsFcn(alpha, Global, Cgas, T, identifier)
% -------------------------------------------------------------------------
  % eblhsFcn function 
  % ----------------------------| input |----------------------------------
  %       alpha = fraction of bubbles in bed                             []
  %      Global = constant values structure 
  %        Cgas = concentration vector of each species            [mol/cm3]
  %           T = temperature                                           [K]
  %  identifier = phase identifier (bubble|emulsion)                     []
  % -----
  %      fw = fraction of wake in bubbles                                []
  %     Emf = minimum fluidization porosity                              []
  %    Dsol = solid density                                         [g/cm3]
  %     gen = gas species number                                         []
  %     Cpg = gas mixing heat capacity                            [J/mol K]
  %     Cps = solid mixing heat capacity                        [J/g-cat K]
  %      Cg = gas mixing concentration                            [mol/cm3]
  % ----------------------------| output |---------------------------------
  %   eblhs = left-hand side term                                 [J/cm3 K]
% -------------------------------------------------------------------------
  fw   = Global.fw;
  Emf  = Global.Emf;
  Dsol = Global.Dcat;
  gen  = Global.gen;
  Cpg  = cpGasMixFcn(Global, Cgas(:,1:gen), T);
  Cps  = cpSolMixFcn(Global, T);
  Cg   = cGasMixFcn(Cgas(:,1:gen));

  if strcmp( identifier, 'bubble')

    eblhs = ((alpha + alpha.*fw.*Emf).*Cpg.*Cg) + ...
              alpha.*fw.*(1 - Emf).*Dsol.*Cps;

  elseif strcmp( identifier, 'emulsion')

    eblhs = ((1 - alpha - alpha.*fw).*Emf.*Cpg.*Cg) + ...
            ((1 - alpha - alpha.*fw).*(1 - Emf).*Dsol.*Cps);

  else

    disp('Error - eblhsFcn function - identifier ')

  end
% -------------------------------------------------------------------------
end


