function ut = pdeFcn(t,u,Global)

  % pdeFcn function define the EDOs for the numerical solution with 
  % the method of lines
  % ----------------------------| input |----------------------------------
  %       t = interval of integration, specified as a vector
  %       u = time-dependent terms, specified as a vector
  %  Global = constant values structure 
  % ----------------------------| output |---------------------------------
  %      ut =  time-dependent terms variation, specified as a vector
% -------------------------------------------------------------------------
    global ncall 
    zg      = Global.zg;
    fw      = Global.fw;
    Emf     = Global.Emf;
    CH4in   = Global.CH4in;
    CO2in   = Global.CO2in;
    N2in    = Global.N2in;
    Num_esp = Global.Num_esp;
    Dcat    = Global.Dcat;
% ---------- Configuraci�n inicial de las variables -----------------------
    index1  = length(zg);
% ---------- Eliminaci�n de concentraciones negativas ---------------------
    for i = 1:index1*Num_esp
        if u(i) < 0,    u(i) = 0; end
    end
% ---------- Fase Gas - Burbuja & Estela ----------------------------------
    u1b = zeros(index1,1); u2b = zeros(index1,1); 
    u3b = zeros(index1,1); u4b = zeros(index1,1); 
    u5b = zeros(index1,1); u6b = zeros(index1,1);
% ---------- Fase Gas - Emulsi�n ------------------------------------------
    u1e = zeros(index1,1); u2e = zeros(index1,1); 
    u3e = zeros(index1,1); u4e = zeros(index1,1); 
    u5e = zeros(index1,1); u6e = zeros(index1,1);
% ---------- Fase S�lido - Estela -----------------------------------------
    u7w = zeros(index1,1); 
% ---------- Fase S�lido - Emulsi�n ---------------------------------------
    u7e = zeros(index1,1); 
% ---------- Fase S�lido - Estela -----------------------------------------
    u8b = zeros(index1,1); 
% ---------- Fase S�lido - Emulsi�n ---------------------------------------
    u8e = zeros(index1,1); 
% ----------------------------| FASE GAS |---------------------------------
  for i = 1:(index1), u1b(i) = u(i+0*(index1));end  % u1b = CH4 burbuja 
  for i = 1:(index1), u2b(i) = u(i+1*(index1));end  % u2b = CO2 burbuja 
  for i = 1:(index1), u3b(i) = u(i+2*(index1));end  % u3b = CO  burbuja
  for i = 1:(index1), u4b(i) = u(i+3*(index1));end  % u4b = H2  burbuja
  for i = 1:(index1), u5b(i) = u(i+4*(index1));end  % u5b = H20 burbuja
  for i = 1:(index1), u6b(i) = u(i+5*(index1));end  % u6b = N2  burbuja
  for i = 1:(index1), u1e(i) = u(i+6*(index1));end  % u1e = CH4 emulsi�n
  for i = 1:(index1), u2e(i) = u(i+7*(index1));end  % u2e = CO2 emulsi�n
  for i = 1:(index1), u3e(i) = u(i+8*(index1));end  % u3e = CO  emulsi�n
  for i = 1:(index1), u4e(i) = u(i+9*(index1));end  % u4e = H2  emulsi�n
  for i = 1:(index1), u5e(i) = u(i+10*(index1));end % u5e = H2O emulsi�n
  for i = 1:(index1), u6e(i) = u(i+11*(index1));end % u6e = N2  emulsi�n
  for i = 1:(index1), u7w(i) = u(i+12*(index1));end % u7w = Cc  estela
  for i = 1:(index1), u7e(i) = u(i+13*(index1));end % u7e = Cc  emulsi�n
  for i = 1:(index1), u8b(i) = u(i+14*(index1));end % u7w = Cc  estela
  for i = 1:(index1), u8e(i) = u(i+15*(index1));end % u7e = Cc  emulsi�n
% -------------------------------------------------------------------------
% ---------------------| CONDICIONES DE CONTORNO 1 |-----------------------
% ---------- z = 0 --------------------------------------------------------
% ---------- Fase Gas - Burbuja & Estela ----------------------------------
  u1b(1) = CH4in; u2b(1) = CO2in; u3b(1) = 0.000; 
  u4b(1) = 0.000; u5b(1) = 0.000; u6b(1) = N2in;
% ---------- Fase Gas - Emulsi�n ------------------------------------------
  u1e(1) = CH4in; u2e(1) = CO2in; u3e(1) = 0.000;
  u4e(1) = 0.000; u5e(1) = 0.000; u6e(1) = N2in;
% ---------- Fase S�lido - Estela & Emulsi�n ------------------------------
        u7w(1) = u7e(1);
% ---------- z = Zg -------------------------------------------------------
% ---------- Fase Gas - Burbuja & Estela ----------------------------------
   u7e(index1) = u7w(index1);
