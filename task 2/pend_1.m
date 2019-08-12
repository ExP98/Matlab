clear;
clc;
close all; 

f = @(x,y) [y(2), -sin(y(1))]';
t_span = [0, 50];
options = odeset('RelTol',1e-7);
[T1,X1] = ode45(f, t_span, [0, 1], options);
[T2,X2] = ode45(f, t_span, [0, 2], options);
[T3,X3] = ode45(f, t_span, [0, 2.5], options);
[T4,X4] = ode45(f, t_span, [pi, 0], options);

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