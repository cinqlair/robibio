close all;clear all;clc;
%% Path for Matlab functions
addpath ('functions/');

%% Global variables (to keep best optimization)
global best_solution;


%% Load dataset
motionNames = [ "Walking_11"; "Sit_to_Stand"; "Walking_16"];
[dataGrimmer, N] = loadGrimmerData('./', motionNames);


start = 10000;
step = 1;
stop = 12000;

%% Enable/disable motors
motors.enable.hip = true;
motors.enable.knee = true;
motors.enable.ankle = true;
motors.enable.hip_knee = true;
motors.enable.knee_ankle = true;
id = 0;

%% Anonymous function for calling the core from fminsearchbnd
paramCore = @(x)coreOptim(x,motors, dataset, start, step, stop, id);

motors


%% Load initial position
load('dataset/initial-config/valid_expe_1.mat');


% Pick a random configuration
i = ceil(rand * size(X,1));
fprintf ('pick random config %d over %d\n',i, size(X,1));
x = X(i,1:25)


lb =  [ -85     -100    -80,    50      -100 ...
    -80     -80     -80,    278     -100 ...
    -80     -0      -200,   -54     -100 ...
    -80     -80     -80,    278     -100 ...
    -80    -80      -201,   0       -100];

ub =[   85      500     80      480     100 ...
    80      480     80,     438     100 ...
    80      350     -41,    130     100 ...
    80      80      80,     438     100 ...
    80      80      -39,    134     100];


%% Anonymous function for calling the core from fminsearchbnd
paramCore = @(x)coreOptim(x,motors, dataset, start, step, stop, id);



figure; hold on; grid on;
plot_initial_configuration_bound(x, lb, ub, motors);
drawnow;

%% Optimization
disp ('Running optimization, it may really take a while...'); tic
options = optimset('Display','iter', 'TolFun', 1e-2, 'TolX', 0.1); % 'MaxFunEvals',100);
[x,fval,exitflag,output] = fminsearchbnd(paramCore,x,lb, ub, options);
toc

disp ('done')