function f = opTemperatureFcn(T, u, alpha, Cgas, Global)

    fw  = Global.fw;
    Emf = Global.Emf;
    Cpg = cpGasMixFcn(Globa, Cgas, T);
    Cg  = cGasMixFcn;

    f = (alpha + alpha.*fw.*Emf).*Cpg.*Cg.*T - u;


end