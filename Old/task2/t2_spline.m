format long;
load('data11.mat');
hold on;    
grid on;
n = length(tt);
plot(xx, yy, 'Or');

t = linspace(min(tt), max(tt), 10000);
y = zeros(2, n);
y(1, :) = xx;
y(2, :) = yy;

pp = spline(tt,y);
yy = ppval(pp, t);
plot(yy(1, :),yy(2, :),'b')
legend('nodes', 'curve');