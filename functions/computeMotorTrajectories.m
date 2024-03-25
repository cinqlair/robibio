function [trajectories] = computeMotorTrajectories(matrices, motors)
    
    % Hip motor coordinates
    trajectories.hip.trunk = [motors.parameters.hip.trunk ; 0 ; 1];
    trajectories.hip.thigh = matrices.transformation.hip_to_knee * [motors.parameters.hip.thigh ; 0 ; 1];
    
    % Knee motor coordinates
    trajectories.knee.thigh = matrices.transformation.hip_to_knee * [motors.parameters.knee.thigh ; 0 ; 1];
    trajectories.knee.shang = matrices.transformation.hip_to_ankle * [motors.parameters.knee.shang ; 0 ; 1];

    % Ankle motor coordinates
    trajectories.ankle.shang = matrices.transformation.hip_to_ankle * [motors.parameters.ankle.shang; 0 ; 1];
    trajectories.ankle.foot = matrices.transformation.hip_to_toes * [motors.parameters.ankle.foot ; 0 ; 1];
    
    % Hip-knee motor coordinates
    trajectories.hip_knee.trunk = [motors.parameters.hip_knee.trunk; 0 ; 1];
    trajectories.hip_knee.shang = matrices.transformation.hip_to_ankle * [motors.parameters.hip_knee.shang; 0 ; 1];
    
    % Knee-ankle motor coordinates
    trajectories.knee_ankle.thigh = matrices.transformation.hip_to_knee * [motors.parameters.knee_ankle.thigh; 0 ; 1];
    trajectories.knee_ankle.foot = matrices.transformation.hip_to_toes * [motors.parameters.knee_ankle.foot; 0 ; 1];
end

