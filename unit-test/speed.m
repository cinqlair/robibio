close all;clear all;clc;
%% Path for Matlab functions
addpath ('../functions/');

%% Global variables (to keep best optimization)
global best_solution;

motionNames = ["Walking_11"];
%motionNames = [ "Walking_16"];
[dataGrimmer, N] = loadGrimmerData('../', motionNames);

figure;
hold on;
plot (dataGrimmer.hip.theta);
plot (dataGrimmer.hip.dqdt);
plot (1000*diff(dataGrimmer.hip.theta'));
grid on;
legend ('Angle [rad]', 'dqdt [rad/s]', 'diff');
title ('Hip');

figure;
hold on;
plot (dataGrimmer.knee.theta);
plot (dataGrimmer.knee.dqdt);
plot (1000*diff(dataGrimmer.knee.theta'));
grid on;
legend ('Angle [rad]', 'dqdt [rad/s]', 'diff');
title ('Knee');

figure;
hold on;
plot (dataGrimmer.ankle.theta);
plot (dataGrimmer.ankle.dqdt);
plot (1000*diff(dataGrimmer.ankle.theta'));
grid on;
legend ('Angle [rad]', 'dqdt [rad/s]', 'diff');
title ('Ankle');