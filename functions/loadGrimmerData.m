function [data, N] = loadGrimmerData(path, motionNames)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%% Load and prepare data (torque and angles)
grimmer = load (strcat(path,'dataset-martin-grimmer/data.mat'));


data.hip.angleDeg   = [];
data.hip.torque     = [];
data.hip.dqdt       = [];
data.hip.power      = [];

data.knee.angleDeg  = [];
data.knee.torque    = [];
data.knee.dqdt      = [];
data.knee.power     = [];

data.ankle.angleDeg = [];
data.ankle.torque   = [];
data.ankle.dqdt     = [];
data.ankle.power    = [];

for i=1:size(motionNames, 2)
    
    motion = eval('grimmer.'+motionNames(i));
    
    data.hip.angleDeg   = [ data.hip.angleDeg ; motion.Hip_Angle ];
    data.hip.torque     = [ data.hip.torque; motion.Hip_Moment];
    data.hip.dqdt       = [ data.hip.dqdt; motion.Hip_Velocity];
    data.hip.power      = [ data.hip.power; motion.Hip_Power];
    
    data.knee.angleDeg  = [ data.knee.angleDeg ; motion.Knee_Angle ];
    data.knee.torque    = [ data.knee.torque; motion.Knee_Moment];
    data.knee.dqdt      = [ data.knee.dqdt; motion.Knee_Velocity];
    data.knee.power     = [ data.knee.power; motion.Knee_Power];
    
    data.ankle.angleDeg = [ data.ankle.angleDeg ; motion.Ankle_Angle ];
    data.ankle.torque   = [ data.ankle.torque; motion.Ankle_Moment];
    data.ankle.dqdt     = [ data.ankle.dqdt; motion.Ankle_Velocity];
    data.ankle.power    = [ data.ankle.power; motion.Ankle_Power];
end

data.hip.theta    = -deg2rad(data.hip.angleDeg);
data.knee.theta   = +deg2rad(data.knee.angleDeg);
data.ankle.theta  = -deg2rad(data.ankle.angleDeg);

data.hip.angle    = -deg2rad(data.hip.angleDeg)   - pi/2;
data.knee.angle   = +deg2rad(data.knee.angleDeg)  - pi/2;
data.ankle.angle  = -deg2rad(data.ankle.angleDeg) - pi/2;

data.hip.dqdt     = -deg2rad(data.hip.dqdt);
data.knee.dqdt    = +deg2rad(data.knee.dqdt);
data.ankle.dqdt   = -deg2rad(data.ankle.dqdt);

data.hip.torque   = -data.hip.torque;
data.knee.torque  = +data.knee.torque;
data.ankle.torque = -data.ankle.torque;

N = size(data.hip.angle, 1);
end

