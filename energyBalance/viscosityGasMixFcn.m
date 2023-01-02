function viscosityGasMix = viscosityGasMixFcn(Global, T, Cgas )
% -------------------------------------------------------------------------
    % viscosityGasMix-function calculates the viscosity of a mixing gases
    % ----------------------------| input |--------------------------------
    %  Global = constant values structure 
    %       T = phase temperature                                       [K]
    %    Cgas = concentration vector of each species 
    %                                   (bubble|emulsion)         [mol/cm3]
    % ----------------------------| output |-------------------------------
    % mum = viscosity of a mixing gases                           [xxxxx]  % ==================> revisar valor
% -------------------------------------------------------------------------
    k_factor = Global.k_factor;
    n        = Global.gen;
    m        = length(T);
% -------------------------------------------------------------------------
    Tb       = zeros(1,n); 
    Tc       = zeros(1,n); 
    Pc       = zeros(1,n); 
    Vc       = zeros(1,n); 
    mu       = zeros(1,n); 
    M        = zeros(1,n); 
    flds     = fields(Global.Pcr);
% -------------------------------------------------------------------------
    for l = 1:n
        Tb(1,l)  = Global.Tb.(flds{l});
        Tc(1,l)  = Global.Tcr.(flds{l});
        Pc(1,l)  = Global.Pcr.(flds{l});
        Vc(1,l)  = Global.Vc.(flds{l});
        mu(1,l)  = Global.Mu.(flds{l});
        M(1,l)   = Global.MM.(flds{l});
    end
% -------------------------------------------------------------------------
    yi_gas  = molarFractionFcn(Cgas);
    mum_gas = zeros(m, n);

    for i = 1:n

        tmp_1   = zeros(m, n);
        mui_gas = viscosityGasFcn(T, Tb(i), Tc(i), Pc(i), Vc(i), mu(i), ... 
                                      M(i), k_factor);

        for j = 1:n

            tmp_1(:,j) = yi_gas(:,j).*((M(i)./M(j))^(1/2));

        end

        mum_gas(:,i) =  yi_gas(:,i).*mui_gas./sum(tmp_1, 2);
        
    end

    viscosityGasMix = sum(mum_gas, 2);
% -------------------------------------------------------------------------
end