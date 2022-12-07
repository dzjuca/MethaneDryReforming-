function ut = pdeFcn(t,u,Global)
% -------------------------------------------------------------------------
  % pdeFcn function define the EDOs for the numerical solution with 
  % the method of lines
  % ----------------------------| input |----------------------------------
  %       t = interval of integration, specified as a vector
  %       u = time-dependent terms, specified as a vector
  %  Global = constant values structure 
  % ----------------------------| output |---------------------------------
  %      ut =  time-dependent terms variation, specified as a vector
% -------------------------------------------------------------------------
% --------------------| constants values |---------------------------------
global ncall 


    persistent ncall_2
    if isempty(ncall_2)
        ncall_2 = 0;
    end



    zg      = Global.zg;
    fw      = Global.fw;
    Emf     = Global.Emf;
    CH4in   = Global.CH4in;
    CO2in   = Global.CO2in;
    N2in    = Global.N2in;
    Num_esp = Global.Num_esp;
    Dcat    = Global.Dcat;
    Tinlet  = Global.Tinlet;
% --------------------| Variables Initial Configuration |------------------
% ---------- non-negative values check ------------------------------------
    index1  = length(zg);
    for i = 1:index1*Num_esp
        if u(i) < 0,    u(i) = 0; end
    end
% ---------- gas - bubble & wake phases------------------------------------
    u1b = zeros(index1,1); u2b = zeros(index1,1); 
    u3b = zeros(index1,1); u4b = zeros(index1,1); 
    u5b = zeros(index1,1); u6b = zeros(index1,1);
% ---------- gas - emulsion phase -----------------------------------------
    u1e = zeros(index1,1); u2e = zeros(index1,1); 
    u3e = zeros(index1,1); u4e = zeros(index1,1); 
    u5e = zeros(index1,1); u6e = zeros(index1,1);
% ---------- solid - wake phase -------------------------------------------
    u7w = zeros(index1,1); 
% ---------- solid - emulsion phase ---------------------------------------
    u7e = zeros(index1,1); 
% ---------- temperature - bubble & wake phases ---------------------------
    u8b = zeros(index1,1); 
% ---------- temperature - emulsion phase ---------------------------------
    u8e = zeros(index1,1); 
% ---------- assigning values to each variable |---------------------------
    for i = 1:(index1), u1b(i) = u(i+0*(index1));end  % u1b = CH4 bubble 
    for i = 1:(index1), u2b(i) = u(i+1*(index1));end  % u2b = CO2 bubble 
    for i = 1:(index1), u3b(i) = u(i+2*(index1));end  % u3b = CO  bubble
    for i = 1:(index1), u4b(i) = u(i+3*(index1));end  % u4b = H2  bubble
    for i = 1:(index1), u5b(i) = u(i+4*(index1));end  % u5b = H20 bubble
    for i = 1:(index1), u6b(i) = u(i+5*(index1));end  % u6b = N2  bubble
    for i = 1:(index1), u1e(i) = u(i+6*(index1));end  % u1e = CH4 emulsion
    for i = 1:(index1), u2e(i) = u(i+7*(index1));end  % u2e = CO2 emulsion
    for i = 1:(index1), u3e(i) = u(i+8*(index1));end  % u3e = CO  emulsion
    for i = 1:(index1), u4e(i) = u(i+9*(index1));end  % u4e = H2  emulsion
    for i = 1:(index1), u5e(i) = u(i+10*(index1));end % u5e = H2O emulsion
    for i = 1:(index1), u6e(i) = u(i+11*(index1));end % u6e = N2  emulsion
    for i = 1:(index1), u7w(i) = u(i+12*(index1));end % u7w = Cc  wake
    for i = 1:(index1), u7e(i) = u(i+13*(index1));end % u7e = Cc  emulsion
    for i = 1:(index1), u8b(i) = u(i+14*(index1));end % u8b = T   bubble
    for i = 1:(index1), u8e(i) = u(i+15*(index1));end % u8e = T   emulsion
% --------------------| Boundary Conditions 1 |----------------------------
% ---------- z = 0 gas - bubble & wake phase ------------------------------
    u1b(1) = CH4in; u2b(1) = CO2in; u3b(1) = 0.000; 
    u4b(1) = 0.000; u5b(1) = 0.000; u6b(1) = N2in;
