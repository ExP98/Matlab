load('data11.mat');
hold on;
grid on;

Mcos = exp(-5 .* tt) .* cos(5 .* tt);
Msin = exp(-5 .* tt) .* sin(5 .* tt);
M = [Mcos Msin ones(length(tt), 1) zeros(length(tt), 1); -Msin Mcos zeros(length(tt), 1) ones(length(tt), 1)];
c =  linsolve(M,[xx; yy]);

T = linspace(min(tt), max(tt), 10000);
xx2 = c(1) * exp(-5.*T) .* cos(5.*T) + c(2) * exp(-5.*T) .* sin(5.*T) + c(3);
yy2 = -c(1) * exp(-5.*T) .* sin(5.*T) + c(2) * exp(-5.*T) .* cos(5.*T) + c(4);

plot(xx, yy, 'or');
plot(xx2, yy2, 'b');
legend('nodes', 'curve');