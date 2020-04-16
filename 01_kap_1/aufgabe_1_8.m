P = [1; 1];
alpha = deg2rad(60);
unitvec = [cos(alpha);sin(alpha)];

syms x y;
theta = symfun(64/(x.^2 + y.^2 + 2),[x,y]);
fsurf(theta,[-5 5 -5 5]);
quiver(P',unitvec')
return;

x = linspace(-10,10,1e3);
y = x';
[x,y] = meshgrid(x,y);

theta = 64./(x.^2 + y.^2 + 2);
[gradt1,gradt2] = gradient(theta);

ax1 = subplot(2,2,[1,2]);
ax2 = subplot(2,2,3);
ax3 = subplot(2,2,4);

surf(x,y,theta,'EdgeColor','none','Parent',ax1)
surf(x,y,gradt1,'EdgeColor','none','Parent',ax2)
surf(x,y,gradt1,'EdgeColor','none','Parent',ax3)