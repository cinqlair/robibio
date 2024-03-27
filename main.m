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
stop = 1000;


%% Robot segments dimensions
dimensions.trunk = [0, 500, 0, 1];
dimensions.thigh = [0, -380, 0, 1];
dimensions.shang = [0, -358, 0, 1];
dimensions.foot = [121, -54, 0, 1];

%% Prepare translation matrices
matrices.translation = computeTranslationMatrices(dimensions);



%% Enable/disable motors
motors.enable.hip = true;
motors.enable.knee = true;
motors.enable.ankle = true;
motors.enable.hip_knee = false;
motors.enable.knee_ankle = false;



%% Initial configuration
x= [ -80 , 400, -80, 300, 0 ...     % Hip { Xh Yh Xl Yl Offset }
    80,  200,  40,  380, 0 ...     % Knee { Xh Yh Xl Yl Offset }
    60,  300,  -60,  20, 0 ...   % Ankle { Xh Yh Xl Yl Offset }
    -50,  100,  -50,  300, 0 ...   % Hip-Knee { Xh Yh Xl Yl Offset }
    -30,  100,  -160,  30, 0 ];    % Knee-Ankle { Xh Yh Xl Yl Offset }


%% Prepare the figure
gHandle = init_figure_robot();


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
    
    %% Compute vectors
    motors.unitVectors = computeMotorUnitVectors(motors);
    motors.leverVectors = computeLeverVectors(motors, trajectories);
    
    %% Compute Jacobian
    jacobian = computeJacobian(motors);
    
    
    
    %% Compute motor velocities
    dqdt = [dataGrimmer.ankle.dqdt(i); dataGrimmer.knee.dqdt(i) ; dataGrimmer.hip.dqdt(i)];
    motor_velocities = transpose(jacobian) * dqdt;
    
    motors.velocity.hip        = motor_velocities(5);
    motors.velocity.knee       = motor_velocities(3);
    motors.velocity.ankle      = motor_velocities(1);
    motors.velocity.hip_knee   = motor_velocities(4);
    motors.velocity.knee_ankle = motor_velocities(2);
    
    
    
    
    %% Left leg minimize power
    options = optimset('Display','off');
    
    % Minimize power
    C = diag(motor_velocities);
    
    % System to solve
    Aeq = jacobian;
    beq = [dataGrimmer.ankle.torque(i); dataGrimmer.knee.torque(i) ; dataGrimmer.hip.torque(i)];
    
    % Bounds (Motors maximum force)
    ub = [ Inf; Inf; Inf; Inf; Inf ];
    lb = -ub;
    
    % Solver https://fr.mathworks.com/help/optim/ug/lsqlin.html
    [forces,resnorm,residualLeft,exitFlagLeft,output,lambda] = lsqlin(C, zeros(5,1), [], [], Aeq, beq, lb, ub, [], options);
    
    % Motion should be feasable
    if (exitFlagLeft ~= 1)
        print('Error with constrained linear least-squares problems solver');
    end
    
    % Store forces
    motors.forces = forces;
    % Compute vector forces
    if (motors.enable.hip) motors.forceVectors.hip = motors.unitVectors.hip*forces(5); end
    if (motors.enable.knee) motors.forceVectors.knee = motors.unitVectors.knee*forces(3); end
    if (motors.enable.ankle) motors.forceVectors.ankle = motors.unitVectors.ankle*forces(1); end
    if (motors.enable.hip_knee) motors.forceVectors.hip_knee = motors.unitVectors.hip_knee*forces(4); end
    if (motors.enable.knee_ankle) motors.forceVectors.knee_ankle = motors.unitVectors.knee_ankle*forces(2); end
       
    
    
    data_motors_forces(index, :) = forces;
    data_grimmer_torques(index, :) = [dataGrimmer.ankle.torque(i); dataGrimmer.knee.torque(i) ; dataGrimmer.hip.torque(i)];
    
    update_figure_robot(gHandle, trajectories, motors);
    
    drawnow();

    data(index).motors = motors;
    data(index).trajectories = trajectories;
    
%     
%     data.lengths.hip(index) = motors.lengths.hip;
%     data.lengths.knee(index) = motors.lengths.knee;
%     data.lengths.ankle(index) = motors.lengths.ankle;
%     data.lengths.hip_knee(index) = motors.lengths.hip_knee;
%     data.lengths.knee_ankle(index) = motors.lengths.knee_ankle;
%     
%     data.velocities.hip(index) = motors.velocity.hip;
%     data.velocities.knee(index) = motors.velocity.knee;
%     data.velocities.ankle(index) = motors.velocity.ankle; 
%     data.velocities.hip_knee(index) = motors.velocity.hip_knee;
%     data.velocities.knee_ankle(index) = motors.velocity.knee_ankle;
%     
    
    index = index+1;
end

figure;
hold on;
plot (data_motors_forces(:,5));
plot (20*data_grimmer_torques(:,3));
legend('Force', 'Torque');
title ('Hip');
grid on;


figure;
hold on;
plot (data_motors_forces(:,3));
plot (20*data_grimmer_torques(:,2));
legend('Force', 'Torque');
title ('Knee');
grid on;


figure;
hold on;
plot (data_motors_forces(:,1));
plot (20*data_grimmer_torques(:,1));
legend('Force', 'Torque');
title ('Ankle');
grid on;

% 
% figure;
% hold on;
% plot (data.velocities.hip, 'Color', [1,0,0]);
% plot (data.velocities.knee, 'Color', [0,1,0]);
% plot (data.velocities.ankle, 'Color', [0,0,1]);
% plot (data.velocities.hip_knee, 'Color', [0,1,1]);
% plot (data.velocities.knee_ankle, 'Color', [1,0.5,0]);
% legend('Hip', 'Knee', 'Ankle', 'Hip-Knee', 'Knee-Ankle');
% title ('velocities');
% grid on;
% 
% 
% 
% figure;
% hold on;
% plot (data.lengths.hip, 'Color', [1,0,0]);
% plot (data.lengths.knee, 'Color', [0,1,0]);
% plot (data.lengths.ankle, 'Color', [0,0,1]);
% plot (data.lengths.hip_knee, 'Color', [0,1,1]);
% plot (data.lengths.knee_ankle, 'Color', [1,0.5,0]);
% legend('Hip', 'Knee', 'Ankle', 'Hip-Knee', 'Knee-Ankle');
% title ('Motor length');
% grid on;
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