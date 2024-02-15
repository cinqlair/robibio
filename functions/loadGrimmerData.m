function [data, N] = loadGrimmerData(path, motionNames)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%% Load and prepare data (torque and angles)
grimmer = load (strcat(path,'dataset-martin-grimmer/data.mat'));


data.hip.angleDeg   = [];
data.hip.torque     = [];
data.knee.angleDeg  = [];
data.knee.torque    = [];
data.ankle.angleDeg = [];
data.ankle.torque   = [];


for i=1:size(motionNames, 1)
    motion = eval('grimmer.'+motionNames(i));
    
    data.hip.angleDeg   = [ data.hip.angleDeg ; motion.Hip_Angle ];
    data.hip.torque     = [ data.hip.torque; motion.Hip_Moment];
    
    data.knee.angleDeg  = [ data.knee.angleDeg ; motion.Knee_Angle ];
    data.knee.torque    = [ data.knee.torque; motion.Knee_Moment];
    
    data.ankle.angleDeg = [ data.ankle.angleDeg ; motion.Ankle_Angle ];
    data.ankle.torque   = [ data.ankle.torque; motion.Ankle_Moment];
end

data.hip.theta   = -deg2rad(data.hip.angleDeg);
data.knee.theta  = +deg2rad(data.knee.angleDeg);
data.ankle.theta = -deg2rad(data.ankle.angleDeg);

data.hip.angle   = -deg2rad(data.hip.angleDeg)   - pi/2;
data.knee.angle  = +deg2rad(data.knee.angleDeg)  - pi/2;
data.ankle.angle = -deg2rad(data.ankle.angleDeg) - pi/2;

N = size(data.hip.angle, 1);
end

