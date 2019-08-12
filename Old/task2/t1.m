clc;
close all;
format long;
load('data.mat');
x = V;
% y = b1f;
y = b2f;
len = length(y);

f1 = figure;
hold on
grid on
plot(x, y, 'or');
title('Polynomials that fits the data Y best in a least-squares sense');

relEr = zeros(1, len);
err = zeros(1, len-1);
xx = linspace(x(1), x(end), 300);
for ii = 1:(len-1)
    [p, S, mu] = polyfit(x, y, ii);
    yy = polyval(p, xx, [], mu);
    polin = polyval(p, x, [], mu);
    relEr(ii) = max(abs(y-polin)./min(abs(y), abs(polin)));
    hold on
    plot(xx, yy);
    err(ii) = S.normr;
end 

f2 = figure;
hold on;
grid on;
plot(1:1:(len-1),err);
title('Error');

f3 = figure;
hold on;
grid on;

plot(2:1:len,relEr(2:len));
title('Relative Error(2:15)');

f4 = figure;
hold on;
grid on;
relErr = zeros(1, len-1);
for j = 1:(len-1)
    [p, S] = polyfit(x, y, j);
    pow_p = zeros(1, length(p));
    pow_p(1) = p(1);
    yy = polyval(pow_p, xx);
    polin = polyval(pow_p, x);
    relErr(j) = max(abs(y-polin)./min(abs(y), abs(polin)));
    hold on
    subplot(3,1,[1,2]);
    plot(xx, yy);
end
title('Power');
subplot(3,1,3);
hold on
grid on
plot(1:1:(len-1),log(relErr));
title('Log of Power Relative Error');

fprintf(['Relative Error(1) is ', num2str(relEr(1))]);