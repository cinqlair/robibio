close all;clear all;clc;
%% Path for Matlab functions
addpath ('../functions/');
global path;
path = '../output/single';


global saveSteps;
saveSteps = false;
global saveIters;
saveIters = true;



global archId;
global motionId;
global epoch;
global iter;

%% Global variables (to keep best optimization)
global bestWeight;
global bestEpoch;
global bestIter;


for archId = 7:14
    for motionId = 1:14
        
        %% Create output folders
        fprintf('Deleting folder %s/arch-%d-motion-%d',path,  archId, motionId);
        system (sprintf('rm -rf %s/arch-%d-motion-%d',path,  archId, motionId));
        fprintf(' [Done]\n');
        
        mkdir(sprintf('%s/arch-%d-motion-%d',path ,archId, motionId ));
        
        
        % New optimization, reset best values
        bestWeight = 0;
        bestEpoch = 0;
        bestIter = 0;
        
        
        
        global gConfigHandler;
        
        
        
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
        
        %% Initial configuration (Override in the loop to start from random positions)
        % x= [ -80 , 300, -80, 400, -20, 100 ...     % Hip { Xh Yh Xl Yl Offset-X Offset-Y }
        %     40,  250,  40,  380, 50, 0 ...     % Knee { Xh Yh Xl Yl Offset-X Offset-Y }
        %     60,  200,  -60,  35, -20, 50 ...   % Ankle { Xh Yh Xl Yl Offset-X Offset-Y }
        %     -50,  -50,  -50,  400, -50, 100 ...   % Hip-Knee { Xh Yh Xl Yl Offset-X Offset-Y }
        %     -30,  -100,  -160,  35, -30, 70 ];    % Knee-Ankle { Xh Yh Xl Yl Offset-X Offset-Y }
        
        x = zeros(1,30);

        
        % Load initial points
        load(sprintf('../initial-points/single-arch-%d-motion-%d.mat', archId, motionId))
        
        
        for i=1:200
            % Create a random initial position
            
            
            %% Remove processed points
            
            [best, index] = max(initialPoints(:,31));
            
            
            data.x_initial = initialPoints(index, 1:30);
            x = data.x_initial;
            
            %fprintf('Remove index %d\n', index);
            initialPoints(index, :) = [];
            
            
            %x=(robot.motors.ub-robot.motors.lb).*rand(1,30)+robot.motors.lb;
            
            
            %     figure(2)
            %     gHandle = init_figure_robot();
            
            %% Anonymous function for calling the core from fminsearchbnd
            paramCore = @(x)coreOptim(x,robot, dataGrimmer, start, step, stop);
            
            
            %% Optimization
            fprintf ('Running optimization #%d, it may really take a while...\n', epoch); tic
            options = optimset('Display','off', 'TolFun', 1e-2, 'TolX', 0.1); %, 'MaxFunEvals',10);
            %options = optimset('Display','off', 'TolFun', 1e-2, 'TolX', 0.1, 'MaxFunEvals',10);
            [x,fval,exitflag,output] = fminsearchbnd(paramCore,x,robot.motors.lb, robot.motors.ub, options);
            toc
            
            
            %% Save epoch data
            data.x_final = x;
            data.fval = fval;
            data.exitflag = exitflag;
            data.output = output;
            data.robot = robot;
            data.best = bestWeight;
            data.bestEpoch = bestEpoch;
            data.bestIter = bestIter;
            save(sprintf('%s/arch-%d-motion-%d/epoch-%d.mat',path, archId, motionId, epoch), 'data');
            epoch = epoch + 1;
            fprintf('\n\t----- New Epoch #%d ------ \n\n', epoch);
            iter = 1;
        end
        
        
    end
end
%figure(1);
%plot_initial_configuration_bound(x, lb, ub, motors);
disp ('done')

