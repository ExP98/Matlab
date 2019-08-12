clear;
clc;
close all; 

v = 0.7;
f = @(x,y) [y(2), -v*y(2) - y(1)]';
t_span = [0, 50];

[T1,X1] = ode45(f, t_span, [0, 1]);
[T2,X2] = ode45(f, t_span, [0, 2]);
[T3,X3] = ode45(f, t_span, [0, 10]);
[T4,X4] = ode45(f, t_span, [0, 0]);
[T5,X5] = ode45(f, t_span, [pi/2, 0]);

figure(1)
hold on
grid on
plot(T1, X1)
legend('$\theta$', '$\dot{\theta}$', 'Interpreter','latex')

figure(2)
hold on
grid on
plot(T2, X2)
legend('$\theta$', '$\dot{\theta}$', 'Interpreter','latex')

figure(3)
hold on
grid on
plot(T3, X3)
legend('$\theta$', '$\dot{\theta}$', 'Interpreter','latex')

figure(4)
hold on
grid on
plot(T4, X4)
legend('$\theta$', '$\dot{\theta}$', 'Interpreter','latex')

figure(5)
hold on
grid on
plot(T5, X5)
legend('$\theta$', '$\dot{\theta}$', 'Interpreter','latex')