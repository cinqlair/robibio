function [slidersEnd] = computeSlidersEnd(robot)


    % Compute vector forces
    if (robot.motors.enable.hip) slidersEnd.hip                 = robot.motors.trajectories.hip.thigh       - robot.motors.unitVectors.hip*robot.motors.ballJointLength; end
    if (robot.motors.enable.knee) slidersEnd.knee               = robot.motors.trajectories.knee.shang      - robot.motors.unitVectors.knee*robot.motors.ballJointLength; end
    if (robot.motors.enable.ankle) slidersEnd.ankle             = robot.motors.trajectories.ankle.foot      - robot.motors.unitVectors.ankle*robot.motors.ballJointLength; end
    if (robot.motors.enable.hip_knee) slidersEnd.hip_knee       = robot.motors.trajectories.hip_knee.shang  - robot.motors.unitVectors.hip_knee*robot.motors.ballJointLength; end
    if (robot.motors.enable.knee_ankle) slidersEnd.knee_ankle   = robot.motors.trajectories.knee_ankle.foot - robot.motors.unitVectors.knee_ankle*robot.motors.ballJointLength; end
end

