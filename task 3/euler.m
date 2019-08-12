function [t, y] = euler(f, Tspan, y0)
    N = 1000;
    step = (Tspan(end) - Tspan(1)) / N;
    y = zeros(size(Tspan, 1), N);
    t = zeros(1, N);
    t(1) = Tspan(1);
    y(:, 1) = y0;
    
    for k = 2:N
        t(k) = t(k - 1) + step;
        y(:, k) = y(:, k - 1) + (t(k) - t(k - 1)) * f(t, y(:, k - 1));
end