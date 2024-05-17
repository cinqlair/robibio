close all;clear all;clc;
%% Path for Matlab functions
addpath ('functions/');


global expe;
expe = 0;
global epoch;
epoch = 1;



%% Create output folders
system (sprintf('rm -rf output/expe-%d', expe));
mkdir(sprintf('output/expe-%d/epoch-%d', expe, epoch));
hash = randi(1e6);
save(sprintf('output/expe-%d/hash.mat', expe),  'hash');

%% Global variables (to keep best optimization)
global best_solution;

%% Current index of the main optimization loop
global indexBest
indexBest = 1;

global gConfigHandler;


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
%motionNames = ["Running_26"];
%motionNames = ["Running_40"];
%motionNames = ["Sit_to_Stand"];
%motionNames = ["Squat_Jump"];
%motionNames = ["Stairs_ascend"];
%motionNames = ["Stairs_descend"];
motionNames = [ "Walking_11"];
%motionNames = [ "Walking_16"];

[dataGrimmer, N] = loadGrimmerData('./', motionNames);

% plot (dataGrimmer.hip.theta);
% hold on;
% plot (dataGrimmer.hip.angleDeg);


start = 1;
step = 1;
stop = 1000;


%% Robot segments dimensions
dimensions.trunk = [0, 500, 0, 1];
dimensions.thigh = [0, -380, 0, 1];
dimensions.shang = [0, -358, 0, 1];
dimensions.foot = [121, -54, 0, 1];

%% Prepare translation matrices
global matrices;
robot.matrices.translation = computeTranslationMatrices(dimensions);

% Animation handler
global gHandle;


%% Motors parameters

% Enable/disable motors
robot.motors.enable.hip = true;
robot.motors.enable.knee = true;
robot.motors.enable.ankle = true;
robot.motors.enable.hip_knee = true;
robot.motors.enable.knee_ankle = true;

% Sliders length [mm]
robot.motors.sliderLength.hip = 290;
robot.motors.sliderLength.knee = 290;
robot.motors.sliderLength.ankle = 290;
robot.motors.sliderLength.hip_knee = 290;
robot.motors.sliderLength.knee_ankle = 290;

% Length of the ball joint at the end of the slider [mm]
robot.motors.ballJointLength = 20;




%% Boundaries
robot.motors.lb =  [ -85     -100    -80,    50      -100 ...    % Hip { Xh Yh Xl Yl Offset }
    -80     -80     -80,    278     -100 ...        % Knee { Xh Yh Xl Yl Offset }
    -80     0      -200,    30     -100 ...        % Ankle { Xh Yh Xl Yl Offset }
    -80     -80     -80,    278     -100 ...        % Hip-Knee { Xh Yh Xl Yl Offset }
    -80    -80      -201,   30       -100];          % Knee-Ankle { Xh Yh Xl Yl Offset }


robot.motors.ub =[   85      500     80      480     100 ...     % Hip { Xh Yh Xl Yl Offset }
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





robot.motors.parameters = appendX2motors(x);

%% Run core
motors = core(robot, dataGrimmer, start, step, stop);
