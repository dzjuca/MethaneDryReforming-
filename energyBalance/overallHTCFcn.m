function U = overallHTCFcn()

    hpc = hpcFcn();
    hgc = hgcFcn();
    hr  = hrFcn();


    U = hpc + hgc + hr;

end