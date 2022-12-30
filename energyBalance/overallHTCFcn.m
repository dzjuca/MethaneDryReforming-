function U = overallHTCFcn(alpha, Global, Te, Cgas, db)

    hpc = hpcFcn(alpha, Global, Te, Cgas, db);
    hgc = hgcFcn();
    hr  = hrFcn();


    U = hpc + hgc + hr;

end