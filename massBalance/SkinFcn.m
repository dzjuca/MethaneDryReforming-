function [CiBW,CiE] = SkinFcn(t,u)
  global zg A fw Emf 
         tseg = t; tmin = t/60; thor = t/3600;
% ---------- Configuración - Vector de salida -----------------------------
  index1 = length(t); % tiempo
  index2 = length(zg);% espacio
  index3 = 6;         % # de compuestos
% ---------- Fase Gas - Burbuja & Estela ----------------------------------
u1b = zeros(index1,index2); u2b = zeros(index1,index2); 
u3b = zeros(index1,index2); u4b = zeros(index1,index2); 
u5b = zeros(index1,index2); u6b = zeros(index1,index2);
% ---------- Fase Gas - Emulsión ------------------------------------------
u1e = zeros(index1,index2); u2e = zeros(index1,index2); 
u3e = zeros(index1,index2); u4e = zeros(index1,index2); 
u5e = zeros(index1,index2); u6e = zeros(index1,index2);
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
    end
% ----- Concentración - Especies (GAS) Burbuja & Estela [mmol/cm3] --------
  CiBW(:,:,1) = u1b; CiBW(:,:,2) = u2b; CiBW(:,:,3) = u3b;
  CiBW(:,:,4) = u4b; CiBW(:,:,5) = u5b; CiBW(:,:,6) = u6b;
% ----- Concentración - Especies (GAS) Emulsión [mmol/cm3] ----------------
   CiE(:,:,1) = u1e; CiE(:,:,2) = u2e; CiE(:,:,3) = u3e;
   CiE(:,:,4) = u4e; CiE(:,:,5) = u5e; CiE(:,:,6) = u6e;
% -------------------------------------------------------------------------
  TAG1 = {'${C_{C{H_4}}}\left( {\frac{{mmol}}{{c{m^3}}}} \right)$',...
          '${C_{C{O_2}}}\left( {\frac{{mmol}}{{c{m^3}}}} \right)$',...
          '${C_{CO}}\left( {\frac{{mmol}}{{c{m^3}}}} \right)$'    ,...
          '${C_{{H_2}}}\left( {\frac{{mmol}}{{c{m^3}}}} \right)$' ,...
          '${C_{{H_2}O}}\left( {\frac{{mmol}}{{c{m^3}}}} \right)$',...
          '${C_{{N_2}}}\left( {\frac{{mmol}}{{c{m^3}}}} \right)$' ,...
'${C_{coque}}\left( {\frac{{{g_{coque}}}}{{{g_{catalizador}}}}} \right)$',...
'${C_i}\left( {\frac{{mol}}{{c{m^3}}}} \right)$'};
  TAG2 = {'CH4','CO2','CO','H2','H2O','N2','Coque'};
  TAG3 = {'ConTiempo','ConEspacio'};
  TAG4 = {'BW','E','W','TOTAL'};
  TAG5 = {'CONCENTRACIONES','CONVERSIONES','FLUJOS'};
% --------------------------| FASE GAS BURBUJA |---------------------------
% ---------- Gráfico - Concentración vs tiempo ----------------------------
   id = exist('CONCENTRACIONES','file');
            if id == 7
               dir = strcat(pwd,'/',TAG5{1},'/',TAG3{1},TAG4{1});
            else
                mkdir('CONCENTRACIONES')
               dir = strcat(pwd,'/',TAG5{1},'/',TAG3{1},TAG4{1});
            end
  for ii = 1:index3
   fig1 = figure;
          set(fig1,'Units','centimeters',...
                   'PaperPosition',[0 0 15 15],...
                   'PaperSize', [15,15]);
    ax1 = axes('Parent',fig1,'FontSize',12,'XGrid','off',...
            'YGrid','off','visible','on','Box', 'on',...
            'TickLabelInterpreter','latex');
          set(fig1, 'Color', 'w') 
    hold on
    for i = 1:index2
            plot(tmin,CiBW(:,i,ii),'ko-','MarkerSize',3);
    end 
    xlabel('$tiempo\;\left( {min} \right)$',...
           'FontSize',16,'interpreter','Latex')
    ylabel(TAG1(ii),...
           'FontSize',20,'interpreter','Latex') 
    max1 = max(max(CiBW(:,:,ii))); 
    max1 = max1 + max1*0.2;
    min1 = min(min(CiBW(:,:,ii)));
    min1 = min1 - min1*0.2;
    max2 = max(tmin);
%     xlim([0 max2])
%     ylim([0 max1])
    hold off
    dir1 = strcat(dir,TAG2{ii});
    print(fig1,'-dpdf','-r500',dir1)
  end
  close all
