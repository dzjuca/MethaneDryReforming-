function ebrhs5 = ebrhs5Fcn(alpha, Global, Tb, Te, ub)
% -------------------------------------------------------------------------
  % ebrhs5Fcn function 
  % ----------------------------| input |----------------------------------
  %   alpha = fraction of bubbles in bed                                 []
  %  Global = constant values structure 
  %      Tb = bubble temperature                                        [K]
  %      Te = emulsion temperature                                      [K]
  %      ub = bubble velocity                                        [cm/s]
  % -----
  %       fw = fraction of wake in bubbles                               []
  %      Emf = minimum fluidization porosity                             []
  %     Dsol = solid density                                        [g/cm3]
  %       zg = height for each mesh point                              [cm]
  %       zl = lower boundary value of T                                 []
  %       zu = upper boundary value of T                                 []
  %        n = number of grid points in the z domain including the
  %            boundary points                                           []
  %    Cps_b = solid mixing heat capacity | bubble              [J/g-cat K]
  %    Cps_e = solid mixing heat capacity | emulsion            [J/g-cat K]
  % ----------------------------| output |---------------------------------
  %  ebrhs5 = right-hand side term-5                              [J/s cm3]
% -------------------------------------------------------------------------

    fw    = Global.fw;
    Emf   = Global.Emf;
    Dsol  = Global.Dcat;
    zg    = Global.zg; 
    zl    = zg(1);
    zu    = zg(end);
    n     = Global.n;
    Cps_b = cpSolMixFcn(Global, Tb);
    Cps_e = cpSolMixFcn(Global, Te);

    temporal_1     = (ub.*alpha.*fw.*(1 - Emf).*Dsol);
    dtemporal_1dz  = dss004(zl,zu,n,temporal_1)'; 
    index          = find(dtemporal_1dz < 0);
    lambda1        = zeros(n,1);
    lambda2        = ones(n,1);
    lambda1(index) = 1;
    lambda2(index) = 0;

    temporal_2 = lambda1.*Tb.*Cps_b;
    temporal_3 = lambda2.*Te.*Cps_e;
    ebrhs5     = (temporal_2 + temporal_3).*dtemporal_1dz;
% -------------------------------------------------------------------------
end