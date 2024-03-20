function [trajectories] = computeJointTrajectories(matrices)
    
    trajectories.neck = matrices.transformation.hip_to_neck * [0;0;0;1];
    trajectories.hip = [0;0;0;1];
    trajectories.knee = matrices.transformation.hip_to_knee * [0;0;0;1];
    trajectories.ankle = matrices.transformation.hip_to_ankle  * [0;0;0;1];    
    trajectories.toes = matrices.transformation.hip_to_toes * [0;0;0;1];
end

