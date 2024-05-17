function [slidersEnd] = computeSlidersEnd(robot)


    %% Compute sliders end positions
    
    % Hip
    if (robot.motors.enable.hip) slidersEnd.hip.trunk               = robot.motors.trajectories.hip.thigh       - robot.motors.unitVectors.hip*(robot.motors.ballJointLength + robot.motors.sliderLength.hip); end
    if (robot.motors.enable.hip) slidersEnd.hip.thigh               = robot.motors.trajectories.hip.thigh       - robot.motors.unitVectors.hip*robot.motors.ballJointLength; end
    
    % Knee
    if (robot.motors.enable.knee) slidersEnd.knee.thigh             = robot.motors.trajectories.knee.shang      - robot.motors.unitVectors.knee*(robot.motors.ballJointLength + robot.motors.sliderLength.knee) ; end
    if (robot.motors.enable.knee) slidersEnd.knee.shang             = robot.motors.trajectories.knee.shang      - robot.motors.unitVectors.knee*robot.motors.ballJointLength; end
    
    % Ankle
    if (robot.motors.enable.ankle) slidersEnd.ankle.shang           = robot.motors.trajectories.ankle.foot      - robot.motors.unitVectors.ankle*(robot.motors.ballJointLength + robot.motors.sliderLength.ankle); end
    if (robot.motors.enable.ankle) slidersEnd.ankle.foot            = robot.motors.trajectories.ankle.foot      - robot.motors.unitVectors.ankle*robot.motors.ballJointLength; end
    
    % Hip-Knee
    if (robot.motors.enable.hip_knee) slidersEnd.hip_knee.trunk     = robot.motors.trajectories.hip_knee.shang  - robot.motors.unitVectors.hip_knee*(robot.motors.ballJointLength + robot.motors.sliderLength.hip_knee); end
    if (robot.motors.enable.hip_knee) slidersEnd.hip_knee.shang     = robot.motors.trajectories.hip_knee.shang  - robot.motors.unitVectors.hip_knee*robot.motors.ballJointLength; end
    
    % Knee-Ankle
    if (robot.motors.enable.knee_ankle) slidersEnd.knee_ankle.thigh = robot.motors.trajectories.knee_ankle.foot - robot.motors.unitVectors.knee_ankle*(robot.motors.ballJointLength + robot.motors.sliderLength.knee_ankle); end
    if (robot.motors.enable.knee_ankle) slidersEnd.knee_ankle.foot  = robot.motors.trajectories.knee_ankle.foot - robot.motors.unitVectors.knee_ankle*robot.motors.ballJointLength; end
end

