lambda = 50;                                                                % [W/mK]
L = 0.5;                                                                    % [m]
theta0 = 100;                                                               % [°C]
k = 0.1;                                                                    % [h^-1]

theta = @(x,t) theta0 .* exp(-k * t) .* sin((x * pi)./(L*2) + pi/4);

%% a)
x = [0; L; L/2];
t1 = 10;                                                                    % [h]
theta1 = theta(x,t1);
fprintf(1,['Aufgabe 1.6 a)\n', ...
    '\tTemperatur [°C] nach t1 = %.1fh an den Stellen\n', ...
    '\tx=0\t\tx=L\t\tx=L/2\n',...
    '\t%.3f\t%.3f\t%.3f\n'], t1, theta1);
    