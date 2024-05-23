close all;clear all;clc;
%% Path for Matlab functions
addpath ('functions/');



global expe;
expe = 0;
global epoch;
epoch = 1;
global step; 
step = 1;

isOver = 0;



while (isOver~=1)
    
    filename = sprintf('output/expe-%d/epoch-%d/step-%d.mat', expe, epoch, step);
    if (isfile(filename))
        load(filename)
        data.status.hip(step) = robot.motors.status.hip;
        data.status.knee(step) = robot.motors.status.knee;
        data.status.ankle(step) = robot.motors.status.ankle;
        data.status.hip_knee(step) = robot.motors.status.hip_knee;
        data.status.knee_ankle(step) = robot.motors.status.knee_ankle;
        
        step = step+1;
    else
        isOver = 1;
    end
    
end

figure;

subplot(5,1,1);
plot (data.status.hip);
grid on;
title ('Hip Motor Status');

subplot(5,1,2);
plot (data.status.knee);
grid on;
title ('Knee Motor Status');

subplot(5,1,3);
plot (data.status.ankle);
grid on;
title ('Ankle Motor Status');

subplot(5,1,4);
plot (data.status.hip_knee);
grid on;
title ('Hip-knee Motor Status');

subplot(5,1,5);
plot (data.status.knee_ankle);
grid on;
title ('Knee_Ankle Motor Status');




