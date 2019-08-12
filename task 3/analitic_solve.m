clear;
clc;
close all; 

syms y(t)
Dy = diff(y,t);
eqn = diff(y,t,2) == 16.81*y;
eqn2 = diff(y,t,2) == -8.2 * Dy -16.81*y;
cond = [y(0)==1.0, Dy(0)==-4.1];
d1 = dsolve(eqn, cond)
d11 = dsolve(eqn)
d2 = dsolve(eqn2, cond)
d22 = dsolve(eqn2)

figure(1)
ezplot('exp(-(41*t)/10)', [-1, 10]);
figure(2)
ezplot('exp(-(41*t)/10) + exp((41*t)/10)', [-3, 3]);
figure(3)
ezplot('exp(-(41*t)/10) + t*exp(-(41*t)/10)', [-3, 3]);
% y''= -8.2 * y' -16.81y; y(0)=1; y'(0) = -4.1