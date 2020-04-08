% global A B C D L delta
A = 20;
B = 1;
C = 5e-3;
D = 2;
L = 4;
delta = 0.4;
x = linspace(0,10,1e3);
y = linspace(0,0.4,1e3)';

calcw = @(x,y) A * (x./L).^D .* (y./delta).^B .* exp(-y./(x.*C));

wfeld = calcw(x,y);
w_vec = calcw([0,1,2,3,4],y);

ax1 = subplot(2,1,1);
ax2 = subplot(2,1,2);

surf(x,y,wfeld,'EdgeColor','none','Parent',ax1)
plot(y,w_vec,'Parent',ax2);
legend('w @ 0m','w @ 1m','w @ 2m','w @ 3m','w @ 4m')

% function w = calcw(x,y)
% global A B C D L delta
% w = A * (x./L).^D .* (y./delta).^B .* exp(-y./(x.*C));
% 
% end