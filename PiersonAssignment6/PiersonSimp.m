function I = PiersonSimp(f,a, b, n)
% Composite Simpson's 1/3 rule
%   I = integral estimate
%   func = function to be evaluated
%   a,b = integration limits
%   n - number of segments

% calculate step size
h = (b-a)/n;
if mod(b/h, 2) ~= 0
    error('must have even number of segments')
end
% evaluate function at each step
xvals = a:h:b;
yvals = f(xvals);
% sum inner values (separating odds/evens)
odds = sum(yvals(2:2:end-1));
evens = sum(yvals(3:2:end-1));
% estimate using composite Simpson's 1/3 rule
I = (b-a)*(yvals(1) + 4*(odds) + 2*(evens)+yvals(length(yvals)))/(3*n);
end
