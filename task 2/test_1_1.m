clear;
clc;
close all; 

f = @(x,y) [y(2), -sin(y(1))]';
t_span = [0, 150];
options1 = odeset('RelTol',1e-3);
options2 = odeset('RelTol',1e-4);
options3 = odeset('RelTol',1e-5);
options4 = odeset('RelTol',1e-8);
[T1,X1] = ode45(f, t_span, [0, 2], options1);
[T2,X2] = ode45(f, t_span, [0, 2], options2);
[T3,X3] = ode45(f, t_span, [0, 2], options3);
[T4,X4] = ode45(f, t_span, [0, 2], options4);

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