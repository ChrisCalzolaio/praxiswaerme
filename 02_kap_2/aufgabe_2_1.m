% plot the manually derived function for temperature
B = 2;                                  % [m]
H = 2e-1;                               % [m]
alphaK = 20;                            % [W*m^2*K^-1]
lambda = 2;                             % [W*m*K^-1]
thetaInf = -10;                         % [°C]
thetaF = 0;                             % [°C]

beta = sqrt((2 * alphaK) / (lambda * H));


c2 = thetaF - thetaInf;
c1 = -c2 * tanh(beta*B);
syms x
theta = symfun(c1 * sinh(beta * x) + c2 * cosh(beta * x) + thetaInf,x);

% plotting
figH = getFigH(1,'WindowStyle','docked');
fPlt = fplot(theta,[0 B]);
grid on; grid minor