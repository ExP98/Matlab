function [t, y] = runge(f, Tspan, y0)
    N = 1000;
    step = (Tspan(end) - Tspan(1)) / N;
    y = zeros(size(Tspan, 1), N);
    t = zeros(1, N);
    t(1) = Tspan(1);
    y(:, 1) = y0;
    
    for k = 2:N
        t(k) = t(k - 1) + step;
        k1 = f(t(k-1), y(:, k-1));
        k2 = f(t(k-1)+step/2, y(:, k-1)+k1*step/2);
        k3 = f(t(k)+step/2, y(:, k-1)+k2*step/2);
        k4 = f(t(k)+step, y(:, k)+k3*step);
        y(:, k) = y(:, k - 1) + (k1 + 2*k2 + 2*k3 + k4)*step/6;
end