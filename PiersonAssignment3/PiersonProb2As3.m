clear
clc
close all
% Problem 2: A catenary cable is one which is hung between two points not in the same vertical line. 
% It is subjected to no loads other than its own weight. 
% Thus, its weight acts as a uniform load per unit length along the cable w (N/m). 
% TA and TB are the tension forces at the end. 

% Tension on catenary cable
% define parameters
w = 10;
y0 = 5;
y = 15;
x = 50;
%formula
% plot test
T_A_p = 1100:5:1500;
T_A_plot = (T_A_p./w).*cosh(w./T_A_p.*x) - T_A_p./w + (y0-y);
plot(T_A_p, T_A_plot);
grid on

%fixed point rearrange
fix_T_A =@(T_A) T_A*cosh(w/T_A*x) + (y0 - y) * w;

% fixed point
xo = 1000; %initial guess for fixed point iteration
xr = xo; %assigning initial value of the root as the initial guess
iter = 0; %counting number of iteration later on.
maxit = 100; %maximum number of iteration
es = 0.05;
while (1)
    xrold =  xr; %set up xr as xrold
    xr = fix_T_A(xrold); %evaluate new xr as g(xrold)
    iter = iter+1; %increase the increment
    if xr ~= 0
        ea = abs((xr-xrold)/xr)*100; %calculate for absolute value
    end
    if ea<es || iter >=maxit %check the ea<es OR number of iteration >= maxit
        break
    end
end
iter
xr
% d/dTA
f_T_A = @(T_A) T_A/10 * cosh(500/T_A)-T_A/10 - 10;
ddT_A = @(T_A) 1/10*(-500*sinh(500/T_A)/T_A + cosh(500/T_A)-1);

xr_newt = newtraph(f_T_A, ddT_A, 1000)

xr_modsec = piersonmodsec(f_T_A, 0.01, 1000)

fzero(f_T_A, 1250)

% Compare results
% Modified secant seems to be the most accurate 
% (at least compared to the plot visually and the built-in fzero function in Matlab 
% (both producing a root at ~1266. 
% The fixed point method takes longer since the slope of the function is relatively small, 
% it wanders around before zeroing in on the actual root, 
% whereas the Newton and secant methods, in this case, are able 
% to find the root more quickly – since the slope is effectively linear over the guessing range,
% using tangential methods is efficient and effective.
% If the slope was more exponential or erratic, the Newton and secant methods would take longer to converge.
