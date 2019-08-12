function C=linear_system(func, nodes)
    n=length(nodes);
    B = 0:n-1;
    A = nodes .^ B;
    B = func(nodes);
    C = linsolve(A, B);
    C = C(end:-1:1);
end