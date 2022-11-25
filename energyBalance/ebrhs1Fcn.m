function ebrhs1 = ebrhs1Fcn(alpha, Global, Cgas, T, ubes)
% -------------------------------------------------------------------------
  % ebrhs1 function 
  % ----------------------------| input |----------------------------------
  %   alpha = fraction of bubbles in bed                                 []
  %  Global = constant values structure 
  %    Cgas = concentration vector of each species                [mol/cm3]
  %       T = temperature                                               [K]
  %    ubes = velocity (gas-bubble/gas-emulsion/solid)               [cm/s]
  %      fw = fraction of wake in bubbles                                []
  %     Emf = minimum fluidization porosity                              []
  %    Dsol = solid density                                         [g/cm3]
  %      zg = height for each mesh point                               [cm]
  %     Cpg = gas mixing heat capacity                            [J/mol K]
  %     Cps = solid mixing heat capacity                        [J/g-cat K]
  %      Cg = gas mixing concentration                            [mol/cm3]
  %      zl = lower boundary value of T                                  []
  %      zu = upper boundary value of T                                  []
  %       n = number of grid points in the z domain including the
  %           boundary points                                            []                        
  % ----------------------------| output |---------------------------------
  %  ebrhs1 = right-hand side term-1                              [J/cm3 s]
% -------------------------------------------------------------------------
    fw   = Global.fw;
    Emf  = Global.Emf;
    Dsol = Global.Dcat;
    zg   = Global.zg; 
    Cpg  = cpGasMixFcn(Global, Cgas, T);
    Cps  = cpSolMixFcn(Global, T);
    Cg   = cGasMixFcn(Cgas);
    zl   = zg(1);
    zu   = zg(end);
    n    = length(zg);

    temporal_1 = ((alpha + alpha.*fw.*Emf).*Cpg.*Cg.*ubes);
    temporal_2 = (alpha.*fw.*(1 - Emf).*Dsol.*ubes.*Cps);
          dTdz = dss004(zl,zu,n,T)';
    ebrhs1     = (temporal_1 + temporal_2).*dTdz;
% -------------------------------------------------------------------------

end