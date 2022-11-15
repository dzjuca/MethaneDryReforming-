function Fout = FlujosFcn(tout,u)
% Función FlujosFcn.m permite realizar el cálculo de los flujos de los
% diferentes compuestos gaseosos a la salida del reactor.
% ----------------------------| ENTRADAS |---------------------------------
%    tout = vector con los tiempos de salida                     [s]
%       u = vector con las concentraciones de cada compuesto     [mol/cm3]
% ----------------------------| SALIDAS |----------------------------------
%    Fout = estructura con los flujos de cada compuesto          [ml/min]
% -------------------------------------------------------------------------
  global zg A fw Emf
% ---------- Configuración - Vector de salida -----------------------------
  index1 = length(tout);
  index2 = length(zg);
% ---------- Fase Gas - Burbuja & Estela ----------------------------------
u1b = zeros(index1,index2); u2b = zeros(index1,index2); 
u3b = zeros(index1,index2); u4b = zeros(index1,index2); 
u5b = zeros(index1,index2); u6b = zeros(index1,index2);
% ---------- Fase Gas - Emulsión ------------------------------------------
u1e = zeros(index1,index2); u2e = zeros(index1,index2); 
u3e = zeros(index1,index2); u4e = zeros(index1,index2); 
u5e = zeros(index1,index2); u6e = zeros(index1,index2);
% ---------- Fase Sólido - Estela & Emulsión ------------------------------
u7w = zeros(index1,index2); u7e = zeros(index1,index2);  
% -------------------------------------------------------------------------
    for j=1:index1 
        for i=1:index2, u1b(j,i)=u(j,i+0*index2);     end
        for i=1:index2, u2b(j,i)=u(j,i+1*index2);     end
        for i=1:index2, u3b(j,i)=u(j,i+2*index2);     end
        for i=1:index2, u4b(j,i)=u(j,i+3*index2);     end
        for i=1:index2, u5b(j,i)=u(j,i+4*index2);     end 
        for i=1:index2, u6b(j,i)=u(j,i+5*index2);     end 
        for i=1:index2, u1e(j,i)=u(j,i+6*index2);     end 
        for i=1:index2, u2e(j,i)=u(j,i+7*index2);     end 
        for i=1:index2, u3e(j,i)=u(j,i+8*index2);     end 
        for i=1:index2, u4e(j,i)=u(j,i+9*index2);     end
        for i=1:index2, u5e(j,i)=u(j,i+10*index2);    end
        for i=1:index2, u6e(j,i)=u(j,i+11*index2);    end
        for i=1:index2, u7w(j,i)=u(j,i+12*index2);    end
        for i=1:index2, u7e(j,i)=u(j,i+13*index2);    end
    end
% ---------- Llamado de ubFcn.m -------------------------------------------
  [ub,~,us,ue,alpha]= ubFcn;
% --------------------------------| CH4 |----------------------------------
% ---------- Flujo Fase Gas Burbuja ---------------------------------------
  Fout.FCH4.Fb = u1b'.*ub.*A.*(alpha+alpha*fw*Emf)*(60*22.4*1000);
% ---------- Flujo Fase Gas Emulsión --------------------------------------
  Fout.FCH4.Fe = u1e'.*ue.*A.*(1-alpha+alpha*fw)*Emf*(60*22.4*1000);
% ---------- Flujo Reactor ------------------------------------------------
  Fout.FCH4.F = Fout.FCH4.Fb + Fout.FCH4.Fe;
% --------------------------------| CO2 |----------------------------------
% ---------- Flujo Fase Gas Burbuja ---------------------------------------
  Fout.FCO2.Fb = u2b'.*ub.*A.*(alpha+alpha*fw*Emf)*(60*22.4*1000);
% ---------- Flujo Fase Gas Emulsión --------------------------------------
  Fout.FCO2.Fe = u2e'.*ue.*A.*(1-alpha+alpha*fw)*Emf*(60*22.4*1000);
% ---------- Flujo Reactor ------------------------------------------------
  Fout.FCO2.F = Fout.FCO2.Fb + Fout.FCO2.Fe;
% --------------------------------| CO |-----------------------------------
% ---------- Flujo Fase Gas Burbuja ---------------------------------------
  Fout.FCO.Fb = u3b'.*ub.*A.*(alpha+alpha*fw*Emf)*(60*22.4*1000);
% ---------- Flujo Fase Gas Emulsión --------------------------------------
  Fout.FCO.Fe = u3e'.*ue.*A.*(1-alpha+alpha*fw)*Emf*(60*22.4*1000);
% ---------- Flujo Reactor ------------------------------------------------
  Fout.FCO.F = Fout.FCO.Fb + Fout.FCO.Fe;
% --------------------------------| H2 |-----------------------------------
% ---------- Flujo Fase Gas Burbuja ---------------------------------------
  Fout.FH2.Fb = u4b'.*ub.*A.*(alpha+alpha*fw*Emf)*(60*22.4*1000);
% ---------- Flujo Fase Gas Emulsión --------------------------------------
  Fout.FH2.Fe = u4e'.*ue.*A.*(1-alpha+alpha*fw)*Emf*(60*22.4*1000);
% ---------- Flujo Reactor ------------------------------------------------
  Fout.FH2.F = Fout.FH2.Fb + Fout.FH2.Fe;
% --------------------------------| H2O |----------------------------------
% ---------- Flujo Fase Gas Burbuja ---------------------------------------
  Fout.FH2O.Fb = u5b'.*ub.*A.*(alpha+alpha*fw*Emf)*(60*22.4*1000);
% ---------- Flujo Fase Gas Emulsión --------------------------------------
  Fout.FH2O.Fe = u5e'.*ue.*A.*(1-alpha+alpha*fw)*Emf*(60*22.4*1000);
% ---------- Flujo Reactor ------------------------------------------------
  Fout.FH2O.F = Fout.FH2O.Fb + Fout.FH2O.Fe;
% --------------------------------| N2 |-----------------------------------
% ---------- Flujo Fase Gas Burbuja ---------------------------------------
  Fout.FN2.Fb = u6b'.*ub.*A.*(alpha+alpha*fw*Emf)*(60*22.4*1000);
% ---------- Flujo Fase Gas Emulsión --------------------------------------
  Fout.FN2.Fe = u6e'.*ue.*A.*(1-alpha+alpha*fw)*Emf*(60*22.4*1000);
% ---------- Flujo Reactor ------------------------------------------------
  Fout.FN2.F = Fout.FN2.Fb + Fout.FN2.Fe;
% -----------------------| COQUE Cc |--------------------------------------
% ---------- Flujo Fase Sólido Estela -------------------------------------
  Fout.FCc.Fw = u7w'.*ub*A.*alpha*fw*(1-Emf)*60;            % [g.Cc/min]
% ---------- Flujo Fase Sólido Emulsión -----------------------------------
  Fout.FCc.Fe = u7e'.*us*A.*(1-alpha-alpha*fw)*(1-Emf)*60;  % [g.Cc/min]
% ---------- Flujo Reactor ------------------------------------------------
  Fout.FCc.F = Fout.FCc.Fw + Fout.FCc.Fe;
end