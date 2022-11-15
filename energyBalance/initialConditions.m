function u = initialConditions(Global)
    % Funci�n que permite determinar las condiciones iniciales para cada
    % variable dependiente del modelo.
    % ----------------------------| ENTRADAS |---------------------------------
    %      C(i)in = Concentraci�n de entrada de las especies               i
    %          zg = altura para cada punto del mallado                    [cm]
    %     Num_esp = n�mero de especies                                     [#]
    % ----------------------------| SALIDAS |----------------------------------
    %       u = vector con los valores iniciales de cada variable dependiente
    %   ncall = valor inicial de llamadas a la funci�n pdeDRM
    % -------------------------------------------------------------------------
    global ncall

        zg      = Global.zg;
        Num_esp = Global.Num_esp;
        n       = length(zg);
        u       = zeros((Num_esp*n),1);
    % ---------- Inicio - Especies - Fase Gas - Burbuja & Estela --------------
        u1b = zeros(n,1);   u2b = zeros(n,1); 
        u3b = zeros(n,1);   u4b = zeros(n,1);
        u5b = zeros(n,1);   u6b = zeros(n,1);
    % ---------- Inicio - Especies - Fase Gas - Emulsi�n ----------------------
        u1e = zeros(n,1);   u2e = zeros(n,1); 
        u3e = zeros(n,1);   u4e = zeros(n,1);
        u5e = zeros(n,1);   u6e = zeros(n,1);  
    % ---------- Inicio - Especies - Fase S�lido - Estela ---------------------
        u7w = zeros(n,1); 
    % ---------- Inicio - Especies - Fase S�lido - Emulsi�n -------------------
        u7e = zeros(n,1); 
    % ---------- Initial Condition - Temperature - Burbuja & Estela -----------
        u8b = zeros(n,1);   
    % ---------- Initial Condition - Temperature - Emulsion ------------------- 
        u8e = zeros(n,1); 
    % ----------------------------| FASE GAS |---------------------------------
    % ---------- u1b = CH4 burbuja --------------------------------------------
        for i = 1:n, u1b(i) = 2e-6;    u(i+0*n) = u1b(i);     end
    % ---------- u2b = CO2 burbuja --------------------------------------------
        for i = 1:n, u2b(i) = 2e-6;    u(i+1*n) = u2b(i);     end
    % ---------- u3b = CO burbuja --------------------------------------------- 
        for i = 1:n, u3b(i) = 0.000;   u(i+2*n) = u3b(i);     end
    % ---------- u4b = H2 burbuja ---------------------------------------------
        for i = 1:n, u4b(i) = 0.000;   u(i+3*n) = u4b(i);     end
    % ---------- u5b = H2O burbuja --------------------------------------------
        for i = 1:n, u5b(i) = 0.000;   u(i+4*n) = u5b(i);     end
    % ---------- u6b = N2 burbuja ---------------------------------------------
        for i = 1:n, u6b(i) = 1e-7;    u(i+5*n) = u6b(i);     end
    % ---------- u1e = CH4 emulsi�n -------------------------------------------
        for i = 1:n, u1e(i) = 2e-6;    u(i+6*n) = u1e(i);     end
    % ---------- u2e = CO2 emulsi�n -------------------------------------------
        for i = 1:n, u2e(i) = 2e-6;    u(i+7*n) = u2e(i);     end
    % ---------- u3e = CO emulsi�n --------------------------------------------
        for i = 1:n, u3e(i) = 0.000;   u(i+8*n) = u3e(i);     end
    % ---------- u4e = H2 emulsi�n --------------------------------------------
        for i = 1:n, u4e(i) = 0.000;   u(i+9*n) = u4e(i);     end
    % ---------- u5e = H2O emulsi�n -------------------------------------------
        for i = 1:n, u5e(i) = 0.000;   u(i+10*n) = u5e(i);    end
    % ---------- u6e = N2 emulsi�n --------------------------------------------
        for i = 1:n, u6e(i) = 1e-7;    u(i+11*n) = u6e(i);    end
    % ---------- u7w = Coque Estela -------------------------------------------
        for i = 1:n, u7w(i) = 1e-7;    u(i+12*n) = u7w(i);    end
    % ---------- u7e = Coque Emulsi�n -----------------------------------------
        for i = 1:n, u7e(i) = 1e-7;    u(i+13*n) = u7e(i);    end

    % ---------- u8b =  -----------------------------------------
        for i = 1:n, u8b(i) = 500;    u(i+14*n) = u8b(i);    end
    % ---------- u8b =  -----------------------------------------
        for i = 1:n, u8e(i) = 500;    u(i+15*n) = u8e(i);    end
    % ---------- N�mero de llamadas a la funci�n pdeDRM -----------------------
        ncall = 0;
    end