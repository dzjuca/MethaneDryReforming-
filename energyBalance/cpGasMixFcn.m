function cpGasMix = cpGasMixFcn(Global, Cgas, T)
% -------------------------------------------------------------------------
  % cpGasMix function 
  % ----------------------------| input |----------------------------------
  %   Global = constant values structure 
  %     Cgas = vector with concentration for each species         [mol/cm3]
  %        T = Temperature                                              [K]
  %        R = Universal Gas Constant                             [kJ/molK] 
  % ----------------------------| output |---------------------------------
  % cpGasMix = gas mixing heat capacity                           [J/mol K]
% -------------------------------------------------------------------------

    R      = Global.R*1000;
    HCC    = Global.HCC;
    flds   = fields(HCC);
    [m, ~] = size(flds);
    [j, ~] = size(Cgas);
    cp_i   = zeros(j,m);
    y_i    = molarFractionFcn(Cgas(:,1:m));

    for i = 1:m

              a = Global.HCC.(flds{i});
      cp_i(:,i) = cpGasFcn(T, R, a);

    end

    cpGasMix = sum(cp_i.*y_i,2);
% -------------------------------------------------------------------------
end