% ---------- Llamado a la funci�n ubFcn.m ---------------------------------
  [ub,db,us,ue,alpha] = ubFcn(Global);    
% ---------- Concentraciones Totales --------------------------------------
  CTBW = [u1b,u2b,u3b,u4b,u5b,u6b,u7w];
   CTE = [u1e,u2e,u3e,u4e,u5e,u6e,u7e];
% -------------------- | FASE GAS - BURBUJA | -----------------------------
% ----- Factor constante --------------------------------------------------
  FC1 = 1./(alpha + fw*alpha*Emf);
% ----- Compuesto CH4 -----------------------------------------------------
  u1bt = -(RH1Fcn(alpha,ub,u1b,'FGBurbuja')).*FC1               ...
         +(RH2Fcn(alpha,ub,u1b,u1e,'FGas')).*FC1                ... 
         -(RH3Fcn(alpha,db,ub,u1b,u1e,CTBW,'FGas','CH4')).*FC1  ...
         +(RH4Fcn(alpha,CTBW,'FGBurbuja','CH4')).*FC1;
% ----- Compuesto CO2 -----------------------------------------------------
  u2bt = -(RH1Fcn(alpha,ub,u2b,'FGBurbuja')).*FC1               ...
         +(RH2Fcn(alpha,ub,u2b,u2e,'FGas')).*FC1                ... 
         -(RH3Fcn(alpha,db,ub,u2b,u2e,CTBW,'FGas','CO2')).*FC1  ...
         +(RH4Fcn(alpha,CTBW,'FGBurbuja','CO2')).*FC1;
% ----- Compuesto CO ------------------------------------------------------
  u3bt = -(RH1Fcn(alpha,ub,u3b,'FGBurbuja')).*FC1               ...
         +(RH2Fcn(alpha,ub,u3b,u3e,'FGas')).*FC1                ... 
         -(RH3Fcn(alpha,db,ub,u3b,u3e,CTBW,'FGas','CO')).*FC1   ...
         +(RH4Fcn(alpha,CTBW,'FGBurbuja','CO')).*FC1;
% ----- Compuesto H2 ------------------------------------------------------
  u4bt = -(RH1Fcn(alpha,ub,u4b,'FGBurbuja')).*FC1               ...
         +(RH2Fcn(alpha,ub,u4b,u4e,'FGas')).*FC1                ... 
         -(RH3Fcn(alpha,db,ub,u4b,u4e,CTBW,'FGas','H2')).*FC1   ...
         +(RH4Fcn(alpha,CTBW,'FGBurbuja','H2')).*FC1;
% ----- Compuesto H2O -----------------------------------------------------
  u5bt = -(RH1Fcn(alpha,ub,u5b,'FGBurbuja')).*FC1               ...
         +(RH2Fcn(alpha,ub,u5b,u5e,'FGas')).*FC1                ... 
         -(RH3Fcn(alpha,db,ub,u5b,u5e,CTBW,'FGas','H2O')).*FC1  ...
         +(RH4Fcn(alpha,CTBW,'FGBurbuja','H2O')).*FC1;
% ----- Compuesto N2 ------------------------------------------------------
  u6bt = -(RH1Fcn(alpha,ub,u6b,'FGBurbuja')).*FC1               ...
         +(RH2Fcn(alpha,ub,u6b,u6e,'FGas')).*FC1                ... 
         -(RH3Fcn(alpha,db,ub,u6b,u6e,CTBW,'FGas','N2')).*FC1   ...
         +(RH4Fcn(alpha,CTBW,'FGBurbuja','N2')).*FC1;
% -------------------- | FASE GAS - EMULSI�N | ----------------------------
% ----- Factor constante --------------------------------------------------
  FC2 = 1./((1-alpha-alpha*fw)*Emf);
% ----- Compuesto CH4 -----------------------------------------------------
  u1et = -(RH1Fcn(alpha,ue,u1e,'FGEmulsion')).*FC2              ...
         -(RH2Fcn(alpha,ub,u1b,u1e,'FGas')).*FC2                ...
         +(RH3Fcn(alpha,db,ub,u1b,u1e,CTBW,'FGas','CH4')).*FC2  ...
         +(RH4Fcn(alpha,CTE,'FGEmulsion','CH4')).*FC2;
% ----- Compuesto CO2 -----------------------------------------------------
  u2et = -(RH1Fcn(alpha,ue,u2e,'FGEmulsion')).*FC2              ...
         -(RH2Fcn(alpha,ub,u2b,u2e,'FGas')).*FC2                ...
         +(RH3Fcn(alpha,db,ub,u2b,u2e,CTBW,'FGas','CO2')).*FC2  ...
         +(RH4Fcn(alpha,CTE,'FGEmulsion','CO2')).*FC2;
