lambda = 50;                                                                % [W/mK]
L = 0.5;                                                                    % [m]
theta0 = 100;                                                               % [°C]
k = 0.1;                                                                    % [h^-1]

theta = @(x,t) theta0 .* exp(-k * t) .* sin((x * pi)./(L*2) + pi/4);

x = [0; L; L/2];
t0 = 0;                                                                     % [s]
t1 = 10;                                                                    % [h]
t = [t0 t1];

%% a)
theta1 = theta(x,t);
fprintf(1, ['a)\tTemperatur [°C] an den Stellen\n', ...
            '\t\t\t\tx=0\t\tx=L\t\tx=L/2\n',...
            '\tt0 = %.1fs\t%.3f\t%.3f\t%.3f\n'...
            '\tt1 = %.1fh\t%.3f\t%.3f\t%.3f\n'...
            '\n'], [t; theta1]);

%% b)
theta_grad = @(theta,x,t) gradient(theta(x,t),x);
thetagrad1 = theta_grad(theta,x,t1);
fprintf(1,['b)\tTemperaturgradient [°C/m] nach t1 = %.1fh an den Stellen\n', ...
    '\tx=0\t\tx=L\t\tx=L/2\n',...
    '\t%.3f\t%.3f\t%.3f\n'], t1, thetagrad1);