function hr = hrFcn(Global, T)
% -------------------------------------------------------------------------
    % hr-function calculates the radiation heat transfer coefficient
    % ----------------------------| input |--------------------------------
    %     Global = constant values structure 
    %          T = phase temperature                                    [K]
    % -----
    %      sigma = stefan-boltzman-coefficient                     [W/m2K4]
    %     k_wall = emissivity of heat transfer surface                   []
    %     k_bed  = emissivity of the bed surface                         []
    % ----------------------------| output |-------------------------------
    %        hr = the radiation heat transfer coefficient          [xxxxxx] ========> revisar unidades
% -------------------------------------------------------------------------

    sigma  = Global.OHTC.sigma;    
    k_wall = Global.OHTC.k_wall;      
    k_bed  = Global.OHTC.k_bed;    
    T_wall = Global.Twall;

    k_b_w  = ((1/k_bed) + (1/k_wall) - 1)^(-1);
    hr     = sigma.*k_b_w.*(T.^2 + T_wall.^2).*(T + T_wall);
% -------------------------------------------------------------------------
end