% ----- Compuesto CO ------------------------------------------------------
  u3et = -(RH1Fcn(alpha,ue,u3e,'FGEmulsion')).*FC2              ...
         -(RH2Fcn(alpha,ub,u3b,u3e,'FGas')).*FC2                ...
         +(RH3Fcn(alpha,db,ub,u3b,u3e,CTBW,'FGas','CO')).*FC2   ...
         +(RH4Fcn(alpha,CTE,'FGEmulsion','CO')).*FC2;
% ----- Compuesto H2 ------------------------------------------------------
  u4et = -(RH1Fcn(alpha,ue,u4e,'FGEmulsion')).*FC2              ...
         -(RH2Fcn(alpha,ub,u4b,u4e,'FGas')).*FC2                ...
         +(RH3Fcn(alpha,db,ub,u4b,u4e,CTBW,'FGas','H2')).*FC2   ...
         +(RH4Fcn(alpha,CTE,'FGEmulsion','H2')).*FC2;
% ----- Compuesto H2O -----------------------------------------------------
  u5et = -(RH1Fcn(alpha,ue,u5e,'FGEmulsion')).*FC2              ...
         -(RH2Fcn(alpha,ub,u5b,u5e,'FGas')).*FC2                ...
         +(RH3Fcn(alpha,db,ub,u5b,u5e,CTBW,'FGas','H2O')).*FC2  ...
         +(RH4Fcn(alpha,CTE,'FGEmulsion','H2O')).*FC2;
% ----- Compuesto N2 ------------------------------------------------------
  u6et = -(RH1Fcn(alpha,ue,u6e,'FGEmulsion')).*FC2              ...
         -(RH2Fcn(alpha,ub,u6b,u6e,'FGas')).*FC2                ...
         +(RH3Fcn(alpha,db,ub,u6b,u6e,CTBW,'FGas','N2')).*FC2   ...
         +(RH4Fcn(alpha,CTE,'FGEmulsion','N2')).*FC2;
% -------------------- | FASE S�LIDO - ESTELA | ---------------------------
% ----- Factor constante --------------------------------------------------
 FC3 = 1./((alpha*fw)*(1-Emf)*Dcat);
% ----- Compuesto Coque ---------------------------------------------------
u7wt = -RH1Fcn(alpha,ub,u7w,'FSEstela').*FC3             ...
       +RH2Fcn(alpha,ub,u7w,u7e,'FSolido').*FC3          ...
       -RH3Fcn(alpha,db,[],u7w,u7e,[],'FSolido',[]).*FC3 ...
       +RH4Fcn(alpha,CTBW,'FSEstela','Cc').*FC3;
% -------------------- | FASE S�LIDO - EMULSI�N | -------------------------
% ----- Factor constante --------------------------------------------------
 FC4 = 1./((1-alpha-alpha*fw)*(1-Emf)*Dcat);
% ----- Compuesto Coque ---------------------------------------------------
u7et = +RH1Fcn(alpha,us,u7e,'FSEmulsion').*FC4           ...
       -RH2Fcn(alpha,ub,u7w,u7e,'FSolido').*FC4          ...
       +RH3Fcn(alpha,db,[],u7w,u7e,[],'FSolido',[]).*FC4 ...
       +RH4Fcn(alpha,CTE,'FSEmulsion','Cc').*FC4;
% ---------------------| CONDICIONES DE CONTORNO 2|------------------------
% ---------- z = 0 --------------------------------------------------------
% ---------- Fase Gas - Burbuja & Estela ----------------------------------
  u1bt(1) = 0; u2bt(1) = 0; u3bt(1) = 0; 
  u4bt(1) = 0; u5bt(1) = 0; u6bt(1) = 0;
% ---------- Fase Gas - Emulsi�n ------------------------------------------ 
  u1et(1) = 0; u2et(1) = 0; u3et(1) = 0; 
  u4et(1) = 0; u5et(1) = 0; u6et(1) = 0;
% ---------- Fase S�lido Estela & Emulsi�n --------------------------------
  u7wt(1) = u7et(1);
% ---------- z = Zg -------------------------------------------------------
% ---------- Fase Gas - Burbuja & Estela ----------------------------------
  u7et(index1) = u7wt(index1);
% ---------- Num_esp - vectores a 1 vector --------------------------------
     ut = zeros((Num_esp*index1),1);
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
  for i = 1:index1, ut(i+(14*index1)) = u8b(i); end
  for i = 1:index1, ut(i+(15*index1)) = u8e(i); end
% ----- Incremento de llamadas a pdeDRM.m ---------------------------------
ncall = ncall+1;
disp([ncall,t])
end % -----------------------| FIN - pdeDRM.m |----------------------------
