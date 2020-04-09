lambda = 50;                                                                % [W/mK]
L = 0.5;                                                                    % [m]
theta0 = 100;                                                               % [°C]
k = 0.1;                                                                    % [h^-1]

% theta = @(x,t) theta0 .* exp(-k * t) .* sin((x * pi)./(L*2) + pi/4);
syms t x
theta = theta0 .* exp(-k * t) .* sin((x * pi)./(L*2) + pi/4);
theta = symfun(theta,[x,t]);
theta_grad = diff(theta(x,t));
theta_grad = symfun(theta_grad,[x,t]);

% numeric
x = [0 L L/2];
t0 = 0;                                                                     % [s]
t1 = 10;                                                                    % [h]
t = [t0; t1];
[x,t]=meshgrid(x,t);

%% a)
theta1 = double(vpa(theta(x,t)));
fprintf(1, ['a)\tTemperatur [°C] an den Stellen\n', ...
            '\t\t\t\tx=0\t\tx=L\t\tx=L/2\n',...
            '\tt0 = %.1fs\t%.3f\t%.3f\t%.3f\n'...
            '\tt1 = %.1fh\t%.3f\t%.3f\t%.3f\n'...
            '\n'], [t(:,1), theta1]');

%% b)
thetagrad1 = double(vpa(theta_grad(x,t)));
fprintf(1,['b)\tTemperaturgradient [°C/m] an den Stellen\n', ...
    '\t\t\t\tx=0\t\tx=L\t\tx=L/2\n',...
    '\tt0 = %.1fs\t%.3f\t%.3f\t%.3f\n'...
    '\tt1 = %.1fh\t%.3f\t%.3f\t%.3f\n'...
    '\n'], [t(:,1), thetagrad1]');