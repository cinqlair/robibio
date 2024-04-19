close all;
clear all;
clc;

%% Path for Matlab functions
addpath ('../functions/')

%% Load dataset

%motionNames = ["Climbing_ascend"];
%motionNames = ["Climbing_descend"];
%motionNames = ["Cycling"];
motionNames = ["Lifting_Squat"];
%motionNames = ["Lifting_Stoop"];
%motionNames = ["Recovery"];
%motionNames = ["Running_26"];
%motionNames = ["Running_40"];
%motionNames = ["Sit_to_Stand"];
%motionNames = ["Squat_Jump"];
%motionNames = ["Stairs_ascend"];
%motionNames = ["Stairs_descend"];
%motionNames = [ "Walking_11"];
%motionNames = [ "Walking_16"];

[dataGrimmer, N] = loadGrimmerData('./', motionNames);

start = 1;
step = 1;
stop = N;

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

%% Motor references
motors.parameters.hip.reference     = str2func('motor_P01_48x240_30x240');
motors.parameters.knee.reference    = str2func('motor_P01_48x240_30x240');
motors.parameters.ankle.reference   = str2func('motor_P01_48x240_30x240');
motors.parameters.hip_knee.reference = str2func('motor_P01_48x240_30x240');
motors.parameters.knee_ankle.reference = str2func('motor_P01_48x240_30x240');



%% Enable/disable motors
motors.enable.hip = false;
motors.enable.knee = false;
motors.enable.ankle = true;
motors.enable.hip_knee = true;
motors.enable.knee_ankle = true;

    
    
%% Motor boundaries
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


%% Load existing valid geometries if exist
if isfile('random_initial_geometries/data/initial_3_liftSquat.mat')
    load('random_initial_geometries/data/initial_3_liftSquat.mat', 'X');
else
    X=[];
end;

disp ('Start generating for initial configurations');

while (1)
    
    %% Pick valid random initial position    

        
    % Create a random initial position
    x=(ub-lb).*rand(1,25)+lb;
    figure(2)
    gHandle = init_figure_robot();

    %% Run with speed step
    % Run core    
    tic
    motors.parameters = appendX2motors(x);            
    motors = core(motors, dataGrimmer, start, step, stop);                
          
    
    X(end+1,:) = [now x max(motors.dataset_motors_max_force(:)) mean(motors.dataset_efficiency) sum(motors.dataset_input_power)];
    save('random_initial_geometries/data/initial_3_liftSquat', 'X');
    fprintf('Max Force=%.1f %% \tEfficiency=%.1f %% \tPower=%.0fW\n', 100*X(end, end-2), 100*X(end, end-1), X(end, end));
    
    
    close all;
    figure (1); 
    plot_initial_configuration_bound(x, lb, ub, motors);
    title ( sprintf('Config #%d',size(X,1)) );
    drawnow;
end