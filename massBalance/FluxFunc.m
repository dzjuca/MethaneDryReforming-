function [FluxT,FluxE] = FluxFunc(tout,Fout,experimental,t_exp)
% ---------- | EXPERIMENTAL |----------------------------------------------
experimental(:,3) = [];
experimental = experimental*22.4;
FCH4exp = experimental(:,4);
FCO2exp = experimental(:,2);
FCOexp  = experimental(:,5);
FH2exp  = experimental(:,1);
FH2Oexp = experimental(:,6);
FN2exp  = experimental(:,3);
tiempo_exp = t_exp;
FluxE = [tiempo_exp,FCH4exp,FCO2exp,FCOexp,FH2exp,FH2Oexp,FN2exp];
% ---------- | MODELO |----------------------------------------------------
tiempo_mod = tout./60;
   FCH4mod = Fout.FCH4.F(end,:)';
   FCO2mod = Fout.FCO2.F(end,:)';
    FCOmod = Fout.FCO.F(end,:)';
    FH2mod = Fout.FH2.F(end,:)';
   FH2Omod = Fout.FH2O.F(end,:)';
    FN2mod = Fout.FN2.F(end,:)';
     FluxT = [tiempo_mod,FCH4mod,FCO2mod,FCOmod,FH2mod,FH2Omod,FN2mod];
% ---------- |Carpeta de almacenamiento| ----------------------------------
  id = exist('FLUJOS','file');
         if id == 7
             dir = strcat(pwd,'/','FLUJOS');
         else
             mkdir('FLUJOS')
             dir = strcat(pwd,'/','FLUJOS');
         end
% ---------- |GRÁFICOS| ---------------------------------------------------
% ----- Datos constantes para seteo de gráficos ---------------------------
  FZ1 = 30; MZ1 = 15; XLFZ = 40; YLFZ = 40; LFZ = 20; % LEYNEDA
% ---------- REPRESENTACIÓN GRÁFICA (Flujos vs Tiempo Espacial) -----------
% -------------------- DATOS DE COLOR -------------------------------------
            OR = [255, 69,  0]./255;           % OrangeRed
            DB = [30, 144,255]./255;           % DodgerBlue
           MSG = [0,  250,154]./255;           % MediumSpringGreen
            HG = [142, 35, 35]./255;           % Huntergree
             v = [153,153,  0]./255;
             m = [1,    0,  1];
            TC = [DB;OR;MSG;m;HG;v];
% ---------- Plot - Flujos ------------------------------------------------
% -------------------- GRAPHIC 1 AXES 1 CONFIGURATION --------------------- 
   fig1 = figure;
          set(fig1,'Units','centimeters',...
                   'PaperPosition',[0 0 15 15],...
                   'PaperSize', [15,15]);
    ax1 = axes('Parent',fig1,'FontSize',FZ1,'XGrid','off',...
            'YGrid','off','visible','on','Box', 'on',...
            'TickLabelInterpreter','latex');
          set(fig1, 'Color', 'w')    
hold on
plot(tiempo_mod,FCH4mod,'k-','Color',TC(1,:));
plot(tiempo_mod,FCO2mod,'k-','Color',TC(2,:));
plot(tiempo_mod,FCOmod, 'k-','Color',TC(3,:));
plot(tiempo_mod,FH2mod, 'k-','Color',TC(4,:));
plot(tiempo_mod,FH2Omod,'k-','Color',TC(5,:));
plot(tiempo_mod,FN2mod, 'k-','Color',TC(6,:));
fp(1) = plot(tiempo_exp,FCH4exp,'ks','MarkerSize',MZ1,'Color',TC(1,:));
fp(2) = plot(tiempo_exp,FCO2exp,'ko','MarkerSize',MZ1,'Color',TC(2,:));
fp(3) = plot(tiempo_exp,FCOexp, 'k*','MarkerSize',MZ1,'Color',TC(3,:));
fp(4) = plot(tiempo_exp,FH2exp, 'kd','MarkerSize',MZ1,'Color',TC(4,:));
fp(5) = plot(tiempo_exp,FH2Oexp,'kp','MarkerSize',MZ1,'Color',TC(5,:));
fp(6) = plot(tiempo_exp,FN2exp, 'k.','MarkerSize',MZ1,'Color',TC(6,:));
% -------------------- GRÁFICO 1 CONFIGURACIÓN DE EJES 1 ------------------    
    xlabel('$tiempo\;\left( {min} \right)$',...
           'FontSize',XLFZ,'interpreter','Latex')
    ylabel('$flujo\left({\frac{{ml}}{{min}}} \right)$',...
           'FontSize',YLFZ,'interpreter','Latex') 
    leyenda1 = {'$C{H_4}$','$C{O_2}$','$CO$',...
                '${H_2}$','${H_2}O$','${N_2}$'};
    legend(ax1,fp,leyenda1,'Location','north','Orientation',...
                           'horizontal','FontSize',LFZ,...
                           'interpreter','Latex');
        max1_1 = max(FluxT(:,2:end)); 
        max1_2 = max(FluxE(:,2:end)); 
        max1 = max([max1_1,max1_2]);
        max1 = max1 + max1*0.1;
        max2 = max(tiempo_exp);
        xlim([0 max2])
        ylim([0 max1])
hold off
dir1 = strcat(dir,'/','FLUJOS');
print(fig1,'-dpdf','-r500',dir1) 
close all
end