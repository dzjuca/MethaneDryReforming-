function viscosityGasMix = viscosityGasMixFcn(Global, T, Cgas )

    n       = 6;
    m       = length(T);
    yi_gas  = molarFractionFcn(Cgas);

    M       = [1, 2, 3, 4, 5, 6];
    Tb =[];
    Tc =[];
    Pc =[];
    mu = [];
    Vc = [];

    mum_gas = zeros(m, n);

    for i = 1:n

        tmp_1   = zeros(m, n);
        mui_gas = viscosityGasFcn(Tb(i), Tc(i), Pc(i), mu(i), Vc(i), M(i), T);

        for j = 1:n

            tmp_1(:,j) = yi_gas(:,j).*((M(i)./M(j))^(1/2));

        end

        mum_gas(:,i) =  yi_gas(:,i).*mui_gas./sum(tmp_1, 2);
        
    end

    viscosityGasMix = sum(mum_gas, 2);

end