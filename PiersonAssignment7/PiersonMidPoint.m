function [tp, yp] = PiersonMidPoint(df, tspan, y0, h, es)
%MidPoint Method: 2nd Order Runge-Kutta method (a2 = 1) for solving initial
% value problems for ODEs
%   input:
%       df = differential function
%       tspan = vector holding intial time and final time [ti, tf]
%       y0 = initial value
%       h = step size
%       es = acceptable error for corrector*
%   output:
%       t = time values
%       y = corresponding solution values

% Assignment version, written from scratch for grading
% uses for loop instead while loop
% doesn't error-proof or handle systems of equations, like rk2 version
% commented out beneath

% Define time array
n = length(tspan);
ti = tspan(1);
tf = tspan(n);
tp = ti:h:tf;
% Preallocate y (mostly so the for loop will work properly with the
% indexes)
yp = ones(1,length(tp));
yp(1) = y0;
% Use for loop for implementing MidPoint method
for i = 1:length(tp)-1
    dy = df(tp(i), yp(i)); % slope for the interval
    ymid = df(tp(i) + h/2, yp(i)+dy*h/2); % midpoint est.
    yplus = yp(i)+ymid*h; % calc next y
    yp(i+1) = yplus;% save y value in solution array
end


% Better version - making slight modifition to rk4sys.m
% start block comment
%  RK2 MidPoint
% if nargin<4
%     error('at least 4 input arguments required')
% end
% 
% if any(diff(tspan)<=0)
%     error('tspan not ascending order')
% end
% 
% n = length(tspan);
% ti = tspan(1);
% tf = tspan(n);
% 
% if n == 2
%     t = (ti:h:tf)';
%     n = length(t);
%     if t(n)<tf
%         t(n+1) = tf;
%         n = n+1;
%     end
% else
%     t = tspan;
% end
% 
% tt = ti;
% y(1,:) = y0;
% np = 1;
% tp(np) = tt;
% yp(np,:) = y(1,:);
% i=1;
% 
% while(1)
%     tend = t(np+1);
%     hh = t(np+1) - t(np);
%     if hh>h
%         hh = h;
%     end
% 
%     while(1)
%         if tt+hh>tend
%             hh = tend-tt;
%         end
% 
%         k1 = df(tt,y(i,:))'; 
%         ymid = y(i,:) + k1.*hh./2;
%         k2 = df(tt+hh/2,ymid)';
%         y(i+1,:) = y(i,:) + k2*hh; % changed this line for MidPoint
%     tt = tt+hh;
%     i=i+1;
%     if tt>=tend
%       break
%     end
%  
%   end
%   np = np+1; tp(np) = tt; yp(np,:) = y(i,:);
%   if tt>=tf
%     break
%   end
% tp = tp';  
% end
% end block comment

% I think the rk2 version is the better implementation* but didn't want to submit a
% modified version of rk4sys for the assignment

% *reasons it's better: 
%    - faster to code, building on successful given code
%      with slight modification to make the math fit for 2nd order RK
%      (instead of 4th from rk4sys.m file)
%    - handles variety of time span inputs better and less prone to
%      indexing errors
%    - since MidPoint is a version of 2nd order RK, it's a more consistent
%      implementation, and with only a few tweaks, the function file could
%      be modified to accept an input int to select which order RK to use, 
%      or accept a set of parameters for different
%      versions of different RK methods (Heun or Ralston with different a2
%      values...something I'll play around wtih after the quater ends :)

