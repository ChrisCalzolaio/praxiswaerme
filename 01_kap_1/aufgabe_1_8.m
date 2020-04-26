range = [-1 1 -1 1] * 3;

P = [1; 2];
alpha = deg2rad(60);
unitvec = [cos(alpha);sin(alpha)];

%% calculation
syms x y;
theta = symfun(64/(x.^2 + y.^2 + 2),[x,y]);

% richtungsableitungen
theta_gradx = symfun(diff(theta(x,y),x),[x,y]);
theta_grady = symfun(diff(theta(x,y),y),[x,y]);

% numeric
x = P(1);
y = P(2);
grad_theta = double(vpa([theta_gradx(x,y);theta_grady(x,y)]));

fprintf('theta ändert sich an P(%i|%i) mit %.4f °C/cm.\n',P,sum(grad_theta .* unitvec))

%% plotting
% 3d field
axH(1) = subplot(2,2,1);
fsurf(theta,range);

% 2d field with vector
axH(2) = subplot(2,2,2);
fcH = fcontour(theta,range,'Fill','on','LevelStep',.1);
axH(2).NextPlot = 'add';
quivH = quiver(P(1),P(2),unitvec(1),unitvec(2),'Color','r');
axH(2).NextPlot = 'replace';

% theta grad x
axH(3) = subplot(2,2,3);
fsurf(theta_gradx,range);

% theta grad y
axH(4) = subplot(2,2,4);
fsurf(theta_grady,range);

% link plots
hLink = linkprop([axH([1,3,4])],{'CameraPosition'});
rotate3d on;