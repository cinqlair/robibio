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

isOver = 0;



while (isOver~=1)
    
    filename = sprintf('output/expe-%d/epoch-%d/iter-%d/step-%d.mat', expe, epoch, iter, step);
    if (isfile(filename))
        load(filename)
        data.torques.hip(step) = robot.joints.torques.hip;
        data.torques.knee(step) = robot.joints.torques.knee;
        data.torques.ankle(step) = robot.joints.torques.ankle;
        
        data.expectedTorques.hip(step) = abs(robot.joints.expectedTorques.hip);
        data.expectedTorques.knee(step) = abs(robot.joints.expectedTorques.knee);
        data.expectedTorques.ankle(step) = abs(robot.joints.expectedTorques.ankle);
        
        step = step+1;
    else
        isOver = 1;
    end
    
end

figure;

subplot(3,1,1); hold on;
yyaxis left;
plot (data.torques.hip);
yyaxis right;
plot (data.expectedTorques.hip);
legend('max available', 'required [N.m/kg]');
grid on;
title ('Hip Max Torque');

subplot(3,1,2);  hold on;
yyaxis left;
plot (data.torques.knee);
yyaxis right;
plot (data.expectedTorques.knee);
legend('max available', 'required [N.m/kg]');
grid on;
title ('Knee Max Torque');

subplot(3,1,3);  hold on;
yyaxis left;
plot (data.torques.ankle);
yyaxis right;
plot (data.expectedTorques.ankle);
legend('max available', 'required [N.m/kg]');
grid on;
title ('Ankle Max Torque');









