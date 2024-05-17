function [maxForces] = computeMotorMaxForce(robot)
    % Distance between attachment points
    maxForces.hip = P02_23x80F_HP (robot.motors.lengths.hip - robot.motors.parameters.hip.offset, robot.motors.sliderLength.hip);
    maxForces.knee = P02_23x80F_HP (robot.motors.lengths.knee - robot.motors.parameters.knee.offset, robot.motors.sliderLength.knee);
    maxForces.ankle = P02_23x80F_HP (robot.motors.lengths.ankle - robot.motors.parameters.ankle.offset, robot.motors.sliderLength.ankle);
    maxForces.hip_knee = P02_23x80F_HP (robot.motors.lengths.hip_knee - robot.motors.parameters.hip_knee.offset, robot.motors.sliderLength.hip_knee);
    maxForces.knee_ankle = P02_23x80F_HP (robot.motors.lengths.knee_ankle - robot.motors.parameters.knee_ankle.offset, robot.motors.sliderLength.knee_ankle);
end

