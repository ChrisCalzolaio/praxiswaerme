Di = 0.140;         % [m]
Da = 0.260;         % [m]
D = 6e-2;           % [m]
s = 6e-3;           % [m]
rho = 7.850e3;      % [kg / m^3]
cp = 464;           % [J / (kg * K)]
tB = 2.5;           % [s]
alpha = 62;         % [W / (m^2 * K)]
qdot0 = 1.760e7;    % [W / m^2]

% precalc
A_B = pi / 2 * D^2;
A_alpha = pi/2 * (Da^2 - Di^2) + pi * Da * s;
m_S = pi / 4 * (Da^2 - Di^2) * s * rho;
gamma = (alpha * A_alpha * tB) / (m_S * cp);
thetaBez = (qdot0 * A_B * tB) / (m_S * cp);

syms t tau Theta
% Theta = ((gamma^2 - 2) / gamma^3)*(1-exp(-gamma*tau) + (s*tau)/gamma^2 - (tau^2)/gamma;
tau(t) = t/tB;
% dTdT = diff(Theta,
