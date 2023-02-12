function a = activityFcn( Cc, kinetic )
% -------------------------------------------------------------------------
    % activityFcn - is a function that calculates the catalyst activity
    % ----------------------------| input |--------------------------------
    %        Cc = coke concentration                         [g-coke/g-cat] 
    %   kinetic = a structure that contains the kinetic constants
    % -----
    %   CcMax   = max coke concentration                    [g-coke/g-cata]
    % ----------------------------| output |-------------------------------
    %         a = the catalyst activity                                  []
% -------------------------------------------------------------------------

    global ncall
    
    CcMax = kinetic.CcMax;

    a     = (1-(Cc/CcMax))^2;

    if ncall > 497
        if Cc > CcMax, a = 0; end
        if Cc < 0,     a = 1; end
    end
% -------------------------------------------------------------------------
end