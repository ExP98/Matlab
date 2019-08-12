clear;
clc;
close all; 

f = @(x, y) -10000*y;
x0 = 0;
x1 = 1;
y0 = 1;
[x_ex, y_ex] = Euler_expl(f, [x0; x1], y0, 1e-3);
[x_im, y_im] = Euler_impl([x0; x1], y0, 1e-3);

figure(1)
hold on
grid on
plot(x_ex, y_ex, 'r')
plot(x_im, y_im, 'b')

[x_ex_2, y_ex_2] = Euler_expl(f, [x0; x1], y0, 1e-5);
[x_im_2, y_im_2] = Euler_impl([x0; x1], y0, 1e-5);

figure(2)
hold on
grid on
plot(x_ex_2, y_ex_2, 'r')
plot(x_im_2, y_im_2, 'b')

function [x, y] = Euler_expl(fun, Tspan, x0, h)
    x = Tspan(1):h:Tspan(2);
    y = x0;
    for i = 1:length(x)-1
        y(i+1) = y(i) + h*fun(0, y(i));
    end
end

function [x, y] = Euler_impl(Tspan, x0, h)
    x = Tspan(1):h:Tspan(2);
    y = x0;
    for i = 1:length(x)-1
        y(i+1) = y(i)/(1+10000*h);
    end
end