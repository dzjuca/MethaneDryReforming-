function [STint,OSTint1,OSint,OSTint2,jacob] = IntFcn(x_param,Is,Os,...
                    ONs,WFCH4o,ratio1,ratio2,ratio3,Pmed,time,param)
global Pmed2 vars t T
% ---------------------------- | DEFINITION | -----------------------------
% IntFcn.m es una función desarrollada para realizar el cálculo teórico de
% las corrientes de salida del reactor utilizando los modelos matemáticos
% propuestos.
% ---------------------------- | ENTRADAS | -------------------------------
% [x_param] vector con los parámetros cinéticos provenientes del ajuste
%      [Is] flujos de etrada al reactor
%      [Os] flujos de salida del reactor (flujos vs tiempo)
%     [ONs] flujos de salida del reactor normalizados con FCH4o
%  [WFCH4o] tiempo espacial [g.cat mol-1.h]
%  [ratio1] condición inicial para el flujo FCH4 (normalizado con FCH4o)
%  [ratio2] condición inicial para el flujo FCO2 (normalizado con FCH4o)
%  [ratio3] condición inicial para el flujo FN2  (normalizado con FCH4o)
%       [P] presión total de reacción     [bar] 
%    [Pmed] presión parcial media (PCH4 y PCO2)
%       [t] tiempo de reacción            [min]
%   [param] parámetros cinéticos (identificación)
% ---------------------------- | SALIDAS | --------------------------------
%   [STint] tiempo espacial integrado 
% [OSTint1] flujos de salida integrados (flujos vs tiempo espacial)
%   [OSint] flujos de salida integrados (flujos vs tiempo) 
% [OSTint2] flujos de salida integrados (flujos vs tiempo espacial)
%   [jacob] matriz jacobiana
% -------------------------------------------------------------------------
% ---------- CONFIGURACIÓN DE PARÁMETROS ----------------------------------
  vars = x_param;
% -------------------------------------------------------------------------
  field1 = fieldnames(ONs)';
  index1 = numel(field1);
  for i = 1:index1                 % (1-5) condiciones experimentales
              field2 = fieldnames(ratio1.(field1{i}));
              index2 = numel(field2);
           for j = 1:index2        %         (1-5) tiempos espaciales
                R1.(field1{i})(1,j) = ratio1.(field1{i}).(field2{j});
                R2.(field1{i})(1,j) = ratio2.(field1{i}).(field2{j});
                R3.(field1{i})(1,j) = ratio3.(field1{i}).(field2{j});
             WFCH4.(field1{i})(1,j) = WFCH4o.(field1{i}).(field2{j});
           end
  end
% -------------------------------------------------------------------------
  for i = 1:index1                 % (1-5) condiciones experimentales
  [Rat,Temp,WF1,WF2,dir] = ParameterFcn(field1{i});
  T = (str2double(char((extractBetween(field1(i),'T','R'))))+273.15);
            ONs1 = ONs.(field1{i});
             Is1 = Is.(field1{i});
             Os1 = Os.(field1{i});
           Pmed1 = Pmed.(field1{i}); 
              WF = WFCH4.(field1{i});
              Fo = [R1.(field1{i})(1,1),R2.(field1{i})(1,1),...
                      1e-10,1e-10,1e-10,R3.(field1{i})(1,1)];
          field3 = fieldnames(ONs1)';
          index3 = numel(field3);
           for j = 1:index3         % (1-13) tiempo experimental
            ONs2 = ONs1.(field3{j});
           Pmed2 = Pmed1.(field3{j});
               t = time(j);
% ---------- SOLUCIÓN - ODEs ----------------------------------------------              
[STint.(field1{i}).(field3{j}),OSTint1.(field1{i}).(field3{j})] = ...
                                  ode15s(@KineticFcn,[0 WF(end)],Fo);
                           sol1 = ode15s(@KineticFcn,[0 WF(end)],Fo);
OSTint2.(field1{i}).(field3{j}) = deval(sol1,WF);
                          Eval1 = deval(sol1,WF);
% ---------- MATRIZ JACOBIANA ---------------------------------------------
                for k = 1:length(x_param)
                   db = vars(k)/1000;
              vars(k) = vars(k)+db;
                 sol2 = ode15s(@KineticFcn,[0 WF(end)],Fo);
                Eval2 = deval(sol2,WF);
  jacob.(field1{i}).(field3{j}).(param{k}) = (Eval2-Eval1)/db;
              vars(k) = vars(k)-db;
                end                 
