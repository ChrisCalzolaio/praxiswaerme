lambda = 50;                                                                % [W/mK]
L = 0.5;                                                                    % [m]
theta0 = 100;                                                               % [°C]
k = 0.1;                                                                    % [h^-1]

% theta = @(x,t) theta0 .* exp(-k * t) .* sin((x * pi)./(L*2) + pi/4);
syms t x
theta = theta0 .* exp(-k * t) .* sin((x * pi)./(L*2) + pi/4);
theta = symfun(theta,[x,t]);

theta_gradx = symfun(diff(theta(x,t),x),[x,t]);
theta_gradt = symfun(diff(theta(x,t),t),[x,t]);

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
thetagrad1 = double(vpa(theta_gradx(x,t)));
fprintf(1,['b)\tTemperaturgradient [°C/m] an den Stellen\n', ...
           '\t\t\t\tx=0\t\tx=L\t\tx=L/2\n',...
           '\tt0 = %.1fs\t%.3f\t%.3f\t%.3f\n'...
           '\tt1 = %.1fh\t%.3f\t%.3f\t%.3f\n'...
           '\n'], [t(:,1), thetagrad1]');

%% c) flächenbezogener Wärmestrom
qdot = - lambda .* thetagrad1;
fprintf(1,['c)\tFlächenbezogener Wärmestrom [W/m²]an den Stellen\n', ...
           '\t\t\t\t\tx=0\t\t\t\tx=L\t\t\t\tx=L/2\n',...
           '\tt0 = %.1fs\t\t%.3e\t\t%.3e\t\t%.3e\n'...
           '\tt1 = %.1fh\t\t%.3e\t\t%.3e\t\t%.3e\n'...
           '\n'], [t(:,1), qdot]');
       
%% d) zeitliche Temperaturänderung
thetagrad2 = double(vpa(theta_gradt(x,t)));
fprintf(1,['d)\tFlächenbezogener Wärmestrom [W/m²]an den Stellen\n', ...
           '\t\t\t\t\tx=0\t\t\t\tx=L\t\t\t\tx=L/2\n',...
           '\tt0 = %.1fs\t\t%.3e\t\t%.3e\t\t%.3e\n'...
           '\tt1 = %.1fh\t\t%.3e\t\t%.3e\t\t%.3e\n'...
           '\n'], [t(:,1), thetagrad2]');
       
%% e) Skizze Temperaturfeld
figH = findobj('type','figure');
if logical(numel(figH))
    figH = figH(1);
    set(0,'CurrentFigure',figH);clf;
else
    figH = figure();
end
% Temperaturfeld
ax(1) = subplot(2,1,1);
fsurf(theta,[0 L t0 t1]);
ax(1).Title.String = 'Temperaturfeld $\vartheta(x,t)$';
ax(1).Title.Interpreter = 'latex';
ax(1).XAxis.Label.String = 'Position auf Stab [m]';
ax(1).YAxis.Label.String = 'Zeit [h]';
ax(1).ZAxis.Label.String = 'Temperatur \vartheta(x,t) [°C]';
ax(1).View = [160 15];
% Wärmestromdichte
ax(2) = subplot(2,1,2);
fsurf(-lambda*theta_gradx,[0 L t0 t1]);
ax(2).Title.String = 'W\"armestromdichte $\dot{q}(x,t)$';
ax(1).Title.Interpreter = 'latex';
ax(2).XAxis.Label.String = 'Position auf Stab [m]';
ax(2).YAxis.Label.String = 'Zeit [h]';
ax(2).ZAxis.Label.String = 'Temperatur \vartheta(x,t) [°C]';
ax(2).View = [160 15];