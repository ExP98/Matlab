clc;
clear;        
close all;

f = @(t,y)([y(2); -8.2*y(2)-16.81*y(1)]);
T_span = [0; 10];
x0 = [1.0; -4.1];

figure(1)
grid on
hold on
T = T_span(1):0.1:T_span(2);
y = @(t) exp(-4.1*t);
plot(T, y(T))
title('correct solution')

figure(2)
grid on
hold on
[T,Y] = ode45(f,T_span,x0);
plot(T, Y(:, 1))
title('ode45')

figure(3)
grid on
hold on
[T,Y] = euler(f,T_span,x0);
plot(T, Y(1, :))
title('euler')

figure(4)
grid on
hold on
[T,Y] = runge(f,T_span,x0);
plot(T, Y(1, :))
title('runge');