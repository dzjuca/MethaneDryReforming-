function [RH2T,RCOT,RH2E,RCOE] = RenFunc(tout,Fout,experimental,t_exp)
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
  global FCH4in FCO2in
  FCH4_in = FCH4in*60*22.4*1000;
  FCO2_in = FCO2in*60*22.4*1000;
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
  RCOT = (FCOoutT./(FCH4_in + FCO2_in)).*100;
% ---------- |Conversión de Dióxido de Carbono - MODELO| ------------------
  RH2T = (FH2outT./(2*FCH4_in)).*100;
% ---------- |Conversión de Metano - MODELO| ------------------------------
  RCOE = (FCOoutE./(FCH4_in + FCO2_in)).*100;
% ---------- |Conversión de Dióxido de Carbono - MODELO| ------------------
  RH2E = (FH2outE./(2*FCH4_in)).*100;
% ---------- |Carpeta de almacenamiento| ----------------------------------
  id = exist('RENDIMIENTOS','file');
         if id == 7
             dir = strcat(pwd,'/','RENDIMIENTOS');
         else
             mkdir('RENDIMIENTOS')
             dir = strcat(pwd,'/','RENDIMIENTOS');
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
        plot(tiempo(2:end),RCOT(2:end),'k-','MarkerSize',MZ1);
        plot(tiempo(2:end),RH2T(2:end),'k-','MarkerSize',MZ1);
        fp(1) = plot(tiempo_exp,RCOE,'ko','MarkerSize',MZ1);
        fp(2) = plot(tiempo_exp,RH2E,'ks','MarkerSize',MZ1);
    ley1 = {'$CO$','$H_{2}$'};
    legend(fp,ley1,'Interpreter','Latex',     ...
                'Location','north',        ...
                'Orientation','horizontal',...
                'FontSize',LFZ)
        xlabel('$tiempo\;\left( {min} \right)$',...
               'FontSize',XLFZ,'interpreter','Latex')
        ylabel('$R_{i}$',...
               'FontSize',YLFZ,'interpreter','Latex') 
        max1_1 = max(max([RCOT(2:end),RH2T(2:end)])); 
        max1_2 = max(max([RCOE(2:end),RH2E(2:end)])); 
        max1 = max([max1_1,max1_2]);
        max1 = max1 + max1*0.2;
        max2 = max(tiempo);
        xlim([0 max2])
        ylim([0 max1])
    hold off
    dir1 = strcat(dir,'/','RENDIMIENTOS');
    print(fig1,'-dpdf','-r500',dir1)
    close all
end