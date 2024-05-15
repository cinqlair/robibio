close all;clear all;clc;
%% Path for Matlab functions
addpath ('../functions/');


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
motionNames = ["Running_40"];
%motionNames = ["Sit_to_Stand"];
%motionNames = ["Squat_Jump"];
%motionNames = ["Stairs_ascend"];
%motionNames = ["Stairs_descend"];
%motionNames = [ "Walking_11"];
%motionNames = [ "Walking_16"];

[dataGrimmer, N] = loadGrimmerData('../', motionNames);

fprintf('%f \t %f \t %f \t %f \t %f \t %f\n', max(abs(dataGrimmer.hip.torque)), ...
max(abs(dataGrimmer.hip.power)), ...
max(abs(dataGrimmer.knee.torque)), ...
max(abs(dataGrimmer.knee.power)), ...
max(abs(dataGrimmer.ankle.torque)), ...
max(abs(dataGrimmer.ankle.power)))

fprintf('%f \t %f \t %f \t %f \t %f \t %f\n', mean(abs(dataGrimmer.hip.torque)), ...
mean(abs(dataGrimmer.hip.power)), ...
mean(abs(dataGrimmer.knee.torque)), ...
mean(abs(dataGrimmer.knee.power)), ...
mean(abs(dataGrimmer.ankle.torque)), ...
mean(abs(dataGrimmer.ankle.power)))

figure
subplot(3,2,1); hold on 
plot (dataGrimmer.hip.torque);
%plot (dataGrimmer.hip.dqdt);
legend('Torque', 'Velocity');
title('Hip Torque [Nm/kg]');

grid on;

subplot(3,2,3); hold on;
plot (dataGrimmer.knee.torque);
%plot (dataGrimmer.knee.dqdt);
legend('Torque', 'Velocity');
title('Knee Torque [Nm/kg]');

grid on;

subplot(3,2,5); hold on;
plot (dataGrimmer.ankle.torque);
%plot (dataGrimmer.ankle.dqdt);
legend('Torque', 'Velocity');
title('Ankle Torque [Nm/kg]');
grid on;


subplot(3,2,2);
plot (dataGrimmer.hip.power);
title('Hip Power W/kg');
grid on;

subplot(3,2,4);
plot (dataGrimmer.knee.power);
title('Knee Power W/kg');
grid on;

subplot(3,2,6);
plot (dataGrimmer.ankle.power);
title('Ankle Power W/kg');
grid on;