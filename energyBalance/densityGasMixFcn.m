function densityGasMix = densityGasMixFcn(Cgas, MM )

    [m, n]   = size(Cgas);
    fld      = fieldnames(MM);
    mMolar   = zeros(1,n);

    for i = 1:n
        mMolar(i) = MM.(fld{i});
    end

    densityGas_i = zeros(m,n);

    for i = 1:m
        for j = 1:n
            densityGas_i(i,j) = Cgas(i,j) * MM.(fld{j});
        end
    end

    densityGasMix = sum(densityGas_i,2);

end