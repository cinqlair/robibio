function [trajectories] = computeMotorJointsTrajectories(robot)
    
    % Hip motor coordinates
    trajectories.hip.trunk = [robot.motors.parameters.hip.trunk ; 0 ; 1];
    trajectories.hip.thigh = robot.matrices.transformation.hip_to_knee * [robot.motors.parameters.hip.thigh ; 0 ; 1];
    
    % Knee motor coordinates
    trajectories.knee.thigh = robot.matrices.transformation.hip_to_knee * [robot.motors.parameters.knee.thigh ; 0 ; 1];
    trajectories.knee.shang = robot.matrices.transformation.hip_to_ankle * [robot.motors.parameters.knee.shang ; 0 ; 1];

    % Ankle motor coordinates
    trajectories.ankle.shang = robot.matrices.transformation.hip_to_ankle * [robot.motors.parameters.ankle.shang; 0 ; 1];
    trajectories.ankle.foot = robot.matrices.transformation.hip_to_toes * [robot.motors.parameters.ankle.foot ; 0 ; 1];
    
    % Hip-knee motor coordinates
    trajectories.hip_knee.trunk = [robot.motors.parameters.hip_knee.trunk; 0 ; 1];
    trajectories.hip_knee.shang = robot.matrices.transformation.hip_to_ankle * [robot.motors.parameters.hip_knee.shang; 0 ; 1];
    
    % Knee-ankle motor coordinates
    trajectories.knee_ankle.thigh = robot.matrices.transformation.hip_to_knee * [robot.motors.parameters.knee_ankle.thigh; 0 ; 1];
    trajectories.knee_ankle.foot = robot.matrices.transformation.hip_to_toes * [robot.motors.parameters.knee_ankle.foot; 0 ; 1];
end

