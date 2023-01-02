function U = overallHTCFcn(alpha, Global, T, Cgas, db)

    hpc = hpcFcn(alpha, Global, T, Cgas, db);
    hgc = hgcFcn(Global, T, Cgas, db);
    hr  = hrFcn();


    U = hpc + hgc + hr;

end