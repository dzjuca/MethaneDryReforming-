function [] = GraphFun(tout,Fout,datos,tiempo)
datos(:,3) = [];
datos = datos*22.4;
FCH4exp = datos(:,4);
FCO2exp = datos(:,2);
FCOexp  = datos(:,5);
FH2exp  = datos(:,1);
FH2Oexp = datos(:,6);
FN2exp  = datos(:,3);
% ---------- REPRESENTACIÓN GRÁFICA (Flujos vs Tiempo Espacial) -----------
% -------------------- DATOS DE COLOR -------------------------------------
            OR = [255, 69,  0]./255;           % OrangeRed
            DB = [30, 144,255]./255;           % DodgerBlue
           MSG = [0,  250,154]./255;           % MediumSpringGreen
            HG = [142, 35, 35]./255;           % Huntergree
             v = [153,153,  0]./255;
             m = [1,    0,  1];
            theColor=[DB;OR;MSG;m;HG;v];
% ---------- Plot - Flujos ------------------------------------------------
% -------------------- GRAPHIC 1 AXES 1 CONFIGURATION --------------------- 
   fig1 = figure;
          set(fig1,'Units','centimeters',...
                   'PaperPosition',[0 0 15 15],...
                   'PaperSize', [15,15]);
    ax1 = axes('Parent',fig1,'FontSize',12,'XGrid','off',...
            'YGrid','off','visible','on','Box', 'on',...
            'TickLabelInterpreter','latex');
          set(fig1, 'Color', 'w')    
hold on
fp(1) = plot((tout/60),Fout.FCH4.F(end,:),'-','Color',theColor(1,:));
fp(2) = plot((tout/60),Fout.FCO2.F(end,:),'-','Color',theColor(2,:));
fp(3) = plot((tout/60),Fout.FCO.F(end,:),'-' ,'Color',theColor(3,:));
fp(4) = plot((tout/60),Fout.FH2.F(end,:),'-' ,'Color',theColor(4,:));
fp(5) = plot((tout/60),Fout.FH2O.F(end,:),'-','Color',theColor(5,:));
fp(6) = plot((tout/60),Fout.FN2.F(end,:),'--' ,'Color',theColor(6,:));
plot(tiempo,FCH4exp,'s','Color',theColor(1,:));
plot(tiempo,FCO2exp,'s','Color',theColor(2,:));
plot(tiempo,FCOexp, 's','Color',theColor(3,:));
plot(tiempo,FH2exp, 's','Color',theColor(4,:));
plot(tiempo,FH2Oexp,'s','Color',theColor(5,:));
plot(tiempo,FN2exp, '.','Color',theColor(6,:));
% -------------------- GRÁFICO 1 CONFIGURACIÓN DE EJES 1 ------------------    
    xlabel('$tiempo\;\left( {min} \right)$',...
           'FontSize',16,'interpreter','Latex')
    ylabel('$flujo\left({\frac{{ml}}{{min}}} \right)$',...
           'FontSize',16,'interpreter','Latex') 
    leyenda1 = {'$C{H_4}$','$C{O_2}$','$CO$',...
                '${H_2}$','${H_2}O$','${N_2}$'};
    legend(ax1,fp,leyenda1,'Location','north','Orientation',...
                           'horizontal','FontSize',6,...
                           'interpreter','Latex');
hold off
print(fig1,'-dpdf','-r500','RLFR1105') 
close all
end