% ---------- z = 0 gas - emulsion phase -----------------------------------
    u1e(1) = CH4in; u2e(1) = CO2in; u3e(1) = 0.000;
    u4e(1) = 0.000; u5e(1) = 0.000; u6e(1) = N2in;
% ---------- z = 0 solid - wake & emulsion phases -------------------------
    u7w(1) = u7e(1);
% ---------- z = 0 temperature - bubble & wake phases ---------------------
    u8b(1) = Tinlet;
% ---------- z = 0 temperature - emulsion phase ---------------------------
    u8e(1) = Tinlet;
% ---------- z = Zg solid - wake & emulsion phases ------------------------
    u7e(index1) = u7w(index1);
% --------------------| Fluidized Bed |------------------------------------   
% ---------- bubble - ubFcn.m ---------------------------------------------
    [ub,db,us,ue,alpha] = ubFcn(Global);    
% ---------- concentrations' vector ---------------------------------------
    CTBW = [u1b,u2b,u3b,u4b,u5b,u6b,u7w];
    CTE  = [u1e,u2e,u3e,u4e,u5e,u6e,u7e];
% --------------------| Mass Balance - Gas - Bubble & Wake Phase | --------
% ----- constant value ----------------------------------------------------
    FC1 = 1./(alpha + fw*alpha*Emf);
% ----- CH4 species -------------------------------------------------------
    u1bt = -(RH1Fcn(alpha,ub,u1b,Global,'FGBurbuja')).*FC1              ...
           +(RH2Fcn(alpha,ub,u1b,u1e,Global,'FGas')).*FC1               ... 
           -(RH3Fcn(alpha,db,ub,u1b,u1e,CTBW,Global,'FGas','CH4')).*FC1 ...
           +(RH4Fcn(alpha,CTBW,Global,'FGBurbuja','CH4')).*FC1;
% ----- CO2 species -------------------------------------------------------
    u2bt = -(RH1Fcn(alpha,ub,u2b,Global,'FGBurbuja')).*FC1              ...
           +(RH2Fcn(alpha,ub,u2b,u2e,Global,'FGas')).*FC1               ... 
           -(RH3Fcn(alpha,db,ub,u2b,u2e,CTBW,Global,'FGas','CO2')).*FC1 ...
           +(RH4Fcn(alpha,CTBW,Global,'FGBurbuja','CO2')).*FC1;
% ----- CO species --------------------------------------------------------
    u3bt = -(RH1Fcn(alpha,ub,u3b,Global,'FGBurbuja')).*FC1              ...
           +(RH2Fcn(alpha,ub,u3b,u3e,Global,'FGas')).*FC1               ... 
           -(RH3Fcn(alpha,db,ub,u3b,u3e,CTBW,Global,'FGas','CO')).*FC1  ...
           +(RH4Fcn(alpha,CTBW,Global,'FGBurbuja','CO')).*FC1;
% ----- H2 species --------------------------------------------------------
    u4bt = -(RH1Fcn(alpha,ub,u4b,Global,'FGBurbuja')).*FC1              ...
           +(RH2Fcn(alpha,ub,u4b,u4e,Global,'FGas')).*FC1               ... 
           -(RH3Fcn(alpha,db,ub,u4b,u4e,CTBW,Global,'FGas','H2')).*FC1  ...
           +(RH4Fcn(alpha,CTBW,Global,'FGBurbuja','H2')).*FC1;
% ----- H2O species -------------------------------------------------------
    u5bt = -(RH1Fcn(alpha,ub,u5b,Global,'FGBurbuja')).*FC1              ...
           +(RH2Fcn(alpha,ub,u5b,u5e,Global,'FGas')).*FC1               ... 
           -(RH3Fcn(alpha,db,ub,u5b,u5e,CTBW,Global,'FGas','H2O')).*FC1 ...
           +(RH4Fcn(alpha,CTBW,Global,'FGBurbuja','H2O')).*FC1;
