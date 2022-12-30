function arquimedes = arquimedesFcn(Global, Cgas)

 % Gravity                    [cm/s2]
    g          = Global.g; 
    dp         = Global.dparticle;
    Dsol       = Global.Dcat;
    C_gas_mix  = cGasMixFcn(Cgas);
    mu_gas_mix = viscosityGasMixFcn();

    tmp_1 = g.*(dp^3).*(Dsol - C_gas_mix).*C_gas_mix;
    tmp_2 = mu_gas_mix.^2;


    arquimedes = (tmp_1./tmp_2);
    
end