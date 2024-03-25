function [vectors] = computeLeverVectors(motors, trajectories)
% Hip
if (motors.enable.hip)
    vectors.hip = (motors.trajectories.hip.thigh(:) - trajectories.hip(:)) / 1000;
end

if (motors.enable.knee)
    vectors.knee= (motors.trajectories.knee.shang(:) - trajectories.knee(:)) / 1000;
end

if (motors.enable.ankle)
    vectors.ankle= (motors.trajectories.ankle.foot(:) - trajectories.ankle(:)) / 1000;
end

if (motors.enable.hip_knee)
    vectors.hip_knee.hip = (motors.trajectories.hip_knee.trunk(:) - trajectories.hip(:) )/ 1000;
    vectors.hip_knee.knee = (motors.trajectories.hip_knee.shang(:) - trajectories.knee(:)  )/ 1000;
end

if (motors.enable.knee_ankle)
    vectors.knee_ankle.knee = (motors.trajectories.knee_ankle.thigh(:) - trajectories.knee(:) )/ 1000;
    vectors.knee_ankle.ankle = (motors.trajectories.knee_ankle.foot(:) - trajectories.ankle(:)  )/ 1000;
end
end