% ---------- Gráfico - Concentración vs espacio ---------------------------
   id = exist('CONCENTRACIONES','file');
            if id == 7
               dir = strcat(pwd,'/',TAG5{1},'/',TAG3{2},TAG4{1});
            else
                mkdir('CONCENTRACIONES')
               dir = strcat(pwd,'/',TAG5{1},'/',TAG3{2},TAG4{1});
            end
  for ii = 1:index3
    fig2 = figure;
          set(fig2,'Units','centimeters',...
                   'PaperPosition',[0 0 15 15],...
                   'PaperSize', [15,15]);
    ax2 = axes('Parent',fig2,'FontSize',12,'XGrid','off',...
            'YGrid','off','visible','on','Box', 'on',...
            'TickLabelInterpreter','latex');
          set(fig2, 'Color', 'w') 
    hold on
    for i = 1:index1
            plot(zg,CiBW(i,:,ii)','ko-','MarkerSize',3);
    end   
    xlabel('$z\left( {cm} \right)$',...
           'FontSize',16,'interpreter','Latex')
    ylabel(TAG1(ii),...
           'FontSize',20,'interpreter','Latex') 
    max1 = max(max(CiBW(:,:,ii))); 
    max1 = max1 + max1*0.2;
    max2 = max(zg); 
    max2 = max2 + max1*0.05;
    min1 = min(min(CiBW(:,:,ii)));
    min1 = min1 - min1*0.2;
%     xlim([0 max2])
%     ylim([0 max1])
    hold off
    dir1 = strcat(dir,TAG2{ii});
    print(fig2,'-dpdf','-r500',dir1)
  end
close all 
% --------------------------| FASE GAS EMULSIÓN |--------------------------
% ---------- Gráfico - Concentración vs tiempo ----------------------------
   id = exist('CONCENTRACIONES','file');
            if id == 7
               dir = strcat(pwd,'/',TAG5{1},'/',TAG3{1},TAG4{2});
            else
                mkdir('CONCENTRACIONES')
               dir = strcat(pwd,'/',TAG5{1},'/',TAG3{1},TAG4{2});
            end
  for ii = 1:index3
   fig1 = figure;
          set(fig1,'Units','centimeters',...
                   'PaperPosition',[0 0 15 15],...
                   'PaperSize', [15,15]);
    ax1 = axes('Parent',fig1,'FontSize',12,'XGrid','off',...
            'YGrid','off','visible','on','Box', 'on',...
            'TickLabelInterpreter','latex');
          set(fig1, 'Color', 'w') 
    hold on
    for i = 1:index2
            plot(tmin,CiE(:,i,ii),'ko-','MarkerSize',3);
    end 
    xlabel('$tiempo\;\left( {min} \right)$',...
           'FontSize',16,'interpreter','Latex')
    ylabel(TAG1(ii),...
           'FontSize',20,'interpreter','Latex') 
    max1 = max(max(CiE(:,:,ii))); 
    max1 = max1 + max1*0.2;
    max2 = max(tmin);
    min1 = min(min(CiE(:,:,ii)));
    min1 = min1 - min1*0.2;
%     xlim([0 max2])
%     ylim([0 max1])
    hold off
    dir1 = strcat(dir,TAG2{ii});
    print(fig1,'-dpdf','-r500',dir1)
  end
  close all
% ---------- Gráfico - Concentración vs espacio ---------------------------
   id = exist('CONCENTRACIONES','file');
            if id == 7
               dir = strcat(pwd,'/',TAG5{1},'/',TAG3{2},TAG4{2});
            else
                mkdir('CONCENTRACIONES')
               dir = strcat(pwd,'/',TAG5{1},'/',TAG3{2},TAG4{2});
            end
  for ii = 1:index3
    fig2 = figure;
          set(fig2,'Units','centimeters',...
                   'PaperPosition',[0 0 15 15],...
                   'PaperSize', [15,15]);
    ax2 = axes('Parent',fig2,'FontSize',12,'XGrid','off',...
            'YGrid','off','visible','on','Box', 'on',...
            'TickLabelInterpreter','latex');
          set(fig2, 'Color', 'w') 
    hold on
    for i = 1:index1
            plot(zg,CiE(i,:,ii)','ko-','MarkerSize',3);
    end   
    xlabel('$z\left( {cm} \right)$',...
           'FontSize',16,'interpreter','Latex')
    ylabel(TAG1(ii),...
           'FontSize',20,'interpreter','Latex') 
    max1 = max(max(CiE(:,:,ii))); 
    max1 = max1 + max1*0.2;
    max2 = max(zg); 
    max2 = max2 + max1*0.05;
    min1 = min(min(CiE(:,:,ii)));
    min1 = min1 - min1*0.2;
%     xlim([0 max2])
%     ylim([0 max1])
    hold off
    dir1 = strcat(dir,TAG2{ii});
    print(fig2,'-dpdf','-r500',dir1)
  end
  close all
% ---------- Gráfico Espacial a tiempo final ------------------------------
% --------------------------| FASE GAS BURBUJA |---------------------------
[m,~,~] = size(CiBW);
 id = exist('CONCENTRACIONES','file');
            if id == 7
               dir = strcat(pwd,'/',TAG5{1},'/',TAG3{2},'B','TOTAL');
            else
                mkdir('CONCENTRACIONES')
               dir = strcat(pwd,'/',TAG5{1},'/',TAG3{2},'B','TOTAL');
            end
    fig2 = figure;
          set(fig2,'Units','centimeters',...
                   'PaperPosition',[0 0 15 15],...
                   'PaperSize', [15,15]);
    axes('Parent',fig2,'FontSize',12,'XGrid','off',...
         'YGrid','off','visible','on','Box', 'on', ...
         'TickLabelInterpreter','latex');
          set(fig2, 'Color', 'w') 
    hold on
            plot(zg,CiBW(m,:,1)','ko-','MarkerSize',3);
            plot(zg,CiBW(m,:,2)','ks-','MarkerSize',3);
            plot(zg,CiBW(m,:,3)','kp-','MarkerSize',3);
            plot(zg,CiBW(m,:,4)','kd-','MarkerSize',3);
            plot(zg,CiBW(m,:,5)','k*-','MarkerSize',3);
            plot(zg,CiBW(m,:,6)','k--','MarkerSize',3);
    ley1 = {'$C{H_4}$','$C{O_2}$','$CO$','${H_2}$','${H_2}O$','${N_2}$'};
    legend(ley1,'Interpreter','Latex',     ...
                'Location','north',        ...
                'Orientation','horizontal',...
                'FontSize',8)
    xlabel('$z\left( {cm} \right)$',...
           'FontSize',16,'interpreter','Latex')
    ylabel(TAG1(8),...
           'FontSize',20,'interpreter','Latex') 
    max1 = max(max(CiBW(m,:,1:6)));
    max1 = max1 + max1*0.15;
    ylim([0 max1])
    max2 = max(zg); 
    max2 = max2 + max2*0.05;
    xlim([0 max2])
    hold off
    print(fig2,'-dpdf','-r500',dir)
  close all
% --------------------------| FASE GAS EMULSIÓN |--------------------------
[m,~,~] = size(CiE);
 id = exist('CONCENTRACIONES','file');
            if id == 7
               dir = strcat(pwd,'/',TAG5{1},'/',TAG3{2},'E','TOTAL');
            else
                mkdir('CONCENTRACIONES')
               dir = strcat(pwd,'/',TAG5{1},'/',TAG3{2},'E','TOTAL');
            end
    fig2 = figure;
          set(fig2,'Units','centimeters',...
                   'PaperPosition',[0 0 15 15],...
                   'PaperSize', [15,15]);
    axes('Parent',fig2,'FontSize',12,'XGrid','off',...
         'YGrid','off','visible','on','Box', 'on', ...
         'TickLabelInterpreter','latex');
          set(fig2, 'Color', 'w') 
    hold on
            plot(zg,CiE(m,:,1)','ko-','MarkerSize',3);
            plot(zg,CiE(m,:,2)','ks-','MarkerSize',3);
            plot(zg,CiE(m,:,3)','kp-','MarkerSize',3);
            plot(zg,CiE(m,:,4)','kd-','MarkerSize',3);
            plot(zg,CiE(m,:,5)','k*-','MarkerSize',3);
            plot(zg,CiE(m,:,6)','k--','MarkerSize',3);
    ley1 = {'$C{H_4}$','$C{O_2}$','$CO$','${H_2}$','${H_2}O$','${N_2}$'};
    legend(ley1,'Interpreter','Latex',     ...
                'Location','north',        ...
                'Orientation','horizontal',...
                'FontSize',8)
    xlabel('$z\left( {cm} \right)$',...
           'FontSize',16,'interpreter','Latex')
    ylabel(TAG1(8),...
           'FontSize',20,'interpreter','Latex') 
    max1 = max(max(CiE(m,:,1:6)));
    max1 = max1 + max1*0.15;
    ylim([0 max1])
    max2 = max(zg); 
    max2 = max2 + max2*0.05;
    xlim([0 max2])
    hold off
    print(fig2,'-dpdf','-r500',dir)
  close all
% ---------- Gráfico Temporal - salida del reactor ------------------------
% --------------------------| FASE GAS BURBUJA |---------------------------
[~,n,~] = size(CiBW);
 id = exist('CONCENTRACIONES','file');
            if id == 7
               dir = strcat(pwd,'/',TAG5{1},'/',TAG3{1},'B','TOTAL');
            else
                mkdir('CONCENTRACIONES')
               dir = strcat(pwd,'/',TAG5{1},'/',TAG3{1},'B','TOTAL');
            end
    fig2 = figure;
          set(fig2,'Units','centimeters',...
                   'PaperPosition',[0 0 15 15],...
                   'PaperSize', [15,15]);
    axes('Parent',fig2,'FontSize',12,'XGrid','off',...
         'YGrid','off','visible','on','Box', 'on', ...
         'TickLabelInterpreter','latex');
          set(fig2, 'Color', 'w') 
    hold on
            plot(tmin,CiBW(:,n,1)','ko-','MarkerSize',3);
            plot(tmin,CiBW(:,n,2)','ks-','MarkerSize',3);
            plot(tmin,CiBW(:,n,3)','kp-','MarkerSize',3);
            plot(tmin,CiBW(:,n,4)','kd-','MarkerSize',3);
            plot(tmin,CiBW(:,n,5)','k*-','MarkerSize',3);
            plot(tmin,CiBW(:,n,6)','k--','MarkerSize',3);
    ley1 = {'$C{H_4}$','$C{O_2}$','$CO$','${H_2}$','${H_2}O$','${N_2}$'};
    legend(ley1,'Interpreter','Latex',     ...
                'Location','north',        ...
                'Orientation','horizontal',...
                'FontSize',8)
    xlabel('$tiempo\left( {min} \right)$',...
           'FontSize',16,'interpreter','Latex')
    ylabel(TAG1(8),...
           'FontSize',20,'interpreter','Latex') 
    max1 = max(max(CiBW(:,n,1:6)));
    max1 = max1 + max1*0.15;
    ylim([0 max1])
    max2 = max(tmin); 
    max2 = max2 + max2*0.05;
    xlim([0 max2])
    hold off
    print(fig2,'-dpdf','-r500',dir)
  close all
% --------------------------| FASE GAS EMULSIÓN |--------------------------  
  [~,n,~] = size(CiE);
 id = exist('CONCENTRACIONES','file');
            if id == 7
               dir = strcat(pwd,'/',TAG5{1},'/',TAG3{1},'E','TOTAL');
            else
                mkdir('CONCENTRACIONES')
               dir = strcat(pwd,'/',TAG5{1},'/',TAG3{1},'E','TOTAL');
            end
    fig2 = figure;
          set(fig2,'Units','centimeters',...
                   'PaperPosition',[0 0 15 15],...
                   'PaperSize', [15,15]);
    axes('Parent',fig2,'FontSize',12,'XGrid','off',...
         'YGrid','off','visible','on','Box', 'on', ...
         'TickLabelInterpreter','latex');
          set(fig2, 'Color', 'w') 
    hold on
            plot(tmin,CiE(:,n,1)','ko-','MarkerSize',3);
            plot(tmin,CiE(:,n,2)','ks-','MarkerSize',3);
            plot(tmin,CiE(:,n,3)','kp-','MarkerSize',3);
            plot(tmin,CiE(:,n,4)','kd-','MarkerSize',3);
            plot(tmin,CiE(:,n,5)','k*-','MarkerSize',3);
            plot(tmin,CiE(:,n,6)','k--','MarkerSize',3);
    ley1 = {'$C{H_4}$','$C{O_2}$','$CO$','${H_2}$','${H_2}O$','${N_2}$'};
    legend(ley1,'Interpreter','Latex',     ...
                'Location','north',        ...
                'Orientation','horizontal',...
                'FontSize',8)
    xlabel('$tiempo\left( {min} \right)$',...
           'FontSize',16,'interpreter','Latex')
    ylabel(TAG1(8),...
           'FontSize',20,'interpreter','Latex') 
    max1 = max(max(CiE(:,n,1:6)));
    max1 = max1 + max1*0.15;
    ylim([0 max1])
    max2 = max(tmin); 
    max2 = max2 + max2*0.05;
    xlim([0 max2])
    hold off
    print(fig2,'-dpdf','-r500',dir)
  close all
end