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

% ode setup
tspan = [0 1e3];
beta = betafun(Vdot,V,k,A,rho_L,cp);

%% d) Grenztemperatur
[t,theta] = ode45(@(t,theta) odefun(t,theta,beta,thetaInf),tspan,theta0);

figH = getFigH(1,'Color','default','WindowSytle','docked');
axH = axes(figH); grid on; grid minor;

thetaPlt = line(axH,t,theta);
thetaGPlt = yline(axH,thetaG,'LineStyle','--');



clearvars axH figH thetaPlt thetaGPlt

function dydt = odefun(t,theta,beta,thetaInf)
dydt = -beta * (theta - thetaInf);
end