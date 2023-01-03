clc
clear 
close all

T = [10; 20; 40; 60; 80; 100; 200; 300; 400; 500; 600; 800; 1000; 1200; 1400];
tc = [7; 32; 121; 174; 160; 125; 55; 36; 26; 20; 16; 10; 8; 7; 6];


%% Fit: 'untitled fit 5'.
[xData, yData] = prepareCurveData( T, tc );

% Set up fittype and options.
ft = 'linearinterp';

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft);

% Plot fit with data.
figure( 'Name', 'untitled fit 5' );
h = plot( fitresult, xData, yData );
legend( h, 'thermal conductivity vs. T', 'FIT', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'T [K]', 'Interpreter', 'none' );
ylabel( 'thermal conductivity [W / m K]', 'Interpreter', 'none' );
grid on