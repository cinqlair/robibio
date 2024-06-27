function [maxForces, status] = computeMotorMaxForce(robot)
% Distance between attachment points

if (robot.motors.enable.hip)
    [maxForces.hip, status.hip] = P02_23x80F_HP (robot.motors.lengths.hip - robot.motors.parameters.hip.offset(1), robot.motors.sliderLength.hip);
else
    maxForces.hip = 0;
    status.hip = 0;
end

if (robot.motors.enable.knee)
    [maxForces.knee, status.knee]  = P02_23x80F_HP (robot.motors.lengths.knee - robot.motors.parameters.knee.offset(1), robot.motors.sliderLength.knee);
else
    maxForces.knee = 0;
    status.knee = 0;
end

if (robot.motors.enable.ankle)
    [maxForces.ankle, status.ankle]  = P02_23x80F_HP (robot.motors.lengths.ankle - robot.motors.parameters.ankle.offset(1), robot.motors.sliderLength.ankle);
else
    maxForces.ankle = 0;
    status.ankle = 0;
end

if (robot.motors.enable.hip_knee)
    [maxForces.hip_knee, status.hip_knee]  = P02_23x80F_HP (robot.motors.lengths.hip_knee - robot.motors.parameters.hip_knee.offset(1), robot.motors.sliderLength.hip_knee);
else
    maxForces.hip_knee = 0;
    status.hip_knee = 0;
end

if (robot.motors.enable.knee_ankle)
    [maxForces.knee_ankle, status.knee_ankle]  = P02_23x80F_HP (robot.motors.lengths.knee_ankle - robot.motors.parameters.knee_ankle.offset(1), robot.motors.sliderLength.knee_ankle);
else
    maxForces.knee_ankle = 0;
    status.knee_ankle = 0;
end
end

