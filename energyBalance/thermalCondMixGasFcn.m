function lambdaMix = thermalCondMixGasFcn(Global, T, Cgas)
% -------------------------------------------------------------------------
    % thermalCondMixGasFcn function calculates the thermal conductivity 
    % of mix gas
    % ----------------------------| input |--------------------------------
    %  Global = constant values structure   
    %  T = bubble|emulsion temperature                                  [K]
    %  Cgas_e = concentration vector of each species (emulsion)   [mol/cm3]

    % Tc = vector with temperature for each specie, critical constant   [k]
    % Pc = vector with pressure for each specie, critical constant    [bar]
    %  M = vector with molecular weight for each specie             [g/mol]

    % lam_p = vector with thermal conductivity for each specie
    %   E   = numeral constant near to 1   
    %    Y  = vector with molar fraction for each specie

  % ----------------------------| output |---------------------------------
  %   kg = thermal conductivity for a gas mixture                 [W/ cm K]
% -------------------------------------------------------------------------

       Pc = Global.Pc; 
       Tc = Global.Tc;
        M = Global.MM;
    lam_p = 0;
        Y = molarFractionFcn(Cgas);


    Tr = T./Tc;
    r  = 210*(Tc.*(M.^3)./(Pc.^4)).^(1/6);

        n = length(lam_p);
        E = 1;
    lamtr = ((exp(0.0464.*Tr)) - (exp(-0.2412.*Tr)));
        A_ij = zeros(n);
            
    for i = 1:n

        for j = 1:n
            lamtr_ij = (r(j)*lamtr(i))/(r(i)*lamtr(j));
            A_ij(i,j) = E*(1 + ((lamtr_ij)^(1/2))*((M(i)/M(j))^(1/4)))^2/ ...
                        (8*(1 + (M(i)/M(j))))^(1/2);

        end

    end
    A_ij(A_ij == diag(A_ij)) = 1;
        index_1 = zeros(1,n);
        index_2 = zeros(1,n);

    for i = 1:n

        for j = 1:n

            index_2(j) = Y(j)*A_ij(i,j); 

        end

        index_1(i) = Y(i)*lam_p(i)/sum(index_2);

    end

    lambdaMix = sum(index_1);

% -------------------------------------------------------------------------
end