function g = GaussMult(f, a, b, pts)
% Gauss Quadrature Helper (2, 3, or 4 point only)
%   input:
%       f = function to integrate
%       a, b = limits of integration
%       pts = points to use in formulation (must be 2 or 3)
%   output:
%       g = estimated integral value

% change of variable to work w/ Gauss-Legendre formula
x = @(xd) ((b+a)+(b-a)*xd)/2;
dx = (b-a)/2;

% Gauss 2 pt
if pts == 2
    % function args
    x0 = -1/sqrt(3);
    x1 = -x0;
    % transformed function values
    f1 = f(x(x0));
    f2 = f(x(x1));
    g = dx*(f1+f2);
end

% Gauss 3pt
if pts == 3
    % weighting factors
    c0 = 5/9;
    c1 = 8/9;
    c2 = 5/9;
    % function args
    x0 = -sqrt(3/5);
    x1 = 0;
    x2 = sqrt(3/5);
    % transformed function values
    f1 = f(x(x0));
    f2 = f(x(x1));
    f3 = f(x(x2));
    g = dx*(c0*f1+c1*f2+c2*f3);
end

% Gauss 4pt
if pts == 4
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
    f1 = f(x(x0));
    f2 = f(x(x1));
    f3 = f(x(x2));
    f4 = f(x(x3));
    % estimate
    g = dx*(c0*f1+c1*f2+c2*f3+c3*f4);
end
end

% could use some refactoring to shorten code/be cleaner
% put weights/func args into own arrays, g iterates based on pts input?
% also missing any sort of error traps