[t, x] = ode45(@(t, x) [x(2); (x(1)/t - x(2))/(t)], [1 2], [2 0]);
t = t';
dx = x(:, 2)';
x = x(:, 1)';
disp('Right answer: ');
disp(trapz(t, t.*dx.*dx + x.*x./t));
nelder_mead(3, 0.0000001);
nelder_mead(4, 0.0000001);
nelder_mead(5, 0.0000001);
nelder_mead(6, 0.0000001);

function [Nelder_Mead_Method, iterations] = nelder_mead(n, eps)
disp('dim: ');
disp(n);
alpha = 1;
gamma = 0.75 - 1./(2.*n);
beta = 1 + 2./n;
delta = 1 - 1./n;
t = linspace(1, 2, n+1);

k = 0;
simplex = [zeros(1, n-1); eye(n-1)];
f_calc(t, simplex, n);

x_low = find(f_calc(t, simplex, n) == min(f_calc(t, simplex, n)), 1 );
f_low = simplex(x_low, :);
x_high = find(f_calc(t, simplex, n) == max(f_calc(t, simplex, n)), 1 );
f_high = simplex(x_high, :);
f_high_second = [simplex(1:x_high-1, :); simplex(x_high+1:end, :)];
x_high_second = find(f_calc(t, f_high_second, n) == max(f_calc(t, f_high_second, n)), 1 );
f_high_second = f_high_second(x_high_second, :);

center_of_mass = [simplex(1:x_high-1, :); simplex(x_high+1:end, :)];
center_of_mass = (1/(n-1))*sum(center_of_mass, 1);

standard_deviation = ((1/n)*sum((f_calc(t, simplex, n) - f_calc(t, center_of_mass, n)).^2)).^(1/2);
while standard_deviation >= eps
   k = k+1;
   x_refl = center_of_mass + alpha.*(center_of_mass - f_high);
   if f_calc(t, x_refl, n) <= f_calc(t, f_low, n)
       x_expand = center_of_mass + beta.*(x_refl - center_of_mass);
       if f_calc(t, x_expand, n) < f_calc(t, x_refl, n)
           simplex(x_high, :) = x_expand;
       else 
           simplex(x_high, :) = x_refl;
       end
   elseif f_calc(t, x_refl, n) <= f_calc(t, f_high_second, n)
       simplex(x_high, :) = x_refl;
   elseif f_calc(t, x_refl, n) <= f_calc(t, f_high, n)
       x_shrink = center_of_mass + gamma.*(f_high - center_of_mass);
       simplex(x_high, :) = x_shrink;
   else 
       simplex = f_low + delta*(simplex - f_low);
   end
  
   x_low = find(f_calc(t, simplex, n) == min(f_calc(t, simplex, n)), 1 );
   f_low = simplex(x_low, :);
   x_high = find(f_calc(t, simplex, n) == max(f_calc(t, simplex, n)), 1 );
   f_high = simplex(x_high, :);
   f_high_second = [simplex(1:x_high-1, :); simplex(x_high+1:end, :)];
   x_high_second = find(f_calc(t, f_high_second, n) == max(f_calc(t, f_high_second, n)), 1 );
   f_high_second = f_high_second(x_high_second, :);
   
   center_of_mass = [simplex(1:x_high-1, :); simplex(x_high+1:end, :)];
   center_of_mass = (1/(n-1))*sum(center_of_mass, 1);
   standard_deviation = ((1/n)*sum((f_calc(t, simplex, n) - f_calc(t, center_of_mass, n)).^2)).^(1/2);
end   
A = [ones(n+1, 1) cumprod(repmat(t', 1, n)')'];
syst = fliplr((A\[2 f_low 2.5]')');
Nelder_Mead_Method = f_calc(t, f_low, n);
disp('My answer: ');
disp(Nelder_Mead_Method);
t_show = linspace(1,2,500);
plot(t_show, polyval(syst, t_show));
hold on
grid on
plot(t_show, (t_show + 1./t_show))

disp('Iterations: ');
iterations = k;
disp(iterations);
end

function f_compute = f_calc(t, simplex, n)
    if nargin < 3
        n = 4;
    end
sz = size(simplex);
f_compute = ones(1, sz(1));
for i = 1:sz(1)
    f_compute(i) = J(t, [2 simplex(i, :) 2.5], n);
end
end

function integral = J(t, x, n)
A = [ones((n+1), 1) cumprod(repmat(t', 1, n)')'];
system = fliplr((A\x')');
t_compute = linspace(1,2,100);
dx = polyval(polyder(system), t_compute);
x = polyval(system, t_compute);
integral_parts = t_compute.*dx.*dx + x.*x./t_compute;
integral = 0.005*(integral_parts(1) + sum(2*integral_parts(2:end-1)) + integral_parts(end));
end