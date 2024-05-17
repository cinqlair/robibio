function [vectors] = computeLeverVectors(robot)
% Hip
if (robot.motors.enable.hip)
    vectors.hip = (robot.motors.trajectories.hip.thigh(:) - robot.joints.trajectories.hip(:)) / 1000;
end

if (robot.motors.enable.knee)
    vectors.knee= (robot.motors.trajectories.knee.shang(:) - robot.joints.trajectories.knee(:)) / 1000;
end

if (robot.motors.enable.ankle)
    vectors.ankle= (robot.motors.trajectories.ankle.foot(:) - robot.joints.trajectories.ankle(:)) / 1000;
end

if (robot.motors.enable.hip_knee)
    vectors.hip_knee.hip = (robot.motors.trajectories.hip_knee.trunk(:) - robot.joints.trajectories.hip(:) )/ 1000;
    vectors.hip_knee.knee = (robot.motors.trajectories.hip_knee.shang(:) - robot.joints.trajectories.knee(:)  )/ 1000;
end

if (robot.motors.enable.knee_ankle)
    vectors.knee_ankle.knee = (robot.motors.trajectories.knee_ankle.thigh(:) - robot.joints.trajectories.knee(:) )/ 1000;
    vectors.knee_ankle.ankle = (robot.motors.trajectories.knee_ankle.foot(:) - robot.joints.trajectories.ankle(:)  )/ 1000;
end
end

