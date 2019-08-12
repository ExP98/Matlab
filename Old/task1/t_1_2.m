clc;
close all;

a = -1;                                       
b = 1;                                       
eps = 10^(-3);                  
n = 1;

% |R_n| <= (M_(n+1) / (n+1))* h^(n+1)
h = b - a;
while power(h / n, n+1) / (n+1) > eps
    n = n + 1;
end
n = 25

X = linspace(a, b, 10000)';
func = @f2;

nodes = linspace(a, b, n)';
C_Poly = linear_system(func, nodes);

Cheb_nodes = nodes;
for i = 1 : n
    Cheb_nodes(i) = 0.5*(a+b) + 0.5*(b-a)*cos(pi*(2*i-1)/(2*n));
end 
C_Cheb = linear_system(func, Cheb_nodes);

yyPoly = polyval(C_Poly, X);
yyPolyCheb = polyval(C_Cheb, X);
yyLagr = lagrange(nodes, func(nodes), X);

fprintf("Degree of polynomial: %d\n", n);
fprintf("Linear system error: %f\n", max(abs(func(X) - yyPoly)));
fprintf("Lagrange polynomial error: %f\n", max(abs(func(X) - yyLagr)));
fprintf("Lin sys with Chebyshev nodes error: %f\n", max(abs(func(X) - yyPolyCheb)));

hold on;
grid on;

subplot(3,1,1)
plot(X,abs(func(X) - yyPoly),'g')
title('error = {\itfunc}({\itx}) - {\itPolynom}({\itx})')

subplot(3,1,2)
plot(X,abs(func(X) - yyLagr),'r')
title('error = {\itfunc}({\itx}) - {\itLagrange}({\itx})')

subplot(3,1,3)
plot(X,abs(func(X) - yyPolyCheb),'b')
title('error = {\itfunc}({\itx}) - {\itCheb}({\itx})')

figure('Units', 'normalized', 'OuterPosition', [0 0 1 1])
subplot(2,1,1)
plot(X, yyPoly, 'k--', 'linewidth', 1.5)
hold on
plot(X, yyLagr, 'b--');
hold on
plot(X, yyPolyCheb, 'g', 'linewidth', 1.5);
hold on
plot(X, func(X), 'r');
hold on
plot(nodes,func(nodes),'bo');
hold on
plot(Cheb_nodes,func(Cheb_nodes),'k+');
text(1,1,strcat('n = ',num2str(n)),'Color','red','FontSize',14);
legend('{\itPolynomial}({\itx})','{\itLagr}({\itx})','{\itCheb}({\itx})', '1/(1+12*x^2)', 'nodes', 'Cheb_nodes')
title('Interpolation using Lin system, Lagrange polynomial and Chebyshev nodes')