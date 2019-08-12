x0 = [1; 0];
f = @(x,y) [y(2), -100000.001*y(2) - 100*y(1)]';
timespan = [0, 10];

clock_start = cputime; 
[T1,X1] = ode45(f, timespan, x0);
time_ode45 = cputime - clock_start

clock_start = cputime; 
[T2,X2] = ode23s(f, timespan, x0);
time_ode23s = cputime - clock_start

figure(1)
grid on;
hold on;
plot(T1, X1);

% figure(2)
% grid on;
% hold on;
% plot(T2, X2(:,1));