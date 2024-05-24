close all;clear all;clc;
%% Path for Matlab functions
addpath ('functions/');



global expe;
expe = 1;
global epoch;
epoch = 1;
global iter;
iter = 179;
global step;
step = 1;


global saveSteps;
saveSteps = false;


isOver = 0;
while (isOver~=1)
    
    filename = sprintf('output/expe-%d/epoch-%d/iter-%d/step-%d.mat', expe, epoch, iter, step);
    if (isfile(filename))
        load(filename)
        data.weight.hip(step) = min(30, robot.weight_max.hip);
        data.weight.knee(step) = min(30, robot.weight_max.knee);
        data.weight.ankle(step) = min(30, robot.weight_max.ankle);
        data.weight.global(step) = min(30, robot.weight_max.global);
        step = step+1;
    else
        isOver = 1;
    end
    
end

figure;

subplot(4,1,1); hold on;
plot (data.weight.hip);
grid on;
title ('Hip Max Weight');

subplot(4,1,2); hold on;
plot (data.weight.knee);
grid on;
title ('Knee Max Weight');

subplot(4,1,3); hold on;
plot (data.weight.ankle);
grid on;
title ('Ankle Max Weight');

subplot(4,1,4); hold on;
plot (data.weight.global);
grid on;
title ('Max Weight');

fprintf ('Max Weight = %f kg\n', min(data.weight.global));








