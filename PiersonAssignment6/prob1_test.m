% prob1 test
clear,clc,close all

% test comp simp on following function
% integral from 0 to pi/2 (8+4cos(x))dx
% assume n = 4
f = @(x) (8+4*cos(x));
simp_est = PiersonSimp(f, 0, pi/2, 4)

% built-in to compare
int_est = integral(f, 0, pi/2)