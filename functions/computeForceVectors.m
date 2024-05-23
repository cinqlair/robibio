function [forceVectors] = computeForceVectors(robot)


    % Compute vector forces
    if (robot.motors.enable.hip) forceVectors.hip = robot.motors.unitVectors.hip*robot.motors.forces.hip; end
    if (robot.motors.enable.knee) forceVectors.knee = robot.motors.unitVectors.knee*robot.motors.forces.knee; end
    if (robot.motors.enable.ankle) forceVectors.ankle = robot.motors.unitVectors.ankle*robot.motors.forces.ankle; end
    if (robot.motors.enable.hip_knee) forceVectors.hip_knee = robot.motors.unitVectors.hip_knee*robot.motors.forces.hip_knee; end
    if (robot.motors.enable.knee_ankle) forceVectors.knee_ankle = robot.motors.unitVectors.knee_ankle*robot.motors.forces.knee_ankle; end
end

