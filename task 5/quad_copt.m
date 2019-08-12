% initialization
g = 9.81;
m = 5;
h = [110; 10];  % from h(1) to h(2) -- height
T_span = [0 150];

% minimization
K = fminsearch(@(K) J(h, K, T_span, m, g), [0 0])    % K(1) = K_p, K(2) = K_d
% K = [1, 1]
[t,z] = ode45(@(t,z) [z(2);(-K(1).* (z(1) - h(2)) - K(2).* z(2))./ m], T_span, [h(1); 0]);

hold on
grid on
plot(t,z)
title('Height and velocity')
legend('Z', 'Z ''')

function Integral = J(h, K, T_span, m, g)
    [t,z] = ode45(@(t,z) [z(2);(-K(1).* (z(1) - h(2)) - K(2).* z(2))./ m], T_span, [h(1); 0]);
    fval = (z(:,1) - h(2)).^2 + z(:, 2).^2 + (K(1).* (z(:, 1) - h(2)) + K(2).*z(:, 2) + m.* g).^2;
    Integral = trapz(t, fval)
end