% ---------- REPRESENTACIÓN GRÁFICA (Flujos vs Tiempo Espacial) -----------
% -------------------- DATOS DE COLOR -------------------------------------
            OR = [255, 69,  0]./255;           % OrangeRed
            DB = [30, 144,255]./255;           % DodgerBlue
           MSG = [0,  250,154]./255;           % MediumSpringGreen
            HG = [142, 35, 35]./255;           % Huntergree
             v = [153,153,  0]./255;
             m = [1,    0,  1];

            theColor=[DB;OR;MSG;m;HG;v];
% -------------------- REACTOR OUTPUT STREAM STRUCTURE --------------------
                for l = 1:5
                   OSint.(field1{i}).(WF1{l})(j,:) = ...
                   OSTint2.(field1{i}).(field3{j})(:,l)*Is1.(WF1{l})(1,1);
                end
% -------------------- GRAPHIC 1 TITLE SET --------------------------------
    tm = strcat('time=',strrep(field3{j},'t',''),'\,','min');
  Tit1 = strcat('$',tm,'\;\;\;\;\;\;',Temp,'\;\;\;\;\;\;\;\;',Rat,'$'); 
% -------------------- GRAPHIC 1 AXES 1 CONFIGURATION ---------------------
   fig1 = figure;
          set(fig1,'Units','centimeters',...
                   'PaperPosition',[0 0 15 15],...
                   'PaperSize', [15,15]);
    ax1 = axes('Parent',fig1,'FontSize',14,'XGrid','off',...
            'YGrid','off','visible','on','Box', 'on',...
            'TickLabelInterpreter','latex');
    set(fig1, 'Color', 'w')
    % set (gca,'color','none')%XXX
