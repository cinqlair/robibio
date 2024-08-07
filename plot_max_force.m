close all;clear all;clc;
%% Path for Matlab functions
addpath ('functions/');



global expe;
expe = 1;
global epoch;
epoch = 1;
global iter;
iter = 41;
global step; 
step = 1;


global saveSteps;
saveSteps = false;

isOver = 0;
while (isOver~=1)
    
    filename = sprintf('output/expe-%d/epoch-%d/iter-%d/step-%d.mat', expe, epoch, iter, step);
    if (isfile(filename))
        load(filename)
        data.maxForces.hip(step) = robot.motors.maxForces.hip;
        data.maxForces.knee(step) = robot.motors.maxForces.knee;
        data.maxForces.ankle(step) = robot.motors.maxForces.ankle;
        data.maxForces.hip_knee(step) = robot.motors.maxForces.hip_knee;
        data.maxForces.knee_ankle(step) = robot.motors.maxForces.knee_ankle;
        
        step = step+1;
    else
        isOver = 1;
    end
    
end

figure;

subplot(5,1,1);
plot (data.maxForces.hip);
grid on;
title ('Hip Max Force');

subplot(5,1,2);
plot (data.maxForces.knee);
grid on;
title ('Knee Max Force');

subplot(5,1,3);
plot (data.maxForces.ankle);
grid on;
title ('Ankle Max Force');

subplot(5,1,4);
plot (data.maxForces.hip_knee);
grid on;
title ('Hip-knee Max Force');

subplot(5,1,5);
plot (data.maxForces.knee_ankle);
grid on;
title ('Knee-Ankle Max Force');




