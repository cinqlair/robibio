function [jacobian] = computeJacobian(motors)
%% Initialize Jacobian
jacobian = zeros(3,5);


%% Hip
if (motors.enable.hip)
    J = -cross (motors.unitVectors.hip(1:3), motors.leverVectors.hip(1:3));
    jacobian(3,5) = J(3);
end


%% Knee
if (motors.enable.knee)
    J = -cross (motors.unitVectors.knee(1:3), motors.leverVectors.knee(1:3));
    jacobian(2,3) = J(3);
end


%% Ankle
if (motors.enable.ankle)
    J = -cross (motors.unitVectors.ankle(1:3), motors.leverVectors.ankle(1:3));
    jacobian(1,1) = J(3);
end



%% Hip-Knee
if (motors.enable.hip_knee)
    J = -cross (motors.unitVectors.hip_knee(1:3), motors.leverVectors.hip_knee.hip(1:3));
    jacobian(3,4) = J(3);
    J = -cross (motors.unitVectors.hip_knee(1:3), motors.leverVectors.hip_knee.knee(1:3));
    jacobian(2,4) = J(3);
end


%% Knee-Ankle
if (motors.enable.knee_ankle)
    J = -cross (motors.unitVectors.knee_ankle(1:3), motors.leverVectors.knee_ankle.knee(1:3));
    jacobian(2,2) = J(3);
    J = -cross (motors.unitVectors.knee_ankle(1:3), motors.leverVectors.knee_ankle.ankle(1:3));
    jacobian(1,2) = J(3);
end
end

