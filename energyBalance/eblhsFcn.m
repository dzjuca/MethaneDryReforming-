function eblhs = eblhsFcn(alpha, Global, T, Cgas)
% -------------------------------------------------------------------------
  % eblhsFcn function 
  % ----------------------------| input |----------------------------------
  %   alpha = fraction of bubbles in bed                                 []
  %  Global = constant values structure 
  %       T = temperature                                               [K]
  %    Cgas = concentration vector of each species                [mol/cm3]
  %      fw = fraction of wake in bubbles                                []
  %     Emf = minimum fluidization porosity                              []
  %    Dsol = solid density                                      [g/cm3]
  %     Cpg = gas mixing heat capacity                            [J/mol K]
  %      Cg = gas mixing concentration                            [mol/cm3]
  %     Cps = solid mixing heat capacity                          [J/mol K]
  % ----------------------------| output |---------------------------------
  %   eblhs = left-hand side term                                      [xx]
% -------------------------------------------------------------------------
  fw   = Global.fw;
  Emf  = Global.Emf;
  Dsol = Global.Dcat;
  Cpg  = cpGasMixFcn(Global, Cgas, T);
  Cps  = cpSolMixFcn(Global, T);
  Cg   = cGasMixFcn(Cgas);

  eblhs = ((alpha + alpha*fw*Emf)*Cpg*Cg) + alpha*fw*(1 - Emf)*Dsol*Cps;

end



  %      Cs = solid mixing concentration                          [xxxxx]
  %       M = molar mass                                           [gr/mol]


