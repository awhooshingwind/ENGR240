% prob3 test
clear,clc,close all

% An engineer has measured the following deflections along simply
% supported beam:

x = [0 0.375 0.75 1.125 1.5 1.875 2.25 2.625 3]; % m
y = [0 -0.2571 -0.9484 -1.9689 -3.2262 -4.6414 -6.1503 -7.7051 -9.275]; % cm

% Compute the slope (rad) and the moment (in N-m)
% use the following equations and numerical differentiation:
% theta(x) = dy/dx, M(x) = d(theta)/dx*E*I
% with the following parameters:
E = 200; % GPa
I = 0.0003; % m^4

% Method 1: O(h) forward/backward and O(h^2) centered, step size = 0.375
delx = 0.375;
slope1 = zeros([1 length(y)]);
for i=1:length(y)
    if i==1
        dir = 'f';
    elseif i==length(y)
        dir = 'b';
    else dir = 'c';
    end
    slope1(i) = hidiff(y, y(i), delx, 1, dir);
    m1(i) = hidiff(y, y(i), delx, 2, dir)*(E*I);
end


% Method 2: O(h^2) forward/backward and O(h^4) centered, step size = 0.375
slope2 = zeros([1 length(y)]);
for j=1:length(y)
    if j<=2
        dir = 'f';
    elseif j>=length(y)-2
        dir = 'b';
    else dir = 'c';
    end
    slope2(j) = hidiff(y, y(j), delx, 1, dir, 'h');
    m2(j) = hidiff(y, y(j), delx, 2, dir, 'h')*(E*I);
end

% Method 3: O(h) forward/backward and O(h^2) centered, step size = 0.01
% use spline interpolation before differentiating
xvals = 0:0.01:3;
yvals = spline(x, y, xvals);
slope3 = zeros(1, length(yvals));
for k=1:length(yvals)
     if k==1
        dir = 'f';
    elseif k==length(yvals)
        dir = 'b';
    else dir = 'c';
    end
    slope3(k) = hidiff(yvals, yvals(k), 0.01, 1, dir);
    m3(k) = hidiff(yvals, yvals(k), 0.01, 2, dir)*(E*I);
end



% plot to compare
f = figure;
f.Position = [200, 100, 1200, 800];
t = tiledlayout(2,3);

nexttile([1 3])
plot(x, y, 'bo', 'MarkerSize', 10);
title(t, 'Measured Deflections Along Simply Supported Beam')
xlabel('x, m')
ylabel('y, cm')
grid on
hold on

nexttile
plot(x, slope1,'k',x,m1,'m','LineWidth', 2)
title('Method 1: Normal, step size 0.375')
xlabel('x, m')
ylabel('y (slope and moment)')
lg = legend('Slope (radians)', 'Moment (N-m)');
lg.Layout.Tile = 'south';
grid on

nexttile
plot(x, slope2, 'k', x,m2,'m', 'LineWidth', 2)
xlabel('x, m')
ylabel('y (slope and moment)')
title('Method 2: High Accuracy, step size 0.375')
grid on

nexttile
plot(xvals, slope3, 'k', xvals,m3,'m','LineWidth', 2)
xlabel('x, m')
ylabel('y (slope and moment)')
title('Method 3: Normal, step size 0.01')
grid on

