close all;clear all;clc;
%% Path for Matlab functions
addpath ('../functions/');




global saveSteps;
saveSteps = false;
global saveIters;
saveIters = false;

global archId;
global motionId;
global epoch;
global iter;

for archId = 1:14
    for motionId = 1:14
        
        
        epoch= 1;
        iter = 1;
        
        
        %% Create output folders
        %fprintf('Clean initial-points/single-arch-%d-motion-%d.mat', archId, motionId);
        %system (sprintf('rm -rf ../initial-points/single-arch-%d-motion-%d.mat', archId, motionId));
        %fprintf(' [Done]\n');
        
        
        load (sprintf('../initial-points/single-arch-%d-motion-%d.mat', archId, motionId));
        fds
        
        
        %% Load dataset
        % dataGrimmer contains the data (1000 sample per motion)
        % dataGrimmer.{hip|knee|ankle}.{angleDeg|torque|theta|angle}
        % N is the number of samples
        
        switch motionId
            case 1
                motionNames = ["Climbing_ascend"];
            case 2
                motionNames = ["Climbing_descend"];
            case 3
                motionNames = ["Cycling"];
            case 4
                motionNames = ["Lifting_Squat"];
            case 5
                motionNames = ["Lifting_Stoop"];
            case 6
                motionNames = ["Recovery"];
            case 7
                motionNames = ["Running_26"];
            case 8
                motionNames = ["Running_40"];
            case 9
                motionNames = ["Sit_to_Stand"];
            case 10
                motionNames = ["Squat_Jump"];
            case 11
                motionNames = ["Stairs_ascend"];
            case 12
                motionNames = ["Stairs_descend"];
            case 13
                motionNames = [ "Walking_11"];
            case 14
                motionNames = [ "Walking_16"];
        end
        motionNames
        
        [dataGrimmer, N] = loadGrimmerData('../', motionNames);
        
        
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
        robot.motors.enable.hip_knee = true;
        robot.motors.enable.knee_ankle = true;
        
        switch archId
            case 1
                robot.motors.enable.hip_knee = false;
                robot.motors.enable.knee_ankle = false;
            case 2
                robot.motors.enable.knee_ankle = false;
                robot.motors.enable.hip = false;
            case 3
                robot.motors.enable.hip_knee = false;
                robot.motors.enable.knee = false;
            case 4
                robot.motors.enable.knee_ankle = false;
                robot.motors.enable.knee = false;
            case 5
                robot.motors.enable.knee = false;
                robot.motors.enable.ankle = false;
            case 6
                robot.motors.enable.hip_knee = false;
                robot.motors.enable.ankle = false;
            case 7
                robot.motors.enable.hip = false;
                robot.motors.enable.ankle = false;
            case 8
                robot.motors.enable.knee = false;
                robot.motors.enable.ankle = false;
            case 9
                robot.motors.enable.hip_knee = false;
            case 10
                robot.motors.enable.knee_ankle = false;
            case 11
                robot.motors.enable.hip = false;
            case 12
                robot.motors.enable.knee = false;
            case 13
                robot.motors.enable.ankle = false;
        end
        
        robot.motors.enable
        
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
        
        % %% Initial configuration (Override in the loop to start from random positions)
        % x= [ -80 , 300, -80, 400, -20, 100 ...     % Hip { Xh Yh Xl Yl Offset-X Offset-Y }
        %     40,  250,  40,  380, 50, 0 ...     % Knee { Xh Yh Xl Yl Offset-X Offset-Y }
        %     60,  200,  -60,  35, -20, 50 ...   % Ankle { Xh Yh Xl Yl Offset-X Offset-Y }
        %     -50,  -50,  -50,  400, -50, 100 ...   % Hip-Knee { Xh Yh Xl Yl Offset-X Offset-Y }
        %     -30,  -100,  -160,  35, -30, 70 ];    % Knee-Ankle { Xh Yh Xl Yl Offset-X Offset-Y }
        %
        
        fprintf ("Start creating initial points\n");
        initialPoints = [];
        count = 0;
        while (count < 1000)
            % Create a random initial position
            x=(robot.motors.ub-robot.motors.lb).*rand(1,30)+robot.motors.lb;
            
            %% Add motor coordinates to structure
            robot.motors.parameters = appendX2motors(x);
            
            %% Anonymous function for calling the core from fminsearchbnd
            %paramCore = @(x)coreOptim(x,robot, dataGrimmer, start, step, stop, id);
            
            weight =  core(robot, dataGrimmer, start, step, stop);
            if (weight ~= 0)
                count = count +1;
                initialPoints = [ initialPoints ; [x weight] ];
                fprintf('Arch %d | Motion %d | #%d - %.2f kg (best = %.2f kg) \n', archId, motionId, count, weight, max(initialPoints(:,31)));
                save (sprintf('../initial-points/single-arch-%d-motion-%d.mat', archId, motionId));
                
            end
            
            
        end
        %figure(1);
        %plot_initial_configuration_bound(x, lb, ub, motors);
        disp ('done')
    end
end