% ----- N2 species --------------------------------------------------------
    u6bt = -(RH1Fcn(alpha,ub,u6b,Global,'FGBurbuja')).*FC1              ...
           +(RH2Fcn(alpha,ub,u6b,u6e,Global,'FGas')).*FC1               ... 
           -(RH3Fcn(alpha,db,ub,u6b,u6e,CTBW,Global,'FGas','N2')).*FC1  ...
           +(RH4Fcn(alpha,CTBW,Global,'FGBurbuja','N2')).*FC1;
% --------------------| Mass Balance - Gas - Emulsion Phase |--------------
% ----- constant value ----------------------------------------------------
    FC2 = 1./((1-alpha-alpha*fw)*Emf);
% ----- CH4 species -------------------------------------------------------
    u1et = -(RH1Fcn(alpha,ue,u1e,Global,'FGEmulsion')).*FC2             ...
           -(RH2Fcn(alpha,ub,u1b,u1e,Global,'FGas')).*FC2               ...
           +(RH3Fcn(alpha,db,ub,u1b,u1e,CTBW,Global,'FGas','CH4')).*FC2 ...
           +(RH4Fcn(alpha,CTE,Global,'FGEmulsion','CH4')).*FC2;
% ----- CO2 species -------------------------------------------------------
    u2et = -(RH1Fcn(alpha,ue,u2e,Global,'FGEmulsion')).*FC2             ...
           -(RH2Fcn(alpha,ub,u2b,u2e,Global,'FGas')).*FC2               ...
           +(RH3Fcn(alpha,db,ub,u2b,u2e,CTBW,Global,'FGas','CO2')).*FC2 ...
           +(RH4Fcn(alpha,CTE,Global,'FGEmulsion','CO2')).*FC2;
% ----- CO species --------------------------------------------------------
    u3et = -(RH1Fcn(alpha,ue,u3e,Global,'FGEmulsion')).*FC2             ...
           -(RH2Fcn(alpha,ub,u3b,u3e,Global,'FGas')).*FC2               ...
           +(RH3Fcn(alpha,db,ub,u3b,u3e,CTBW,Global,'FGas','CO')).*FC2  ...
           +(RH4Fcn(alpha,CTE,Global,'FGEmulsion','CO')).*FC2;
% ----- H2 species --------------------------------------------------------
    u4et = -(RH1Fcn(alpha,ue,u4e,Global,'FGEmulsion')).*FC2             ...
           -(RH2Fcn(alpha,ub,u4b,u4e,Global,'FGas')).*FC2               ...
           +(RH3Fcn(alpha,db,ub,u4b,u4e,CTBW,Global,'FGas','H2')).*FC2  ...
           +(RH4Fcn(alpha,CTE,Global,'FGEmulsion','H2')).*FC2;
% ----- H2O species -------------------------------------------------------
    u5et = -(RH1Fcn(alpha,ue,u5e,Global,'FGEmulsion')).*FC2             ...
           -(RH2Fcn(alpha,ub,u5b,u5e,Global,'FGas')).*FC2               ...
           +(RH3Fcn(alpha,db,ub,u5b,u5e,CTBW,Global,'FGas','H2O')).*FC2 ...
           +(RH4Fcn(alpha,CTE,Global,'FGEmulsion','H2O')).*FC2;
% ----- N2 species --------------------------------------------------------
    u6et = -(RH1Fcn(alpha,ue,u6e,Global,'FGEmulsion')).*FC2             ...
           -(RH2Fcn(alpha,ub,u6b,u6e,Global,'FGas')).*FC2               ...
           +(RH3Fcn(alpha,db,ub,u6b,u6e,CTBW,Global,'FGas','N2')).*FC2  ...
           +(RH4Fcn(alpha,CTE,Global,'FGEmulsion','N2')).*FC2;
% --------------------| Mass Balance - Solid - Wake Phase |----------------
% ----- constant value ----------------------------------------------------
    FC3 = 1./((alpha*fw)*(1-Emf)*Dcat);
% ----- Coke species ------------------------------------------------------
    u7wt = -RH1Fcn(alpha,ub,u7w,Global,'FSEstela').*FC3                 ...
           +RH2Fcn(alpha,ub,u7w,u7e,Global,'FSolido').*FC3              ...
           -RH3Fcn(alpha,db,[],u7w,u7e,[],Global,'FSolido',[]).*FC3     ...
           +RH4Fcn(alpha,CTBW,Global,'FSEstela','Cc').*FC3;
