function [xvalues, yvalues] = Runge(f, x0, xn, y0, h)
n = floor(abs(xn - x0) / h);
x(1) = x0;
y(1) = y0;
for i = 1:n
    k1 = f(x(i),y(i));
    k2 = f(x(i)+0.5*h,y(i)+0.5*h*k1);
    k3 = f((x(i)+0.5*h),(y(i)+0.5*h*k2));
    k4 = f((x(i)+h),(y(i)+k3*h));
    y(i+1) = y(i) + (1/6)*(k1+2*k2+2*k3+k4)*h; 
    x(i+1) = x(i) + h;
end
xvalues = x';
yvalues = y';