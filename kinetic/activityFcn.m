function a = activityFcn( Cc, Global )

    global ncall
    CcMax = Global.CcMax;

    a     = (1-(Cc/CcMax))^2;

    if ncall > 510
        if Cc > CcMax, a = 0; end
        if Cc < 0,     a = 1; end
    end

% -------------------- MODELO DE ACTIVIDAD --------------------------------

end