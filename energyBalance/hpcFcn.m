function hpc = hpcFcn(alpha, Global, Te, Cgas, db)


    %  u = Initial Flow Rate  [cm/s]

    E          = Global.OHTC.E;
    m          = Global.OHTC.m;
    umf        = Global.umf;
    dp         = Global.dparticle; 
    Dsol       = Global.Dcat;
    Emf        = Global.Emf;
    u          = Global.usg0;
    C_gas_mix  = cGasMixFcn(Cgas);
    Cp_gas_mix = cpGasMixFcn(Global, Cgas, Te);
    Cp_sol_mix = cpSolMixFcn(Global, Te);

    kg = thermalCondMixGasFcn(Global, Te, Cgas);
    ks = thermalCondMixSolFcn(); % ==========================> pendiente de calcular
    ks_kg = ks./kg;
    tmp_1 = 0.28 - 0.757.*log10(E) - 0.057.*log10(ks_kg);
    keo = kg.*(ks_kg)^(tmp_1);

    kmf = keo + 0.1.*C_gas_mix.*Cp_gas_mix.*dp.*umf;
    tmp_2 = Dsol.*(1 - Emf).*Cp_sol_mix;
    tmp_3 = kmf.*tmp_2.*(u - umf)./(pi.*db);
     h1 = 2.*(tmp_3)^(1/2);

%--------------

    h2 = m.*kg./dp;

% ------------------------

    hpc = (1 - alpha)./((1./h1)+(1./h2));
    
end

