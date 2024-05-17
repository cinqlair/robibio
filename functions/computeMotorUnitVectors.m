function [vectors] = computeMotorUnitVectors(robot)
    % Hip
    if (robot.motors.enable.hip)
        vector = robot.motors.trajectories.hip.thigh(:) - robot.motors.trajectories.hip.trunk(:);
        vectors.hip = vector/norm (vector);
    end

    % Knee
    if (robot.motors.enable.knee)
        vector = robot.motors.trajectories.knee.shang(:) - robot.motors.trajectories.knee.thigh(:);
        vectors.knee = vector/norm (vector);
    end

    % Ankle
    if (robot.motors.enable.ankle)
        vector = robot.motors.trajectories.ankle.foot(:) - robot.motors.trajectories.ankle.shang(:);
        vectors.ankle = vector/norm (vector);
    end

    % Hip-Knee
    if (robot.motors.enable.hip_knee)
        vector = robot.motors.trajectories.hip_knee.shang(:) - robot.motors.trajectories.hip_knee.trunk(:);
        vectors.hip_knee = vector/norm (vector);
    end

    % Knee-Ankle
    if (robot.motors.enable.knee_ankle)
        vector = robot.motors.trajectories.knee_ankle.foot(:) - robot.motors.trajectories.knee_ankle.thigh(:);
        vectors.knee_ankle = vector/norm (vector);
    end
end

