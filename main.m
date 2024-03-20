close all;clear all;clc;
%% Path for Matlab functions
addpath ('functions/');

%% Global variables (to keep best optimization)
global best_solution;


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
stop = N;


%% Robot segments dimensions
dimensions.trunk = [0, 500, 0, 1];
dimensions.thigh = [0, -380, 0, 1];
dimensions.shang = [0, -358, 0, 1];
dimensions.foot = [121, -54, 0, 1];

%% Prepare translation matrices
matrices.translation = computeTranslationMatrices(dimensions);

%% Prepare the figure
gHandle = init_figure_robot();


%% Enable/disable motors
motors.enable.hip = true;
motors.enable.knee = true;
motors.enable.ankle = true;
motors.enable.hip_knee = true;
motors.enable.knee_ankle = true;



%% Initial configuration
x= [ -80 , 400, -80, 300, 0 ...     % Hip { Xh Yh Xl Yl Offset }
    80,  200,  40,  300, 0 ...     % Knee { Xh Yh Xl Yl Offset }
    60,  300,  -60,  20, 0 ...   % Ankle { Xh Yh Xl Yl Offset }
    -50,  100,  -50,  300, 0 ...   % Hip-Knee { Xh Yh Xl Yl Offset }
    -30,  100,  -160,  30, 0 ];    % Knee-Ankle { Xh Yh Xl Yl Offset }




%% Motion loop
index = 1;
for i=start:step:stop
    
    %% Prepare joint angles
    thetaHip = dataGrimmer.hip.theta(i);
    thetaKnee = dataGrimmer.knee.theta(i);
    thetaAnkle = dataGrimmer.ankle.theta(i);
    
    %% Compute transformation matrices & joints trajectories
    matrices.rotation = computeRotationMatrices(thetaHip, thetaKnee, thetaAnkle);
    matrices.transformation = computeTransformationMatrices(matrices);
    trajectories = computeJointTrajectories(matrices);
    
    %% Compute motors attachment coordinates, trajectories and length
    motors.parameters = appendX2motors(x);
    motors.trajectories = computeMotorTrajectories(matrices, motors);
    motors.lengths = computeMotorLengths(motors);
    
    
    
    
    %% Initialize Jacobian
    jacobian.left = zeros(3,5);
    jacobian.right = zeros(3,5);
    
    %% Hip
    % Compute motor unit vector
    vector_motor = motors.trajectories.hip.thigh(:) - motors.trajectories.hip.trunk(:);
    vector_motor_unit = vector_motor/norm(vector_motor);
    
    % Compute the lever arm in meters (/1000 => mm to m);
    vector_lever = (motors.trajectories.hip.thigh(:) - trajectories.hip(:)) / 1000;
    
    % Compute Jacobian
    J = -cross (vector_motor_unit(1:3), vector_lever(1:3));
    jacobian.left(3,5) = J(3);
    
    
    %% Knee
    % Compute motor unit vector
    vector_motor = motors.trajectories.knee.shang(:) - motors.trajectories.knee.thigh(:);
    vector_motor_unit = vector_motor/norm(vector_motor);

    
    % Compute the lever arm in meters (/1000 => mm to m);
    vector_lever = (motors.trajectories.knee.shang(:) - trajectories.knee(:)  )/ 1000;
    
    % Compute Jacobian
    J = -cross (vector_motor_unit(1:3), vector_lever(1:3));
    jacobian.left(2,3) = J(3);
    
    
    
    %% Ankle
    % Compute motor unit vector
    vector_motor = motors.trajectories.ankle.foot(:) - motors.trajectories.ankle.shang(:);
    vector_motor_unit = vector_motor/norm(vector_motor);
    
    % Compute the lever arm in meters (/1000 => mm to m);
    vector_lever = (motors.trajectories.ankle.foot(:) - trajectories.ankle(:)  )/ 1000;
        
    % Compute Jacobian
    J = -cross (vector_motor_unit(1:3), vector_lever(1:3));
    jacobian.left(1,1) = J(3);
    

    
    %% Hip-Knee    
    % Compute motor unit vector
    vector_motor = motors.trajectories.hip_knee.shang(:) - motors.trajectories.hip_knee.trunk(:);
    vector_motor_unit = vector_motor/norm(vector_motor);
                        
    % Compute the upper lever arm in meters (/1000 => mm to m);
    vector_lever = (motors.trajectories.hip_knee.trunk(:) - trajectories.hip(:) )/ 1000;
    
    % Compute upper Jacobian
    J = -cross (vector_motor_unit(1:3), vector_lever(1:3));
    jacobian.left(3,4) = J(3);
    
    % Compute the lower lever arm in meters (/1000 => mm to m);
    vector_lever = (motors.trajectories.hip_knee.shang(:) - trajectories.knee(:)  )/ 1000;
    
    % Compute lower Jacobian
    J = -cross (vector_motor_unit(1:3), vector_lever(1:3));
    jacobian.left(2,4) = J(3);
    
    
    

    %% Knee-Ankle
    % Compute motor unit vector
    vector_motor = motors.trajectories.knee_ankle.foot(:) - motors.trajectories.knee_ankle.thigh(:);
    vector_motor_unit = vector_motor/norm(vector_motor);
    
    % Compute the upper lever arm in meters (/1000 => mm to m);
    vector_lever = (motors.trajectories.knee_ankle.thigh(:) - trajectories.knee(:) )/1000;
    
    % Compute upper Jacobian
    J = -cross (vector_motor_unit(1:3), vector_lever(1:3));
    jacobian.left(2,2) = J(3);
        
    % Compute the lower lever arm in meters (/1000 => mm to m);
    vector_lever = (motors.trajectories.knee_ankle.foot(:) - trajectories.ankle(:)  )/ 1000
    
    % Compute lower Jacobian
    J = -cross (vector_motor_unit(1:3), vector_lever(1:3));
    jacobian.left(1,2) = J(3);
    
    
    
