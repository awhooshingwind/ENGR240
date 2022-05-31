function dv = prob2dv(t, x)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
m = [10000; 8000];

% k1 = 3000; %kN/m
% k2 = 2000; %kN/m
% Why define 2 variables, use matlab for matrices!
k = [3000, 2000];
% k = k*1000;
% set up ODEs, more matrix magic!
v1=x(2);
dv1dt=(k(2)/m(1))*x(3)-((k(1)+k(2))/m(1))*x(1);
v2 = x(4);
dv2dt=-k(2)/m(2)*(x(3)-x(1));
dv = [v1;dv1dt;v2;dv2dt];

end
