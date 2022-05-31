clear, clc, close all
% Earthquake engineer - 2 story free vibration mass-spring model
% d2x1/dt2 + k1+k2/m1*x1 - k2/m1*x2 = 0
% d2x2/dt2 + k2/m2(x2-x1) = 0

% Write script to simulate dynamics of structure from t = 0s to 20s
% initial condition, first floor velocity (dx1/dt) = 1 m/s
% all other initial values (displacement and velocities) = 0
% Present two time-series plots of displacements and velocities using
% rk4sys, ode45, ode23 - total of 4 subplots (two for each, disp&vel for ea
% floor, with 3 graphs for each method)

% Define known values (use matrix!)
% moved to function file instead, so, commented out
% m1 = 10000; %kg
% m2 = 8000; %kg
% m = [10000; 8000];

% k1 = 3000; %kN/m
% k2 = 2000; %kN/m
% k = [3000, 2000];
tspan = [0, 20]; %s
% Initial value
v1 = 1; %m/s
iv = [0 1 0 0];
step = 0.25; %initial test for rk4sys

% calculations
[trk4, prk4] = rk4sys(@prob2dv, tspan, iv, step);
[tode23, pode23] = ode23s(@prob2dv,tspan,iv);
[tode45, pode45] = ode45(@prob2dv, tspan, iv, step);

% plot loop
ylabs = ["Displacement Building 1 (m)", "Velocity Building 1 (m/s)",...
    "Displacement Building 2 (m)", "Velocitiy Building 2 (m/s)"];
for i=1:4
    subplot(2,2,i)
    plot(tode23, pode23(:,i), '*m')
    hold on
    plot(tode45, pode45(:,i), 'b.','MarkerSize', 5)
    plot(trk4, prk4(:,i),'ko', 'MarkerSize', 4)
    xlabel('t (s)');
    ylabel(ylabs(i));
    legend("ode23s", "ode45", "rk4sys")
end

%test simpsons 1/3 rule for fun
% (calc. building 1 total displacement)
yvals = prk4(:,2);
a = 0;
b=20;
n=40;
% sum inner values (separating odds/evens)
odds = sum(yvals(2:2:end-1));
evens = sum(yvals(3:2:end-1));
% estimate using cumulative trapezoid (to see displacement
% after each est. interval for both buildings)
% play around with some tables out of curiousity
simpB1 = (b-a)*(yvals(1) + 4*(odds) + 2*(evens)+yvals(length(yvals)))/(3*n)
disptot_b1 = cumtrapz(trk4, prk4(:,2));
disptot_b2 = cumtrapz(trk4, prk4(:,4));
T = table(trk4', disptot_b1, disptot_b2,...
    'VariableNames',...
    {'Time (s)',...
    'Cumulative Displacement B1 (m)',...
    'Cumulative Displacement B2 (m)'});
% Table/graph figure testing
fig = uifigure;
fig.Position(3:4) = [722 360];

% Create table UI component
uit = uitable(fig);
uit.Data = T;
uit.ColumnSortable = true;
uit.Position(3) = 290;
uit.DisplayDataChangedFcn = @updatePlot;

% Create bubble chart
ax = uiaxes(fig);
ax.Position(1) = 315;
ax.XLabel.String = 'Time (s)';
ax.YLabel.String = 'Cumulative Displacement B1 (m)';
x = T.("Time (s)");
y = T.("Cumulative Displacement B1 (m)");
sz = T.("Cumulative Displacement B2 (m)");
bubblechart(ax,x,y,sz)

% Update the bubble chart when table data changes
function updatePlot(src,event)
t = uit.DisplayData;
x = T.("Time (s)");
y = T.("Cumulative Displacement B1 (m)");
sz = T.MaxHeight;
bubblechart(ax,x,y,sz)
end


