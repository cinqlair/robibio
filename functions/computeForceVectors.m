function [forceVectors] = computeForceVectors(motors, forces)


    % Compute vector forces
    if (motors.enable.hip) forceVectors.hip = motors.unitVectors.hip*forces(5); end
    if (motors.enable.knee) forceVectors.knee = motors.unitVectors.knee*forces(3); end
    if (motors.enable.ankle) forceVectors.ankle = motors.unitVectors.ankle*forces(1); end
    if (motors.enable.hip_knee) forceVectors.hip_knee = motors.unitVectors.hip_knee*forces(4); end
    if (motors.enable.knee_ankle) forceVectors.knee_ankle = motors.unitVectors.knee_ankle*forces(2); end
end

