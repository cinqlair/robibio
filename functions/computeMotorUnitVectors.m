function [vectors] = computeMotorUnitVectors(motors)
    % Hip
    if (motors.enable.hip)
        vector = motors.trajectories.hip.thigh(:) - motors.trajectories.hip.trunk(:);
        vectors.hip = vector/norm (vector);
    end

    % Knee
    if (motors.enable.knee)
        vector = motors.trajectories.knee.shang(:) - motors.trajectories.knee.thigh(:);
        vectors.knee = vector/norm (vector);
    end

    % Ankle
    if (motors.enable.ankle)
        vector = motors.trajectories.ankle.foot(:) - motors.trajectories.ankle.shang(:);
        vectors.ankle = vector/norm (vector);
    end

    % Hip-Knee
    if (motors.enable.hip_knee)
        vector = motors.trajectories.hip_knee.shang(:) - motors.trajectories.hip_knee.trunk(:);
        vectors.hip_knee = vector/norm (vector);
    end

    % Knee-Ankle
    if (motors.enable.knee_ankle)
        vector = motors.trajectories.knee_ankle.foot(:) - motors.trajectories.knee_ankle.thigh(:);
        vectors.knee_ankle = vector/norm (vector);
    end
end

