function ebrhs4 = ebrhs4Fcn(alpha, Global, Cgas_b, Cgas_e, Tb, Te, ub)
% -------------------------------------------------------------------------
  % ebrhs4Fcn function computes the right-hand side term-4 of the energy
  % balance equation for the bubble phase. 
  % ----------------------------| input |----------------------------------
  %   alpha = fraction of bubbles in bed                                 []
  %  Global = constant values structure 
  %  Cgas_b = concentration vector of each species (bubble)       [mol/cm3]
  %  Cgas_e = concentration vector of each species (emulsion)     [mol/cm3]
  %      Tb = bubble temperature                                        [K]
  %      Te = emulsion temperature                                      [K]
  %      ub = bubble velocity                                        [cm/s]
  % -----
  %      fw = fraction of wake in bubbles                                []
  %     Emf = minimum fluidization porosity                              []
  %     gen = gas species number                                         []
  %    Dsol = solid density                                         [g/cm3]
  %      zg = height for each mesh point                               [cm]
  %     Cpg = gas mixing heat capacity                            [J/mol K]
  %     Cps = solid mixing heat capacity                        [J/g-cat K]
  %      Cg = gas mixing concentration                            [mol/cm3]
  %      zl = lower boundary value of T                                  []
  %      zu = upper boundary value of T                                  []
  %       n = number of grid points in the z domain including the
  %           boundary points                                            [] 
  %     gen = gas species number                                         []
  % ----------------------------| output |---------------------------------
  %  ebrhs4 = right-hand side term-4                              [J/s cm3]
% -------------------------------------------------------------------------
    fw    = Global.fw;
    Emf   = Global.Emf;
    gen   = Global.gen;
    zg    = Global.zg; 
    Cg_b  = cGasMixFcn(Cgas_b(:,1:gen));
    Cg_e  = cGasMixFcn(Cgas_e(:,1:gen));
    Cpg_b = cpGasMixFcn(Global, Cgas_b(:,1:gen), Tb);
    Cpg_e = cpGasMixFcn(Global, Cgas_e(:,1:gen), Te);
    zl    = zg(1);
    zu    = zg(end);
    n     = Global.n;
    v     = 1; 

    temporal_1     = (alpha + alpha.*fw.*Emf).*ub;
    % dtemporal_1dz  = dss020(zl,zu,n,temporal_1, v)';
    dtemporal_1dz  = dss012(zl,zu,n,temporal_1, v);
    index          = find(dtemporal_1dz < 0);
    lambda1        = zeros(n,1);
    lambda2        = ones(n,1);
    lambda1(index) = 1;
    lambda2(index) = 0;

    temporal_2     = lambda1.*Tb.*Cpg_b.*Cg_b;
    temporal_3     = lambda2.*Te.*Cpg_e.*Cg_e;

    ebrhs4         = (temporal_2 + temporal_3).*dtemporal_1dz;
% -------------------------------------------------------------------------
end