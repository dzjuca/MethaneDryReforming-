function [RH2COT,RH2COE] = RatFunc(tout,Fout,experimental,t_exp)
% ConFunc.m es una función creada para la obtención de las conversiones
% experimentales y las conversiones teóricas, en el reformado seco de
% metano.
% ----------------------------| ENTRADAS |---------------------------------
%    tout = vector con los tiempos de salida - modelo            [s]
%    Fout = vector con las concentraciones (i) - modelo          [mol/cm3]
%  FCH4in = Flujo de entrada de metano                           [mol/s]
%  FCO2in = Flujo de entrada de metano                           [mol/s]
% experimental = datos experimentales                            [mmol/min]
%        t_exp = tiempo experimental                             [min]
% ----------------------------| SALIDAS |----------------------------------
%    XCH4T = conversión de metano teórica
%    XCO2T = conversión de dióxido de carbono teórica
%    XCH4E = conversión de metano experimental
%    XCO2E = conversión de dióxido de carbono experimental
% -------------------------------------------------------------------------
  % ---------- MODELO -----------------------------------------------------
   tiempo = tout./60;
   field1 = fieldnames(Fout);
  FCOoutT = Fout.(field1{3}).F(end,:)';
  FH2outT = Fout.(field1{4}).F(end,:)';
% ---------- EXPERIMENTAL -------------------------------------------------
  tiempo_exp = t_exp;
    FCOoutE = experimental(:,6).*22.4;
    FH2outE = experimental(:,1).*22.4;
% ---------- |Conversión de Metano - MODELO| ------------------------------
  RH2COT = (FH2outT./FCOoutT);
% ---------- |Conversión de Dióxido de Carbono - MODELO| ------------------
  RH2COE = (FH2outE./FCOoutE);
% ---------- |Carpeta de almacenamiento| ----------------------------------
  id = exist('RATIOH2CO','file');
         if id == 7
             dir = strcat(pwd,'/','RATIOH2CO');
         else
             mkdir('RATIOH2CO')
             dir = strcat(pwd,'/','RATIOH2CO');
         end
% ---------- |GRÁFICO DE CONVERSIONES| ------------------------------------ 
% ----- Datos constantes para seteo de gráficos ---------------------------
  FZ1 = 30; MZ1 = 15; XLFZ = 40; YLFZ = 40; LFZ = 20; % LEYNEDA
% ----- Gráfico de conversiones -------------------------------------------
   fig1 = figure;
          set(fig1,'Units','centimeters',...
                   'PaperPosition',[0 0 15 15],...
                   'PaperSize', [15,15]);
       axes('Parent',fig1,'FontSize',FZ1,'XGrid','off',...
               'YGrid','off','visible','on','Box', 'on',...
            'TickLabelInterpreter','latex');
            set(fig1, 'Color', 'w') 
    hold on
        plot(tiempo(1:end),RH2COT(1:end),'k-','MarkerSize',MZ1);
        plot(tiempo_exp,RH2COE,'ko','MarkerSize',MZ1);
        xlabel('$tiempo\;\left( {min} \right)$',...
               'FontSize',XLFZ,'interpreter','Latex')
        ylabel('$R_{H2/CO}$',...
               'FontSize',YLFZ,'interpreter','Latex') 
        max1_1 = max(RH2COT(1:end)); 
        max1_2 = max(RH2COE); 
        max1 = max([max1_1,max1_2]);
        max1 = max1 + max1*0.2;
        max2 = max(tiempo);
        xlim([0 max2])
        ylim([0 max1])
    hold off
    dir1 = strcat(dir,'/','RATIOH2CO');
    print(fig1,'-dpdf','-r500',dir1)
    close all
end