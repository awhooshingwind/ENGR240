% prob2 part b
% calculate R and zhat utilizing Gauss-Quature with 3 and 4 data points
clear, clc, close all

% During storm, high wind blows along one side of rect. skyscraper
z = [0, 50, 100, 125, 300, 375, 450, 600]; % m
F = [0, 30, 39, 41, 51, 52, 62, 102]; % kN/M **

% Set up 3pt Gauss
% change of variable to work w/ Gauss-Legendre formula
a = 0;
% b = 600;
for j=1:length(z)
    b = z(j);
    x = @(xd) ((b+a)+(b-a)*xd)/2;
    dx = (b-a)/2;
    % weighting factors
    c0 = 5/9;
    c1 = 8/9;
    c2 = 5/9;
    % function args
    x0 = -sqrt(3/5);
    x1 = 0;
    x2 = sqrt(3/5);
    % transformed function values
    f1 = x(x0);
    f2 = x(x1);
    f3 = x(x2);
    % use spline to evaluate the function at necessary points
    yvals = spline(z, F, [f1, f2, f3]);
    g3 = dx*(c0*yvals(1)+c1*yvals(2)+c2*yvals(3));
    R3(j) = g3;
end
g3
zhat3 = (sum(z.*R3))./sum(R3)


% Set up 4pt Gauss
for m=1:length(z)
    b = z(m);
    x = @(xd) ((b+a)+(b-a)*xd)/2;
    dx = (b-a)/2;
% weighting factors
c0 = (18-sqrt(30))/36;
c1 = (18+sqrt(30))/36;
c2 = c1;
c3 = c0;
% function args
x0 = -sqrt(525+70*sqrt(30))/35;
x1 = -sqrt(525-70*sqrt(30))/35;
x2 = -x1;
x3 = -x0;
% transformed function values
f1 = x(x0);
f2 = x(x1);
f3 = x(x2);
f4 = x(x3);
% use spline to evaluate the function at necessary points
yvals4 = spline(z, F, [f1, f2, f3, f4]);
% 4pt estimate
g4 = dx*(c0*yvals4(1)+c1*yvals4(2)+c2*yvals4(3)+c3*yvals4(4));
R4(m) = g4;
end
g4
zhat4 = (sum(z.*R4))./sum(R4)

% Both the trapezoidal method and the four point Gauss Quadrature yielded
% similar estimates for R (resultant force on skyscraper) but slightly
% different values for the line of action (zhat)
% That both the trapezoidal method and 4pt Gauss yielded similar answers
% (3.19*10^4 kN) suggests that the actual answer is around 32000, the 3pt
% gives a (presumably) slight over-estimate (3.308 * 10^4)
% Without having a deeper understanding of the physical system, it's hard
% to evaluate further which result makes more sense, but given the relative
% simpliicty in calculation, the trapezoidal method seems to be the most
% efficient approach