% --------------------| Mass Balance - Solid - Emulsion Phase |------------
% ----- constant value ----------------------------------------------------
    FC4 = 1./((1-alpha-alpha*fw)*(1-Emf)*Dcat);
% ----- Coke species ------------------------------------------------------
    u7et = +RH1Fcn(alpha,us,u7e,Global,'FSEmulsion').*FC4               ...
           -RH2Fcn(alpha,ub,u7w,u7e,Global,'FSolido').*FC4              ...
           +RH3Fcn(alpha,db,[],u7w,u7e,[],Global,'FSolido',[]).*FC4     ...
           +RH4Fcn(alpha,CTE,Global,'FSEmulsion','Cc').*FC4;
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% --------------------| Energy Balance - Temperature - Bubble Phase |------
% ----- constant value ----------------------------------------------------
    EBCF1 = 1./eblhsFcn(alpha, Global, CTBW, u8b);
    u8bt  = - ebrhs1Fcn(alpha, Global, CTBW, u8b, ub).*EBCF1        ...
            + ebrhs2Fcn(alpha, Global, CTBW, CTE, u8b, u8e, ub, db) ...
            + ebrhs3Fcn() ...
            + ebrhs4Fcn(alpha, Global, CTBW, CTE, u8b, u8e, ub)     ...
            + ebrhs5Fcn();
% --------------------| Energy Balance - Temperature - Emulsion Phase |----
% ----- constant value ----------------------------------------------------
% EBCF2 = 1./eblhsFcn(alpha, Global, CTE, u8e);
    u8et = zeros(index1,1); 
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% --------------------| Boundary Conditions 2 |----------------------------
% ---------- z = 0 gas - bubble & wake phase ------------------------------
    u1bt(1) = 0; u2bt(1) = 0; u3bt(1) = 0; 
    u4bt(1) = 0; u5bt(1) = 0; u6bt(1) = 0;
% ---------- z = 0 gas - emulsion phase -----------------------------------
    u1et(1) = 0; u2et(1) = 0; u3et(1) = 0; 
    u4et(1) = 0; u5et(1) = 0; u6et(1) = 0;
% ---------- z = 0 solid - wake & emulsion phases -------------------------
    u7wt(1) = u7et(1);
% ---------- z = 0 temperature - bubble & wake phases ---------------------
    u8bt(1) = 0;
% ---------- z = 0 temperature - emulsion phase ---------------------------
    u8et(1) = 0;
% ---------- z = Zg solid - wake & emulsion phase -------------------------
    u7et(index1) = u7wt(index1);
% --------------------| Temporal Variation Vector dudt |-------------------
    ut    = zeros((Num_esp*index1),1);
    for i = 1:index1, ut(i+(0*index1))  = u1bt(i); end
    for i = 1:index1, ut(i+(1*index1))  = u2bt(i); end
    for i = 1:index1, ut(i+(2*index1))  = u3bt(i); end
    for i = 1:index1, ut(i+(3*index1))  = u4bt(i); end
    for i = 1:index1, ut(i+(4*index1))  = u5bt(i); end
    for i = 1:index1, ut(i+(5*index1))  = u6bt(i); end
    for i = 1:index1, ut(i+(6*index1))  = u1et(i); end
    for i = 1:index1, ut(i+(7*index1))  = u2et(i); end
    for i = 1:index1, ut(i+(8*index1))  = u3et(i); end
    for i = 1:index1, ut(i+(9*index1))  = u4et(i); end
    for i = 1:index1, ut(i+(10*index1)) = u5et(i); end
    for i = 1:index1, ut(i+(11*index1)) = u6et(i); end
    for i = 1:index1, ut(i+(12*index1)) = u7wt(i); end
    for i = 1:index1, ut(i+(13*index1)) = u7et(i); end
    for i = 1:index1, ut(i+(14*index1)) = u8bt(i); end
    for i = 1:index1, ut(i+(15*index1)) = u8et(i); end
% --------------------| Number Calls To pdeFcn |---------------------------
    ncall   = ncall+1;
    ncall_2 = ncall_2+1;
    disp([ncall,ncall_2,t])
% --------------------| pdeFcn - End |-------------------------------------
end 
