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
        data.lengths.hip(step) = robot.motors.lengths.hip;
        data.lengths.knee(step) = robot.motors.lengths.knee;
        data.lengths.ankle(step) = robot.motors.lengths.ankle;
        data.lengths.hip_knee(step) = robot.motors.lengths.hip_knee;
        data.lengths.knee_ankle(step) = robot.motors.lengths.knee_ankle;
        
        step = step+1;
    else
        isOver = 1;
    end
    
end

figure;

subplot(5,1,1);
plot (data.lengths.hip);
grid on;
title ('Hip Motor Length');

subplot(5,1,2);
plot (data.lengths.knee);
grid on;
title ('Knee Motor Length');

subplot(5,1,3);
plot (data.lengths.ankle);
grid on;
title ('Ankle Motor Length');

subplot(5,1,4);
plot (data.lengths.hip_knee);
grid on;
title ('Hip-knee Motor Length');

subplot(5,1,5);
plot (data.lengths.knee_ankle);
grid on;
title ('Knee_Ankle Motor Length');




