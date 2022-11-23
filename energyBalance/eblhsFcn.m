function eblhs = eblhsFcn(alpha, Global)
% -------------------------------------------------------------------------
  % eblhsFcn function 
  % ----------------------------| input |----------------------------------
  %   alpha = fraction of bubbles in bed                                 []
  %      fw = fraction of wake in bubbles                                []
  %     Emf = minimum fluidization porosity                              []
  %    Dsol = solid density                                      [g/cm3]
  %  Global = constant values structure 
  %     Cpg = gas mixing heat capacity                            [J/mol K]
  %      Cg = gas mixing concentration                            [mol/cm3]
  %     Cps = solid mixing heat capacity                          [J/mol K]
  % ----------------------------| output |---------------------------------
  %   eblhs = left-hand side term                                      [xx]
% -------------------------------------------------------------------------
  fw   = Global.fw;
  Emf  = Global.Emf;
  Dsol = Global.Dcat;
  Cpg  = cpGasMixFcn(Global);
  Cps  = cpSolMixFcn();
  Cg   = cGasMixFcn();

  eblhs = ((alpha + alpha*fw*Emf)*Cpg*Cg) + alpha*fw*(1 - Emf)*Dsol*Cps;

end



  %      Cs = solid mixing concentration                          [xxxxx]
  %       M = molar mass                                           [gr/mol]


