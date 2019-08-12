clc;
close all;
format long

a = -5 * pi;                                    
b = 5 * pi;                                     
eps = 10^(-3);                                
n = 3;

% |R_n| <= (M_(n+1) / (n+1))* h^(n+1)
h = b - a;
while power(h/n, n+1) / (n+1) > eps
    n = n + 1;
end
%n = 65;

X = linspace(a, b, 1000)';
func = @sin;

nodes = linspace(a, b, n)';
C_Poly = linear_system(func, nodes);

Cheb_nodes = nodes;
for i = 1 : n
    Cheb_nodes(i) = 0.5*(a+b) + 0.5*(b-a)*cos(pi*(2*i-1)/(2*n));
end 
C_Cheb = linear_system(func, Cheb_nodes);

yyPoly = polyval(C_Poly, X);
yyPolyCheb = polyval(C_Cheb, X);
yyLagr = lagrange(nodes, sin(nodes), X);

fprintf("Degree of polynomial: %d\n", n);
fprintf("Linear system error: %f\n", max(abs(sin(X) - yyPoly)));
fprintf("Lagrange polynomial error: %f\n", max(abs(sin(X) - yyLagr)));
fprintf("Lin sys with Chebyshev nodes error: %f\n", max(abs(sin(X) - yyPolyCheb)));

hold on;
grid on;

subplot(3,1,1)
plot(X,abs(sin(X) - yyPoly),'r')
title('error = {\itsin}({\itx}) - {\itPolynom}({\itx})')

subplot(3,1,2)
plot(X,abs(sin(X) - yyLagr),'g')
title('error = {\itsin}({\itx}) - {\itLagrange}({\itx})')

subplot(3,1,3)
plot(X,abs(sin(X) - yyPolyCheb),'b')
title('error = {\itsin}({\itx}) - {\itCheb}({\itx})')

figure('Units', 'normalized', 'OuterPosition', [0 0 1 1])
subplot(2,1,1)
plot(X, yyPoly, 'k--', 'linewidth', 1.5)
hold on
plot(X, yyLagr, 'b--');
hold on
plot(X, yyPolyCheb, 'g');
hold on
plot(X, sin(X), 'r');
hold on
plot(nodes,sin(nodes),'bo')
hold on
plot(Cheb_nodes,sin(Cheb_nodes),'k+')
legend('{\itPolynomial}({\itx})','{\itLagr}({\itx})','{\itCheb}({\itx})', 'sin(x)', 'nodes', 'Cheb_nodes')
title('Interpolation using Lin system, Lagrange polynomial and Chebyshev nodes')