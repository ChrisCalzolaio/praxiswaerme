% initial values
Vdot = 25 / 3.6e3;      % [m^3 * s^-1]
V = 3;                  % [m^3]
cp = 1.006e3;           % [J * kg^-1 * K^-1]
k = 1;                  % [W * m^-2 * K^-1]
A = 4;                  % [m^2]
rho_L = 1.2;            % [kg * m^-3]

% notable temperatures
theta0 = 50;            % [°C]
thetaInf = 25;          % [°C]
thetaG = 28;            % [°C]

% ODE prefactor
betafun = @(Vdot,V,k,A,rho_l,cp) Vdot/V + (k * A) / (rho_L * V * cp);

% differential equation setup
tspan = [0 1e3];
beta = betafun(Vdot,V,k,A,rho_L,cp);
syms theta(t)
thetaEqn = diff(theta,t) == - beta * (theta - thetaInf);
cond = theta(0) == theta0;
thetaSol = symfun(dsolve(thetaEqn,cond),t);

%% d) Grenztemperatur
tlong = 1e6;
fprintf(1,['d) die Grenztemperatur theta_i_inf nach sehr langer Zeit'...
            '( %.4e s ) beträgt %.3f°C.\n'],...
            tlong,...
            thetaSol(tlong));

figH = getFigH(1,'Color','default','WindowSytle','docked');
axH = axes(figH); grid on; grid minor;

range = linspace(0,1e3);
thetaPlt = line(range,thetaSol(range));
thetaGPlt = yline(axH,thetaG,'LineStyle','--');



clearvars axH figH thetaPlt thetaGPlt

function dydt = odefun(t,theta,beta,thetaInf)
dydt = -beta * (theta - thetaInf);
end