function cpGasMix = cpGasMixFcn(Global, Cg, T)
% -------------------------------------------------------------------------
  % cpGasMix function 
  % ----------------------------| input |----------------------------------
  %   Global = constant values structure 
  %       Cg = gas mixing concentration                           [mol/cm3]
  %        T = Temperature                                              [K]
  %        R = Universal Gas Constant                             [kJ/molK] 
  % ----------------------------| output |---------------------------------
  % cpGasMix = gas mixing heat capacity                           [J/mol K]
% -------------------------------------------------------------------------
    R      = Global.R*1000;
    HCC    = Global.HCC;
    flds   = fields(HCC);
    [m, ~] = size(flds);
    cp_i   = zeros(m);
    y_i    = molarFractionFcn(Cg);

    for i=1:m

            a = Global.HCC.(flds{i});
      cp_i(i) = R*(a(1) + a(2)*T + a(3)*T^2 + a(4)*T^3 + a(5)*T^4);

    end

    cpGasMix = sum(cp_i.*y_i);
% -------------------------------------------------------------------------
end