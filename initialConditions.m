function u = initialConditions(Global)
    % initial conditions function
    % ----------------------------| into |-------------------------------------
    %          T0 = Initial reactor temperature                             [K]
    %          zg = height for each mesh point                             [cm]
    %     Num_esp = number of species                                       [#]
    % ----------------------------| out |--------------------------------------
    %           u = initial conditions vector
    % -------------------------------------------------------------------------
        T0      = Global.Tbed;    
        zg      = Global.zg;
        Num_esp = Global.Num_esp;
        n       = length(zg);
        u       = zeros((Num_esp*n),1);
    % ---------- gas species - Bubble & Wake phases----------------------------
        u1b = zeros(n,1);   u2b = zeros(n,1); 
        u3b = zeros(n,1);   u4b = zeros(n,1);
        u5b = zeros(n,1);   u6b = zeros(n,1);
    % ---------- gas species - Emulsion phase ---------------------------------
        u1e = zeros(n,1);   u2e = zeros(n,1); 
        u3e = zeros(n,1);   u4e = zeros(n,1);
        u5e = zeros(n,1);   u6e = zeros(n,1);  
    % ---------- solid specie - Wake phase ------------------------------------
        u7w = zeros(n,1); 
    % ---------- solid specie - Emulsion phase --------------------------------
        u7e = zeros(n,1); 
    % ---------- initial condition - Temperature - Bubble & Wake phase --------
        u8b = zeros(n,1);   
    % ---------- initial condition - Temperature - Emulsion phase -------------
        u8e = zeros(n,1); 
    % -------------------------------------------------------------------------
    % ----------------------------| gas phase |--------------------------------
    % ---------- u1b = CH4 bubble ---------------------------------------------
        for i = 1:n, u1b(i) = 2e-6;    u(i+0*n) = u1b(i);     end
    % ---------- u2b = CO2 bubble ---------------------------------------------
        for i = 1:n, u2b(i) = 2e-6;    u(i+1*n) = u2b(i);     end
    % ---------- u3b = CO bubble ---------------------------------------------- 
        for i = 1:n, u3b(i) = 0.000;   u(i+2*n) = u3b(i);     end
    % ---------- u4b = H2 bubble ----------------------------------------------
        for i = 1:n, u4b(i) = 0.000;   u(i+3*n) = u4b(i);     end
    % ---------- u5b = H2O bubble ---------------------------------------------
        for i = 1:n, u5b(i) = 0.000;   u(i+4*n) = u5b(i);     end
    % ---------- u6b = N2 bubble ----------------------------------------------
        for i = 1:n, u6b(i) = 1e-7;    u(i+5*n) = u6b(i);     end
    % ---------- u1e = CH4 emulsion -------------------------------------------
        for i = 1:n, u1e(i) = 2e-6;    u(i+6*n) = u1e(i);     end
    % ---------- u2e = CO2 emulsion -------------------------------------------
        for i = 1:n, u2e(i) = 2e-6;    u(i+7*n) = u2e(i);     end
    % ---------- u3e = CO emulsion --------------------------------------------
        for i = 1:n, u3e(i) = 0.000;   u(i+8*n) = u3e(i);     end
    % ---------- u4e = H2 emulsion --------------------------------------------
        for i = 1:n, u4e(i) = 0.000;   u(i+9*n) = u4e(i);     end
    % ---------- u5e = H2O emulsion -------------------------------------------
        for i = 1:n, u5e(i) = 0.000;   u(i+10*n) = u5e(i);    end
    % ---------- u6e = N2 emulsion --------------------------------------------
        for i = 1:n, u6e(i) = 1e-7;    u(i+11*n) = u6e(i);    end
    % ---------- u7w = Coke wake ----------------------------------------------
        for i = 1:n, u7w(i) = 1e-7;    u(i+12*n) = u7w(i);    end
    % ---------- u7e = Coke emulsion ------------------------------------------
        for i = 1:n, u7e(i) = 1e-7;    u(i+13*n) = u7e(i);    end
    % ---------- u8b = Temperature Bubble & Wake phases -----------------------
        for i = 1:n, u8b(i) = T0;      u(i+14*n) = u8b(i);    end
    % ---------- u8b = Temperature Emulsion phase -----------------------------
        for i = 1:n, u8e(i) = T0;      u(i+15*n) = u8e(i);    end
    % ---------- N�mero de llamadas a la funci�n pdeDRM -----------------------
    end