%     
%     figure(2);
%     plot (0,0,'o');
%     hold on;
%     plot (vector_lever(1), vector_lever(2), '.');
%     axis ([-0.2 0.2 -0.2 0.2]);
%     axis square equal;
%     figure(1);    
    
    
    
    
    
    update_figure_robot(gHandle, trajectories, motors);
    
    drawnow();
    
    
    data.lengths.hip(index) = motors.lengths.hip;
    data.lengths.knee(index) = motors.lengths.knee;
    data.lengths.ankle(index) = motors.lengths.ankle;
    data.lengths.hip_knee(index) = motors.lengths.hip_knee;
    data.lengths.knee_ankle(index) = motors.lengths.knee_ankle;
    index = index+1;
end

figure;
hold on;
plot (data.lengths.hip, 'Color', [1,0,0]);
plot (data.lengths.knee, 'Color', [0,1,0]);
plot (data.lengths.ankle, 'Color', [0,0,1]);
plot (data.lengths.hip_knee, 'Color', [0,1,1]);
plot (data.lengths.knee_ankle, 'Color', [1,0.5,0]);
legend('Hip', 'Knee', 'Ankle', 'Hip-Knee', 'Knee-Ankle');
grid on;
id = 0;



%% Boundaries
lb =  [ -85     -100    -80,    50      -100 ...    % Hip { Xh Yh Xl Yl Offset }
    -80     -80     -80,    278     -100 ...        % Knee { Xh Yh Xl Yl Offset }
    -80     -0      -200,   -54     -100 ...        % Ankle { Xh Yh Xl Yl Offset }
    -80     -80     -80,    278     -100 ...        % Hip-Knee { Xh Yh Xl Yl Offset }
    -80    -80      -201,   0       -100];          % Knee-Ankle { Xh Yh Xl Yl Offset }


ub =[   85      500     80      480     100 ...     % Hip { Xh Yh Xl Yl Offset }
    80      480     80,     438     100 ...         % Knee { Xh Yh Xl Yl Offset }
    80      350     -41,    130     100 ...         % Ankle { Xh Yh Xl Yl Offset }
    80      80      80,     438     100 ...         % Hip-Knee { Xh Yh Xl Yl Offset }
    80      80      -39,    134     100];           % Knee-Ankle { Xh Yh Xl Yl Offset }






%
% %% Plot initial configuration
% figure; hold on; grid on;
% plot_initial_configuration(x,motors);
% %plot_initial_configuration_bound(x, lb, ub, motors);
% drawnow;
%
% core(motors, dataGrimmer, start, step, stop);
% return;
%
%
% %% Anonymous function for calling the core from fminsearchbnd
% paramCore = @(x)coreOptim(x,motors, dataset, start, step, stop, id);
%
%
% %% Optimization
% disp ('Running optimization, it may really take a while...'); tic
% options = optimset('Display','iter', 'TolFun', 1e-2, 'TolX', 0.1); % 'MaxFunEvals',100);
% [x,fval,exitflag,output] = fminsearchbnd(paramCore,x,lb, ub, options);
% toc

disp ('done')