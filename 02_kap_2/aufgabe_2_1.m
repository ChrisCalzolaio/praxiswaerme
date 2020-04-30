% plot the manually derived function for temperature
B = 2;                                  % [m]
H = 2e-1;                               % [m]
alphaK = 20;                            % [W*m^2*K^-1]
lambda = 2;                             % [W*m*K^-1]
thetaInf = -10;                         % [°C]
thetaF = 0;                             % [°C]

% precalc
beta = sqrt((2 * alphaK) / (lambda * H));

% numeric solution
syms theta(x)
thetaEqn = symfun(diff(theta,x,2) - beta*theta == -beta*thetaInf,x);
cond(1) = theta(0) == 0;
dTheatCond = diff(theta,x);
cond(2) = dTheatCond(B) == 0;
thetaSol(x) = dsolve(thetaEqn,cond);

% output
x = linspace(0,2,1e3);
thetaNum = double(vpa(thetaSol(x)));
figH = getFigH(1,'WindowStyle','docked');
fPlot = line(x,double(vpa(thetaSol(x))));
grid on; grid minor;