% -------------------- PLOT GRÁFICO 1 -------------------------------------
  hold on                      
    fp(1)=plot(ax1,WF,ONs2(1,:)','p','Color',theColor(1,:));
    fp(2)=plot(ax1,WF,ONs2(2,:)','p','Color',theColor(2,:));
    fp(3)=plot(ax1,WF,ONs2(3,:)','p','Color',theColor(3,:));
    fp(4)=plot(ax1,WF,ONs2(4,:)','p','Color',theColor(4,:));
    fp(5)=plot(ax1,WF,ONs2(5,:)','p','Color',theColor(5,:)); 
                for n=1:5 % numero de compuestos 
               plot(ax1,STint.(field1{i}).(field3{j}),...
               OSTint1.(field1{i}).(field3{j})(:,n),'Color',theColor(n,:)) 
                end
% -------------------- GRÁFICO 1 CONFIGURACIÓN DE EJES 1 ------------------    
    xlabel('$\frac{W}{{{F_{C{H_4}o}}}}({g_{cat.}}mo{l^{ - 1}}h)$',...
           'FontSize',18,'interpreter','Latex')
    ylabel('$\frac{{{F_i}}}{{{F_{C{H_4}o}}}}$',...
           'FontSize',22,'interpreter','Latex') 
    leyenda1 = {'$C{H_4}$','$C{O_2}$','$CO$','${H_2}$','${H_2}O$'};
    legend(ax1,fp,leyenda1,'Location','north','Orientation',...
                           'horizontal','FontSize',8,...
                           'interpreter','Latex');
% %     title(Tit1,'interpreter','Latex','FontSize',10) %(REPONER PARA TITULO)   
    max1 = max(max(OSTint1.(field1{i}).(field3{j})(:,1:5)))*1.1; % XXX
    max2 = max(max(STint.(field1{i}).(field3{j})))*1.05;
    set(gca,'ylim',[0 max1])
    set(gca,'xlim',[0 max2])
%     set (gca,'color','none')%XXXXX
  hold off  
% -------------------- GRÁFICO 1 CONFIGURACIÓN DE EJES 2 ------------------
    ax1_1 = axes('Parent',fig1,'FontSize',10,'XGrid','off',...
            'YGrid','off','visible','off','Box', 'on',...
            'TickLabelInterpreter','latex');
  hold on
    HP1(1) = plot(ax1_1,NaN,NaN,'pk');
    HP1(2) = plot(ax1_1,NaN,NaN,'-k');
  leyenda2 = {'Exp','Modelo'};
  legend(ax1_1,HP1,leyenda2,'Location','northeast',...
                            'Interpreter','latex', ...
                            'FontSize',7,          ...
                            'Position',[0.7225,0.815,0.05,0.05]);
  hold off
% -------------------- ALMACENAMIENTO DE GRÁFICO 1 ------------------------
    dir1 = strcat(dir,field3{j});
    print(fig1,'-dmeta','-r500',dir1) % win
%   print(fig1,'-dpdf','-r500',dir1)  % mac
%     print(fig1,'-dtiff','-r500',dir1)% XXXXXX
           end % End j
% ---------- REACTOR OUTPUT STREAM GRAPHICS (R.O.S vs TIME) ---------------
                for p = 1:5
                        Os2 = Os1.(WF1{p});
% -------------------- CONFIGURACIÓN GRÁFICO 2 TÍTULO ---------------------
    Tit2 = strcat('$',WF2(p),'\left( {{g_{cat}}mo{l^{ - 1}}h} \right)',...
                  '\;\;\;\;\;\;\;\;\;',Temp,'\;\;\;\;\;\;\;\;\;',Rat,'$');
% -------------------- GRAPHIC 2 AXES 1 CONFIGURATION ---------------------            
   fig2 = figure;
          set(fig2,'Units','centimeters',      ...
                   'PaperPosition',[0 0 15 15],...
                   'PaperSize', [15,15]);
    ax2 = axes('Parent',fig2,'FontSize',14,'XGrid','off',...
               'YGrid','off','visible','on','Box', 'on',...
               'TickLabelInterpreter','latex');
    set(fig2, 'Color', 'w')   
% -------------------- GRÁFICO 2 PLOT -------------------------------------
  hold on
    fp1(1) = plot(ax2,time,Os2(:,1)','p','Color',theColor(1,:));
    fp1(2) = plot(ax2,time,Os2(:,2)','p','Color',theColor(2,:));
    fp1(3) = plot(ax2,time,Os2(:,3)','p','Color',theColor(3,:));
    fp1(4) = plot(ax2,time,Os2(:,4)','p','Color',theColor(4,:));
    fp1(5) = plot(ax2,time,Os2(:,5)','p','Color',theColor(5,:));
        for q = 1:5
             plot(ax2,time,OSint.(field1{i}).(WF1{p})(:,q),...
                  '-','Color',theColor(q,:));              
        end
% -------------------- GRAPHIC 2 AXES 1 LABEL SET -------------------------    
    xlabel('$tiempo\;(\min )$','FontSize',18,'interpreter','Latex')
    ylabel('$ F_{i}\left( {\frac{{mol}}{h}} \right) $',...
           'FontSize',22,'interpreter','Latex') 
    leyenda2 = {'$C{H_4}$','$C{O_2}$','$CO$','${H_2}$','${H_2}O$'};
    legend(ax2,fp1,leyenda2,'Location','north','Orientation',...
                            'horizontal','FontSize',8,...
                            'interpreter','Latex');
% %     title(Tit2,'interpreter','Latex','FontSize',9) %(REPONER PARA TITULO)
    max3 = max(max(OSint.(field1{i}).(WF1{p})(:,1:5))); % xxxx
    max4 = max(max(Os2(:,1:5)));
    max5 = (max(max3,max4))*1.2;
    set(gca,'ylim',[0 max5])
%     set(gca,'color','none')
    hold off 
% -------------------- GRAPHIC 2 AXES 2 CONFIGURATION ---------------------    
    ax2_1 = axes('Parent',fig2,'FontSize',10,'XGrid','off',...
            'YGrid','off','visible','off','Box', 'on',...
            'TickLabelInterpreter','latex');
  hold on
      HP2(1) = plot(ax2_1,NaN,NaN,'pk');
      HP2(2) = plot(ax2_1,NaN,NaN,'-k');
    leyenda2 = {'Exp','Modelo'};
    legend(ax2_1,HP2,leyenda2,'Location','northeast',...
                              'Interpreter','latex', ...
                              'FontSize',7,...
                              'Position',[0.72,0.815,0.05,0.05]);
  hold off
% -------------------- GRAPHIC 2 SAVE -------------------------------------
    dir2 = strcat(pwd,'/',field1{i},'/','MI_',field1{i},WF1{p});
    print(fig2,'-dmeta','-r500',dir2) % win
%     print(fig2,'-dpdf','-r500',dir2) % mac
                end % End p
  close all                
  end% End i
end% End función
% ---------------------------- | END FUCTION |-----------------------------