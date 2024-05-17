function [statorsEnd] = computeStatorsEnd(robot)


    %% Compute sliders end positions
    
    % Hip
    if (robot.motors.enable.hip) statorsEnd.hip.trunk               = robot.motors.trajectories.hip.trunk       + robot.motors.unitVectors.hip*(robot.motors.parameters.hip.offset(1) + robot.motors.statorLength.hip); end
    if (robot.motors.enable.hip) statorsEnd.hip.thigh               = robot.motors.trajectories.hip.trunk       + robot.motors.unitVectors.hip*robot.motors.parameters.hip.offset(1); end
    
    % Knee
    if (robot.motors.enable.knee) statorsEnd.knee.thigh             = robot.motors.trajectories.knee.thigh      + robot.motors.unitVectors.knee*(robot.motors.parameters.knee.offset(1) + robot.motors.statorLength.knee); end
    if (robot.motors.enable.knee) statorsEnd.knee.shang             = robot.motors.trajectories.knee.thigh      + robot.motors.unitVectors.knee*robot.motors.parameters.knee.offset(1); end
    
    % Ankle
    if (robot.motors.enable.ankle) statorsEnd.ankle.shang           = robot.motors.trajectories.ankle.shang      + robot.motors.unitVectors.ankle*(robot.motors.parameters.ankle.offset(1) + robot.motors.statorLength.ankle); end
    if (robot.motors.enable.ankle) statorsEnd.ankle.foot            = robot.motors.trajectories.ankle.shang      + robot.motors.unitVectors.ankle*robot.motors.parameters.ankle.offset(1); end
    
    % Hip-Knee
    if (robot.motors.enable.hip_knee) statorsEnd.hip_knee.trunk     = robot.motors.trajectories.hip_knee.trunk   + robot.motors.unitVectors.hip_knee*(robot.motors.parameters.hip_knee.offset(1) + robot.motors.statorLength.hip_knee); end
    if (robot.motors.enable.hip_knee) statorsEnd.hip_knee.shang     = robot.motors.trajectories.hip_knee.trunk   + robot.motors.unitVectors.hip_knee*robot.motors.parameters.hip_knee.offset(1); end
    
    % Knee-Ankle
    if (robot.motors.enable.knee_ankle) statorsEnd.knee_ankle.thigh = robot.motors.trajectories.knee_ankle.thigh + robot.motors.unitVectors.knee_ankle*(robot.motors.parameters.knee_ankle.offset(1) + robot.motors.statorLength.knee_ankle); end
    if (robot.motors.enable.knee_ankle) statorsEnd.knee_ankle.foot  = robot.motors.trajectories.knee_ankle.thigh + robot.motors.unitVectors.knee_ankle*robot.motors.parameters.knee_ankle.offset(1); end
end

