function molarFraction = molarFractionFcn(Cg)

    Cg_sum = sum(Cg);
    [m, ~] = size(Cg);
    
    if Cg_sum == 0

        molarFraction = zeros(m);

    elseif isnan(Cg)
                
        molarFraction = Cg./Cg_sum;
        disp('Cg = NaN molarFractionFcn.m')

    else

        molarFraction = Cg./Cg_sum;
        
    end

end
