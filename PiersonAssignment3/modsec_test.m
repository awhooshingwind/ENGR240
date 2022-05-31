clear
clc
close all

% modsec test
% Trying to solve equation for second Lagrange point to test
% modified secant root-finding function
% Parameters and Equation taken from https://en.wikipedia.org/wiki/Lagrange_point

f = @(x) x.^3 - 6*x.^2 + 11*x - 6.1;
x_plot = 0.5:0.001:3.5;
plot(x_plot, f(x_plot))
grid on;
pturb = 0.01;
piersonmodsec(f, pturb, 1)
piersonmodsec(f, pturb, 1.6)
piersonmodsec(f, pturb, 3)

% L2 equation
% M1/(R + r)^2 + M2/r^2 = (M1*R/(M1+M2) + r) * (M1 + M2)/R^3
% define variables L2
M1 = 1.9891 * 10^30; % kg mass of Sun
M2 = 5.972 * 10^24; % kg mass of Earth
R = 1.496* 10^8; % km distance btw Earth/Sun

both = M1+M2;
both_R3 = both/R^3;
M1_R = M1 * R;

L2 = @(r) (M1_R/both + r)*(both/R^3)-M1/(R+r)^2 - M2/r^2;
piersonmodsec(L2, 0.00005, 180000,0.1, 1000)