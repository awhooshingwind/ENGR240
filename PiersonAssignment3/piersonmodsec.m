function [root, ea, iter]=piersonmodsec(func,perturb,xr,es,maxit)
% modified secant
% [root ea iter]=newtraph(func,dfunc,xr,es,maxit):
%   uses modified secant method to find the root of func
% input:
%   func = name of function
%   perturb = perturbation value
%   xr = initial guess
%   es = desired relative error (default = 0.0001%)
%   maxit = maximum allowable iterations (default = 50)
% output:
%   root = real root
%   ea = approximate relative error (%)
%   iter = number of iterations

%This is a standard argument to check for the number of inputs for the
%Function. Please refer to files in previous module.
if nargin<3,error('at least 3 input arguments required'),end
if nargin<4||isempty(es),es=0.0001;end
if nargin<5||isempty(maxit),maxit=50;end
iter = 0;
while (1)
  xrold = xr; %store xrold for calculating ea later
  xr = xr - (perturb*(xr)*func(xr))/(func(perturb*xr + xr)-func(xr)); %Modified secant formula
  iter = iter + 1;
  if xr ~= 0 
    ea = abs((xr - xrold)/xr) * 100; 
  end
  
  if ea <= es || iter >= maxit %break the while loop when ea <= acceptable error or iteration exceed maximum value
    break 
  end
  
end
root = xr;
% iter

% testing info (copied from a testing script)
% modsec test
% f = @(x) x.^3 - 6*x.^2 + 11*x - 6.1;
% x_plot = 0.5:0.001:3.5;
% plot(x_plot, f(x_plot))
% grid on;
% pturb = 0.01;
% piersonmodsec(f, pturb, 1)
% piersonmodsec(f, pturb, 1.6)
% piersonmodsec(f, pturb, 3)
% 
% % L2 equation
% % M1/(R + r)^2 + M2/r^2 = (M1*R/(M1+M2) + r) * (M1 + M2)/R^3
% % define variables L2
% M1 = 1.9891 * 10^30; % kg mass of Sun
% M2 = 5.972 * 10^24; % kg mass of Earth
% R = 1.496* 10^8; % km distance btw Earth/Sun
% 
% both = M1+M2;
% both_R3 = both/R^3;
% M1_R = M1 * R;
% 
% L2 = @(r) (M1_R/both + r)*(both/R^3)-M1/(R+r)^2 - M2/r^2;
% piersonmodsec(L2, 0.00005, 180000,0.1, 1000)