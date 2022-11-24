function molarFraction = molarFractionFcn(Cgas)
% -------------------------------------------------------------------------
    % molarFraction function 
    % ----------------------------| input |--------------------------------
    %   Cgas = vector with concentration for each species         [mol/cm3]
    % ----------------------------| output |-------------------------------
    % molarFraction = vector with molar fraction for each species        []
% -------------------------------------------------------------------------

    Cgas_sum = sum(Cgas);
    [m, ~] = size(Cgas);
    
    if Cgas_sum == 0

        molarFraction = zeros(m);

    elseif isnan(Cg)
                
        molarFraction = Cgas./Cgas_sum;
        disp('Cg = NaN molarFractionFcn.m')

    else

        molarFraction = Cgas./Cgas_sum;
        
    end
% -------------------------------------------------------------------------

end
