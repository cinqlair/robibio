close all;
clear all;
clc;


id=4;

%load (sprintf ('../dataset/output/optim-%d.mat', id));
filename = sprintf ('output/optim-%d.csv', id);


X = dlmread(filename);

%% X(1) =  timestamp
hours = (X(:,1) - X(1,1))*24;

%% X(2) = index of the main loop

%% X(3-27) = motors parameters

%% X(28) = max force
maxForce = X(:,28);

%% X(29) = average input power
inputPower = X(:,29);

%% X(30) = average output power
outputPower = X(:,30);

%% X(31) = efficiency
efficiency = X(:,31);

%% X(32) = Criteria
criteria = X(:,32);

figure();
subplot (2,2,1);
hold on;
plot (hours, maxForce);
title('Max force');
grid on;

subplot (2,2,2);
hold on;
plot (hours, inputPower);
plot (hours, outputPower);
legend('Input Power [W]', 'Output Power [W]');
grid on;

subplot (2,2,3);
hold on;
plot (hours, 13./maxForce);
plot (hours, 67.1./maxForce);
legend('Continuous', 'Max');
title('Max Robot Weight');
grid on;


subplot (2,2,4);
hold on;
plot (hours, efficiency);
title ('Efficiency');
grid on;

fprintf ('Max force = %.2fN\n', min(maxForce));
fprintf ('Max weight= %.2fkg\n', 67.1/min(maxForce));

