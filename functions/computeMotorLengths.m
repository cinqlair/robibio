function [lengths] = computeMotorLengths(robot)
    % Distance between attachment points
    lengths.hip = norm (robot.motors.trajectories.hip.trunk(:) - robot.motors.trajectories.hip.thigh(:));
    lengths.knee = norm (robot.motors.trajectories.knee.thigh(:) - robot.motors.trajectories.knee.shang(:));
    lengths.ankle = norm (robot.motors.trajectories.ankle.foot(:) - robot.motors.trajectories.ankle.shang(:));
    lengths.hip_knee = norm (robot.motors.trajectories.hip_knee.trunk(:) - robot.motors.trajectories.hip_knee.shang(:));
    lengths.knee_ankle = norm (robot.motors.trajectories.knee_ankle.thigh(:)  - robot.motors.trajectories.knee_ankle.foot(:));
end

