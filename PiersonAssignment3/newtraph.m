function [root ea iter]=newtraph(func,dfunc,xr,es,maxit)
% modified secant
% [root ea iter]=newtraph(func,dfunc,xr,es,maxit,p1,p2,...):
%   uses Newton-Raphson method to find the root of func
% input:
%   func = name of function
%   dfunc = name of derivative of function
%   xr = initial guess
%   es = desired relative error (default = 0.0001%)
%   maxit = maximum allowable iterations (default = 50)
%   p1,p2,... = additional parameters used by function
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
  xr = xr - func(xr)/dfunc(xr); %Newton Raphson formula
  iter = iter + 1;
  if xr ~= 0 
    ea = abs((xr - xrold)/xr) * 100; 
  end
  
  if ea <= es || iter >= maxit %break the while loop when ea <= acceptable error or iteration exceed maximum value
    break 
  end
  
end
root = xr;
iter