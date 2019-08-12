
% f = inline('sqrt(1-y^2)');
hold on
grid on

% f=@(x,y)sqrt(1-y^2);
% f=@(x,y) y^2 + 1;
f=@(x,y) y^(1/3);
% b = pi/2 - 0.1;
b = 20;
x0 = 0.000001;
y0 = x0;

[x,y] = Runge(f,x0,b,y0,0.1);
plot(x, y, 'r');
[x,y] = Runge(f,x0,b,y0,0.01);
plot(x, y, 'g');
[x,y] = Runge(f,x0,b,y0,0.001);
plot(x, y, 'b');

[x,y] = Euler(f,x0,b,y0,100);
plot(x, y, 'c');
[x,y] = Euler(f,x0,b,y0,1000);
plot(x, y, 'm');
[x,y] = Euler(f,x0,b,y0,10000);
plot(x, y, 'y');

options = odeset('RelTol', 1e-6, 'AbsTol', 1e-14);
[t1, y1] = ode45(f, [x0, b], y0);
% [t2, y2] = ode45(@func2, [0, b], 0, options);
plot(t1, y1, 'k');