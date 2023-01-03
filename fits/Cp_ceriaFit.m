clc
clear 
close all

T =  [298.15; 300.00; 400.00; 500.00; 600.00; 700.00; 800.00; 900.00; 999.00];
Cp = [26.895; 26.921; 28.336; 29.750; 31.165; 32.809; 34.449; 36.088; 37.711];

%% Fit: ' ceria'.
[xData, yData] = prepareCurveData( T, Cp );

% Set up fittype and options.
ft = fittype( 'smoothingspline' );

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft );

% Plot fit with data.
figure( 'Name', 'Fit' );
h = plot( fitresult, xData, yData );
legend( h, 'Cp vs. T', 'Fit', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'T [K]', 'Interpreter', 'none' );
ylabel( 'Cp [J/mol K]', 'Interpreter', 'none' );
grid on