function ebrhs1 = ebrhs1Fcn(alpha, Global, Cgas, T, ubes, identifier)
% -------------------------------------------------------------------------
  % ebrhs1 function 
  % ----------------------------| input |----------------------------------
  %   alpha = fraction of bubbles in bed                                 []
  %  Global = constant values structure 
  %    Cgas = concentration vector of each species                [mol/cm3]
  %       T = temperature                                               [K]
  %    ubes = velocity (gas-bubble/gas-emulsion/solid)               [cm/s]
  %  identifier = phase identifier (bubble|emulsion)                     []
  % -----
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
  %     gen = gas species number                                         []
  % ----------------------------| output |---------------------------------
  %  ebrhs1 = right-hand side term-1                              [J/s cm3]
% -------------------------------------------------------------------------
    fw   = Global.fw;
    Emf  = Global.Emf;
    Dsol = Global.Dcat;
    zg   = Global.zg; 
    gen  = Global.gen;
    Cpg  = cpGasMixFcn(Global, Cgas(:,1:gen), T);
    Cps  = cpSolMixFcn(Global, T);
    Cg   = cGasMixFcn(Cgas(:,1:gen));
    zl   = zg(1);
    zu   = zg(end);
    n    = length(zg);

    if strcmp( identifier, 'bubble')

      temporal_1 = ((alpha + alpha.*fw.*Emf).*Cpg.*Cg.*ubes);
      temporal_2 = (alpha.*fw.*(1 - Emf).*Dsol.*ubes.*Cps);
      temporal_3 = (temporal_1 + temporal_2).*T;
      v          = 1;
      dTdz       = dss020(zl,zu,n,temporal_3,v)';

    elseif strcmp( identifier, 'emulsion')

      temporal_1 = ((1 - alpha - alpha.*fw).*Emf.*Cpg.*Cg.*ubes(:,1)).*T;
      v1         = 1;
      dTdz_1     = dss020(zl,zu,n,temporal_1, v1)';
      temporal_2 = ((1 - alpha - alpha.*fw).*(1 - Emf).*Cps.*Dsol.*ubes(:,2)).*T;
      v2         = -1;
      dTdz_2     = dss020(zl,zu,n,temporal_2, v2)';
      
      dTdz       = dTdz_1 - dTdz_2;

    else
  
      disp('Error - ebrhs1Fcn function - identifier')
  
    end
    
    ebrhs1       = dTdz;
% -------------------------------------------------------------------------
end