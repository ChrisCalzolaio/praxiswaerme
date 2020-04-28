% initial values
Vdot = 25 / 3.6e3;      % [m^3 * s^-1]
V = 3;                  % [m^3]
cp = 1.006e3;           % [J * kg^-1 * K^-1]
k = 1;                  % [W * m^-2 * K^-1]
A = 4;                  % [m^2]
rho_L = 1.2;            % [kg * m^-3]

theta0 = 50;            % [°C]
thetaInf = 25;          % [°C]

beta = Vdot/V + (k * A) / (rho_L * V * cp);

tspan = [0 1e3];

[t,theta] = ode45(@(t,theta) odefun(t,theta,beta,thetaInf),tspan,theta0);

plot(t,theta)

function dydt = odefun(t,theta,beta,thetaInf)
dydt = -beta * (theta - thetaInf);
end