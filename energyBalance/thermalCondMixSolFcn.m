function ks_m = thermalCondMixSolFcn(Global, T)
% -------------------------------------------------------------------------
    % thermalCondMixSol - function calculates the thermal conductivity 
    % of solid mix
    % ----------------------------| input |--------------------------------
    %  Global = constant values structure   
    %       T = phase temperature  f(z)                                 [K]
    % -----
    %         Dsol = solid density                                  [g/cm3]
    % tcAluminaFit = fit's structure from thermal-cond. discrete data
    % tcCeriaFit   = fit's structure from thermal-cond. discrete data
    % tcNickelFit  = fit's structure from thermal-cond. discrete data
    % tcAlumina    = thermal conductivity                            [W/mK]
    % tcCeria      = thermal conductivity                            [W/mK]
    % tcNickel     = thermal conductivity                            [W/mK]
    % cAl2O3       = alumina concentration                  [g.Al2O3/g.cat]
    % cNickel      = nickel concentration                      [g.Ni/g.cat]
    % cCeria       = ceria concentration                       [g.Ce/g.cat]
    % mMolarAl2O3   = alumina molar mass                            [g/mol]
    % mMolarNickel  = nickel molar mass                             [g/mol]
    % mMolarCeria   = ceria molar mass                              [g/mol]
    % ----------------------------| output |-------------------------------
    %          ks_m = thermal conductivity for a gas mixture       [W/cm K]
% -------------------------------------------------------------------------

    Dsol         = Global.Dcat;
    tcAluminaFit = Global.tcAluminaFit;
    tcCeriaFit   = Global.tcCeriaFit;
    tcNickelFit  = Global.tcNickelFit;
    tcAlumina    = tcAluminaFit(T)./100;
    tcCeria      = tcCeriaFit(T)./100;
    tcNickel     = tcNickelFit(T)./100;
    cAl2O3       = Global.cAl2O3;
    cNickel      = Global.cNickel;
    cCeria       = Global.cCeria;
    mMolarAl2O3  = Global.mMolarAl2O3;
    mMolarNickel = Global.mMolarNickel;
    mMolarCeria  = Global.mMolarCeria;

    C_alumina = cAl2O3*Dsol/mMolarAl2O3;
    C_nickel  = cNickel*Dsol/mMolarNickel;
    C_Ceria   = cCeria*Dsol/mMolarCeria;

    m_total   = C_alumina + C_Ceria + C_nickel;
    yi        = [C_alumina, C_Ceria, C_nickel]./m_total;
    ksi       = [tcAlumina, tcCeria, tcNickel];
    tmp_1     = yi./ksi; 

           ks_m = 1./(sum(tmp_1, 2));
          index = ks_m < 0;
    ks_m(index) = 0;
% -------------------------------------------------------------------------
% borrar
% ks_m(:,1) = 0.3;

end