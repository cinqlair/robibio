close all;clear all;clc;
%% Path for Matlab functions
addpath ('functions/');
global path;
path = 'output';

global expe;
expe = 25;
global epoch;
epoch= 1;
global iter;
iter = 1;
global saveSteps;
saveSteps = false;

%% Create output folders
% fprintf('Deleting folder %s/expe-%d', path, expe);
% system (sprintf('rm -rf %s/expe-%d', path, expe));
% fprintf(' [Done]\n');


%% Global variables (to keep best optimization)
global bestWeight;
global bestEpoch; 
global bestIter;



global gConfigHandler;





%id = 1;




%% Load dataset
% dataGrimmer contains the data (1000 sample per motion)
% dataGrimmer.{hip|knee|ankle}.{angleDeg|torque|theta|angle}
% N is the number of samples

%motionNames = ["Cycling"];
%motionNames = ["Sit_to_Stand"];
%motionNames = ["Climbing_descend"];
%motionNames = ["Stairs_ascend"];
motionNames = [ "Walking_11"];
%motionNames = ["Stairs_descend"];
%motionNames = [ "Walking_16"];
%motionNames = ["Lifting_Squat"];
%motionNames = ["Squat_Jump"];
%motionNames = ["Lifting_Stoop"];
%motionNames = ["Climbing_ascend"];
%motionNames = ["Recovery"];
%motionNames = ["Running_26"];
%motionNames = ["Running_40"];

[dataGrimmer, N] = loadGrimmerData('./', motionNames);

% plot (dataGrimmer.hip.theta);
% hold on;
% plot (dataGrimmer.hip.angleDeg);


start = 1;
step = 1;
stop = 1000;





%% Motors parameters

% Robot segments dimensions
dimensions.trunk = [0, 500, 0, 1];
dimensions.thigh = [0, -380, 0, 1];
dimensions.shang = [0, -358, 0, 1];
dimensions.foot = [121, -54, 0, 1];

% Enable/disable motors
robot.motors.enable.hip = true;
robot.motors.enable.knee = true;
robot.motors.enable.ankle = true;
robot.motors.enable.hip_knee = false;
robot.motors.enable.knee_ankle = false;

% Sliders length [mm]
robot.motors.sliderLength.hip = 290;
robot.motors.sliderLength.knee = 290;
robot.motors.sliderLength.ankle = 290;
robot.motors.sliderLength.hip_knee = 290;
robot.motors.sliderLength.knee_ankle = 290;

% Stator length [mm]
robot.motors.statorLength.hip = 105;
robot.motors.statorLength.knee = 105;
robot.motors.statorLength.ankle = 105;
robot.motors.statorLength.hip_knee = 105;
robot.motors.statorLength.knee_ankle = 105;

% Length of the ball joint at the end of the slider [mm]
robot.motors.ballJointLength = 20;

%% Prepare translation matrices
robot.matrices.translation = computeTranslationMatrices(dimensions);




%% Boundaries
robot.motors.lb =  [ -80     -100    -80,    50, -50 , -100 ...    % Hip { Xh Yh Xl Yl Offset-X Offset-Y }
    -80     -80     -80    278      -50  -100 ...        % Knee { Xh Yh Xl Yl Offset-X Offset-Y }
    -80     0      -200    30      -50  -100  ...        % Ankle { Xh Yh Xl Yl Offset-X Offset-Y }
    -80     -80     -80    278      -50  -100  ...        % Hip-Knee { Xh Yh Xl Yl Offset-X Offset-Y }
    -80    -80      -201   30        -50  -100 ];          % Knee-Ankle { Xh Yh Xl Yl Offset-X Offset-Y }


robot.motors.ub =[   80      500     80      480   50  100 ...     % Hip { Xh Yh Xl Yl Offset-X Offset-Y }
    80      480     80,     438        50  100 ...         % Knee { Xh Yh Xl Yl Offset-X Offset-Y }
    80      350     -41,    130        50  100 ...         % Ankle { Xh Yh Xl Yl Offset-X Offset-Y }
    80      80      80,     438        50  100 ...         % Hip-Knee { Xh Yh Xl Yl Offset-X Offset-Y }
    80      80      -39,    134        50  100];           % Knee-Ankle { Xh Yh Xl Yl Offset-X Offset-Y }

%% Initial configuration (Override in the loop to start from random positions)
x= [ -80 , 300, -80, 400, -20, 100 ...     % Hip { Xh Yh Xl Yl Offset-X Offset-Y }
    40,  250,  40,  380, 50, 0 ...     % Knee { Xh Yh Xl Yl Offset-X Offset-Y }
    60,  200,  -60,  35, -20, 50 ...   % Ankle { Xh Yh Xl Yl Offset-X Offset-Y }
    -50,  -50,  -50,  400, -50, 100 ...   % Hip-Knee { Xh Yh Xl Yl Offset-X Offset-Y }
    -30,  -100,  -160,  35, -30, 70 ];    % Knee-Ankle { Xh Yh Xl Yl Offset-X Offset-Y }

% Load initial points
load(sprintf('initial-points/expe-%d.mat', expe));

for i=1:100
    % Create a random initial position
    
    
    %% Remove processed points
    
    [best, index] = max(initialPoints(:,31));
    
        
    data.initial_x = initialPoints(index, 1:30);
    x = data.initial_x;
   
    
    %fprintf('Remove index %d\n', index);
    initialPoints(index, :) = [];
    
    
    %x=(robot.motors.ub-robot.motors.lb).*rand(1,30)+robot.motors.lb;   
    
    
%     figure(2)
%     gHandle = init_figure_robot();
    
    %% Anonymous function for calling the core from fminsearchbnd
    paramCore = @(x)coreOptim(x,robot, dataGrimmer, start, step, stop, expe);
    
    
    %% Optimization
    fprintf ('Running optimization #%d, it may really take a while...\n', epoch); tic
    options = optimset('Display','off', 'TolFun', 1e-2, 'TolX', 0.1); %, 'MaxFunEvals',10);
    %options = optimset('Display','off', 'TolFun', 1e-2, 'TolX', 0.1, 'MaxFunEvals',10);
    [x,fval,exitflag,output] = fminsearchbnd(paramCore,x,robot.motors.lb, robot.motors.ub, options);
    toc
    
    
    %% Save epoch data
    data.x = x;
    data.fval = fval;
    data.exitflag = exitflag;
    data.output = output;
    data.robot = robot;
    data.best = bestWeight;
    data.bestEpoch = bestEpoch;
    data.bestIter = bestIter;
    save(sprintf('%s/expe-%d/epoch-%d.mat', path, expe, epoch), 'data');    
    epoch = epoch + 1;
    fprintf('\n\t----- New Epoch #%d ------ \n\n', epoch);
    iter = 1;
end
%figure(1);
%plot_initial_configuration_bound(x, lb, ub, motors);
disp ('done')