function [lengths] = computeMotorLengths(motors)
    % Distance between attachment points
    lengths.hip = norm (motors.trajectories.hip.trunk(:) - motors.trajectories.hip.thigh(:));
    lengths.knee = norm (motors.trajectories.knee.thigh(:) - motors.trajectories.knee.shang(:));
    lengths.ankle = norm (motors.trajectories.ankle.foot(:) - motors.trajectories.ankle.shang(:));
    lengths.hip_knee = norm (motors.trajectories.hip_knee.trunk(:) - motors.trajectories.hip_knee.shang(:));
    lengths.knee_ankle = norm (motors.trajectories.knee_ankle.thigh(:)  - motors.trajectories.knee_ankle.foot(:));
end

