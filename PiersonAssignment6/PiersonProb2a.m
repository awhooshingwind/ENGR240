% prob2 part a
clear, clc, close all

% During storm, high wind blows along one side of rect. skyscraper
z = [0, 50, 100, 125, 300, 375, 450, 600]; % m
F = [0, 30, 39, 41, 51, 52, 62, 102]; % kN/M **

% ** hard to see exactly where the data points lie, image got a little
% distorted zooming in ***

% calculate resultant force, R and the position (line of action) of R, zhat
% R = int from 0 to z F(z)dz,
% zhat = (int{0:z} (z*R))/(int{0:z} R)

% part a
% write script to calculate R and zhat using trapezoidal method

% x = vector of independent variables
x = z;
% y = vector of dependent variables
y = F;
% I = integral estimate
n = length(x);
s = 0;
for k = 1:n-1
    s = s + (x(k+1)-x(k))*(y(k)+y(k+1))/2;
    R(k+1) = s;
end
R;
I = s
zhat = (sum(z.*R))./sum(R)