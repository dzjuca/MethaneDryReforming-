function eblhs = eblhsFcn(alpha, Global, Cgas, T)
% -------------------------------------------------------------------------
  % eblhsFcn function 
  % ----------------------------| input |----------------------------------
  %   alpha = fraction of bubbles in bed                                 []
  %  Global = constant values structure 
  %    Cgas = concentration vector of each species                [mol/cm3]
  %       T = temperature                                               [K]
  %      fw = fraction of wake in bubbles                                []
  %     Emf = minimum fluidization porosity                              []
  %    Dsol = solid density                                      [g/cm3]
  %     Cpg = gas mixing heat capacity                            [J/mol K]
  %     Cps = solid mixing heat capacity                        [J/g-cat K]
  %      Cg = gas mixing concentration                            [mol/cm3]
  % ----------------------------| output |---------------------------------
  %   eblhs = left-hand side term                                 [J/cm3 K]
% -------------------------------------------------------------------------
  fw   = Global.fw;
  Emf  = Global.Emf;
  Dsol = Global.Dcat;
  Cpg  = cpGasMixFcn(Global, Cgas, T);
  Cps  = cpSolMixFcn(Global, T);
  Cg   = cGasMixFcn(Cgas);

  eblhs = ((alpha + alpha.*fw.*Emf).*Cpg.*Cg) + ...
            alpha.*fw.*(1 - Emf).*Dsol.*Cps;
% -------------------------------------------------------------------------
end


