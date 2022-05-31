% Problem 3
clear, clc, close all

% Deflection of simply supported beam
% use finite difference method to solve
% basic diff equation of elastic curve of simple supported (uniformly
% loaded) beam given as
% EI*d2y/dx2 = w0/6(0.6*L*x-x^3/L)
% where:
%   E = modulus elasticity
%   I = moment of inertia
%   y0 = yL = 0 (boundary condition)
% Solve for deflection of beam (finite difference) assuming delx = 50 cm
% with following parameters:
delx = 50; %cm
E = 50000; %kN/cm^2
I = 30000; %cm^4
w0 = 2.5; %kN/cm
L = 600; %cm

% compare with analytical solution
% y = w0/120*EIL(-x^5+2L^2x^3-L^4x)
y = @(x) w0/(120*E*I*L)*(-x.^5+2*L^2*x.^3-L^4*x);
x = 0:delx:L;

% diff equation
dy = @(x) (w0*delx^2/6)*(0.6*L*x-x.^3/L)/(E*I);

% define coefficient matrix
A = zeros(length(x)-2);
A(1,1) = -2;A(1,2) = 1;
for ii=2:length(A)-1
    j=ii-1;
    A(ii,j) = 1;
    A(ii,j+2) = 1;
    A(ii,j+1) = -2;
end
% let Matlab do matrix math for solution
A(end, end-1) = 1; A(end,end)=-2;
c = dy(x);
cc = c(2:end-1)';
Asol = A\cc;
% plot results against analytical solution
plot(x, y(x),'k-')
hold on, grid on
plot(x,[0; Asol ;0], '.r', 'MarkerSize', 18)
xlabel("Distance Along Beam (cm)")
ylabel("Beam Deflection (cm)")
legend('Analytical Solution','Finite-Difference Approx.')
