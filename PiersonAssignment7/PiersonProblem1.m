 % prob1
clear, clc,close all
% Write a MATLAB function to perform the MidPoint’s Method. 
% Your MATLAB function will take input of 
% the differential function (e.g. dydt), tspan (ti and tf), initial value (y0), step size (h), acceptable error for correctors (es).
% The function will output the time, t and the corresponding solution y. Save your function as LastnameMidPoint.m.

% Use the function file and write a MATLAB script to solve the following problem 
% dy/dx = (1+2x)*sqrt(y)
% over the interval x = 0 to 1 using a step size of 0.25 where y(0) = 1. 
% Also the approximation of the error of the correctors should be below 0.1%. 

dydx = @(x, y) (1+2*x)*sqrt(y);
h = 0.25;
tspan = [0 1];
y0 = 1;
[t p] = PiersonMidPoint(dydx, tspan, y0, h, 0.01)
plot(t, p)
