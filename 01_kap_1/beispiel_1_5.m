%% Beispiel 1.5
C = 50;
L = 2;
B = 1;
theta_0 = 0;
syms x y
theta = symfun(C*(1-(x/L)^2)*(1-(y/B)^2) + theta_0,[x,y]);
fsurf(theta,[-2 2 -1 1])
fcontour(theta,[-2 2 -1 1])