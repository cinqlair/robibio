close all;clear all;clc;
%% Path for Matlab functions
addpath ('functions/');

%% Global variables (to keep best optimization)
global best_solution;

%% Current index of the main optimization loop
global indexBest 
indexBest = 1;

global gConfigHandler;

id = 3;

delete (sprintf ('output/optim-%d.csv',id))
delete (sprintf ('output/optim-%d.mat',id))


%% Load dataset
% dataGrimmer contains the data (1000 sample per motion)
% dataGrimmer.{hip|knee|ankle}.{angleDeg|torque|theta|angle}
% N is the number of samples

%motionNames = ["Climbing_ascend"];
%motionNames = ["Climbing_descend"];
%motionNames = ["Cycling"];
%motionNames = ["Lifting_Squat"];
%motionNames = ["Lifting_Stoop"];
%motionNames = ["Recovery"];
motionNames = ["Running_26"];
%motionNames = ["Running_40"];
%motionNames = ["Sit_to_Stand"];
%motionNames = ["Squat_Jump"];
%motionNames = ["Stairs_ascend"];
%motionNames = ["Stairs_descend"];
%motionNames = [ "Walking_11"];
%motionNames = [ "Walking_16"];

[dataGrimmer, N] = loadGrimmerData('./', motionNames);

% plot (dataGrimmer.hip.theta);
% hold on;
% plot (dataGrimmer.hip.angleDeg);


start = 1;
step = 10;
stop = 1000;


%% Robot segments dimensions
dimensions.trunk = [0, 500, 0, 1];
dimensions.thigh = [0, -380, 0, 1];
dimensions.shang = [0, -358, 0, 1];
dimensions.foot = [121, -54, 0, 1];

%% Prepare translation matrices
global matrices;
matrices.translation = computeTranslationMatrices(dimensions);

% Animation handler
global gHandle;



%% Enable/disable motors
motors.enable.hip = true;
motors.enable.knee = true;
motors.enable.ankle = true;
motors.enable.hip_knee = true;
motors.enable.knee_ankle = true;






%% Boundaries
lb =  [ -85     -100    -80,    50      -100 ...    % Hip { Xh Yh Xl Yl Offset }
    -80     -80     -80,    278     -100 ...        % Knee { Xh Yh Xl Yl Offset }
    -80     0      -200,    30     -100 ...        % Ankle { Xh Yh Xl Yl Offset }
    -80     -80     -80,    278     -100 ...        % Hip-Knee { Xh Yh Xl Yl Offset }
    -80    -80      -201,   30       -100];          % Knee-Ankle { Xh Yh Xl Yl Offset }


ub =[   85      500     80      480     100 ...     % Hip { Xh Yh Xl Yl Offset }
    80      480     80,     438     100 ...         % Knee { Xh Yh Xl Yl Offset }
    80      350     -41,    130     100 ...         % Ankle { Xh Yh Xl Yl Offset }
    80      80      80,     438     100 ...         % Hip-Knee { Xh Yh Xl Yl Offset }
    80      80      -39,    134     100];           % Knee-Ankle { Xh Yh Xl Yl Offset }


%% Initial configuration (Override in the loop to start from random positions)
x= [ -80 , 400, -80, 400, 0 ...     % Hip { Xh Yh Xl Yl Offset }
    80,  200,  40,  380, 0 ...     % Knee { Xh Yh Xl Yl Offset }
    -60,  300,  -240,  35, 0 ...   % Ankle { Xh Yh Xl Yl Offset }
    -50,  -50,  -50,  300, 0 ...   % Hip-Knee { Xh Yh Xl Yl Offset }
    -30,  100,  -160,  35, 0 ];    % Knee-Ankle { Xh Yh Xl Yl Offset }


%% Plot initial configuration
figure(1); hold on; grid on;
gConfigHandler = plot_initial_configuration(x,motors);



while (1)
    % Create a random initial position
    x=(ub-lb).*rand(1,25)+lb;   
    
    
    % figure(2)
    % gHandle = init_figure_robot();
    
    %% Anonymous function for calling the core from fminsearchbnd
    paramCore = @(x)coreOptim(x,motors, dataGrimmer, start, step, stop, id);
    
    
    %% Optimization
    fprintf ('Running optimization #%d, it may really take a while...\n', indexBest); tic
    options = optimset('Display','off', 'TolFun', 1e-2, 'TolX', 0.1); % 'MaxFunEvals',100);
    [x,fval,exitflag,output] = fminsearchbnd(paramCore,x,lb, ub, options);
    toc
    
    indexBest = indexBest + 1;
end
%figure(1);
%plot_initial_configuration_bound(x, lb, ub, motors);
disp ('done')