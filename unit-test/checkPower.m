close all;clear all;clc;
%% Load and prepare data (torque and angles)
grimmer = load ('../dataset-martin-grimmer/data.mat');

%motionNames = ["Climbing_ascend"];
%motionNames = ["Climbing_descend"];
%motionNames = ["Cycling"];
%motionNames = ["Lifting_Squat"];
%motionNames = ["Lifting_Stoop"];
%motionNames = ["Recovery"];
%motionNames = ["Running_26"];
%motionNames = ["Running_40"];
%motionNames = ["Sit_to_Stand"];
motionNames = ["Squat_Jump"];
%motionNames = ["Stairs_ascend"];
%motionNames = ["Stairs_descend"];
%motionNames = ["Walking_11"];
%motionNames = ["Walking_16"];
motion = eval('grimmer.'+motionNames);


motion.hip.rad_s = deg2rad(motion.Hip_Velocity);
motion.knee.rad_s = deg2rad(motion.Knee_Velocity);
motion.ankle.rad_s = deg2rad(motion.Ankle_Velocity);

motion.hip.power = motion.hip.rad_s .* motion.Hip_Moment;
motion.knee.power = motion.knee.rad_s .* motion.Knee_Moment;
motion.ankle.power = motion.ankle.rad_s .* motion.Ankle_Moment;

power = motion.hip.power + motion.knee.power + motion.ankle.power;

mean(power)

power2 = motion.Hip_Power + motion.Knee_Power + motion.Ankle_Power;
mean(power2)

figure;
hold on;
plot (power, 'r' );
plot (power2, 'b');
plot (ones(1000,1)*mean(power), 'r');
plot (ones(1000,1)*mean(power2), 'b');
legend('calculus', 'data');

figure;
plot (motion.Hip_Power );
hold on;
plot (motion.hip.power);
title ('Hip');

figure;
plot (motion.Knee_Power );
hold on;
plot (motion.knee.power);
title ('Knee');

figure;
plot (motion.Ankle_Power );
hold on;
plot (motion.ankle.power);
title ('Ankle');

mean(motion.hip.power)
mean(motion.Hip_Power)


mean(motion.knee.power)
mean(motion.Knee_Power)


mean(motion.ankle.power)
mean(motion.Ankle_Power)