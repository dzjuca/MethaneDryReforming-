function skinTemperatureFcn(t,u,Global)
    zg   = Global.zg;
    A    = Global.A;
    fw   = Global.fw;
    Emf  = Global.Emf;

    tseg = t; 
    tmin = t/60; 
    thor = t/3600;
    % ---------- -----------------------------
      index1 = length(t); % tiempo
      index2 = length(zg);% espacio
    % ---------- -----------------------------
    Tb = zeros(index1,index2);
    Te = zeros(index1,index2);
    Tb(:,:) = u(:, 421:450);
    Te(:,:) = u(:, 451:480);
    % ---------- -----------------------------
    id = exist('Temperatura','file');
    if id == 7
        dir = strcat(pwd,'/','Temperatura','/');
    else
        mkdir('Temperatura')
        dir = strcat(pwd,'/','Temperatura','/');
    end

    fig1 = figure;
    set(fig1,'Units','centimeters',...
             'PaperPosition',[0 0 15 15],...
             'PaperSize', [15,15]);
    ax1 = axes('Parent',fig1,'FontSize',10,'XGrid','off',...
               'YGrid','off','visible','on','Box', 'on',...
               'TickLabelInterpreter','latex');
    set(fig1, 'Color', 'w') 

    hold on
        plot(tmin,Tb(:,index2),'ko-','MarkerSize',10);
        plot(tmin,Te(:,index2),'ks-','MarkerSize',10);
        ley1 = {'$T{b}$','$T{e}$'};
        legend(ley1,'Interpreter','Latex',     ...
                    'Location','north',        ...
                    'Orientation','horizontal',...
                    'FontSize',10)
        xlabel('$time\;\left( {min} \right)$',...
            'FontSize',10,'interpreter','Latex')
        ylabel('$T\;(K)$','FontSize',10,'interpreter','Latex') 
        max2 = max(tmin);
        xlim([0 max2])
        ylim([0 1000])
    hold off
    dir1 = strcat(dir,'TemperaturaTiempo.pdf');
    print(fig1,'-dpdf','-r500',dir1)

    % ---------- -----------------------------

    fig2 = figure;
    set(fig2,'Units','centimeters',...
             'PaperPosition',[0 0 15 15],...
             'PaperSize', [15,15]);
    ax1 = axes('Parent',fig2,'FontSize',10,'XGrid','off',...
               'YGrid','off','visible','on','Box', 'on',...
               'TickLabelInterpreter','latex');
    set(fig2, 'Color', 'w') 

    hold on
        plot(zg,Tb(index1,:),'ko-','MarkerSize',10);
        plot(zg,Te(index1,:),'ks-','MarkerSize',10);
        ley1 = {'$T{b}$','$T{e}$'};
        legend(ley1,'Interpreter','Latex',     ...
                    'Location','north',        ...
                    'Orientation','horizontal',...
                    'FontSize',10)
        xlabel('$z\;\left( {cm} \right)$',...
            'FontSize',10,'interpreter','Latex')
        ylabel('$T\;(K)$','FontSize',10,'interpreter','Latex') 
        max2 = max(zg);
        xlim([0 max2])
        ylim([0 1000])
    hold off
    dir1 = strcat(dir,'TemperaturaEspacio.pdf');
    print(fig2,'-dpdf','-r500',dir1)

    % ---------- -----------------------------
    close all
end