function hgc = hgcFcn(Global, db, kg)

    dp    = Global.dparticle;
    Ar    = arquimedesFcn();
    tmp_1 = 0.3.*((Ar).^(0.39)).*kg;
    tmp_2 = (dp.*db)^(1/2);

    hgc   = tmp_1./tmp_2;

end