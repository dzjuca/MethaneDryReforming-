function kg = thermalCondMixGasFcn(Global, T_z, Cgas)
% -------------------------------------------------------------------------
    % thermalCondMixGasFcn function calculates the thermal conductivity 
    % of mix gas
    % ----------------------------| input |--------------------------------
    %  Global = constant values structure   
    %     T_z = bubble|emulsion temperature  f(z)                       [K]
    %    Cgas = concentration vector of each species 
    %                                   (bubble|emulsion)         [mol/cm3]

    % Tc = vector with temperature for each specie, critical constant   [k]
    % Pc = vector with pressure for each specie, critical constant    [bar]
    %  M = vector with molecular weight for each specie             [g/mol]

    %  kg_i = vector with thermal conductivity for each specie
    %   E   = numeral constant near to 1   
    %  Y_z  = vector with molar fraction for each specie f(z)

  % ----------------------------| output |---------------------------------
  %      kg = thermal conductivity for a gas mixture              [W/ cm K]
% -------------------------------------------------------------------------

    [lf, ~] = size(fields(Global.Pcr));
    Pc      = zeros(1,lf); 
    Tc      = zeros(1,lf); 
    M       = zeros(1,lf); 
    flds    = fields(Global.Pcr);

    for l = 1:lf

        Pc(1,l)    = Global.Pcr.(flds{l});
        Tc(1,l)    = Global.Tcr.(flds{l});
        M(1,l)     = Global.MM.(flds{l});

    end

    E     = Global.E;
    nmesh = Global.n;

    Y_z   = molarFractionFcn(Cgas);
    kg    = zeros(nmesh,1);

    for k = 1:nmesh

        T    = T_z(k);
        Y    = Y_z(k);
        kg_i = thermalCondFcn();

        Tr = T./Tc;
        r  = 210*(Tc.*(M.^3)./(Pc.^4)).^(1/6);
    
        n     = length(kg_i);
        lamtr = ((exp(0.0464.*Tr)) - (exp(-0.2412.*Tr)));
        A_ij  = zeros(n);
                
        for i = 1:n
    
            for j = 1:n

                lamtr_ij  = (r(j)*lamtr(i))/(r(i)*lamtr(j));
                A_ij(i,j) = E*(1 + ((lamtr_ij)^(1/2))*((M(i)/M(j))^(1/4)))^2/ ...
                            (8*(1 + (M(i)/M(j))))^(1/2);
    
            end
    
        end

        A_ij(A_ij == diag(A_ij)) = 1;
        index_1    = zeros(1,n);
        index_2    = zeros(1,n);
    
        for i = 1:n
    
            for j = 1:n
    
                index_2(j) = Y(j)*A_ij(i,j); 
    
            end
    
            index_1(i) = Y(i)*kg_i(i)/sum(index_2);
    
        end
    
        kg(k) = sum(index_1);

    end
% -------------------------------------------------------------------------
end