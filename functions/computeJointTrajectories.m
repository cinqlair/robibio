function [trajectories] = computeJointTrajectories(robot)
    
    trajectories.neck = robot.matrices.transformation.hip_to_neck * [0;0;0;1];
    trajectories.hip = [0;0;0;1];
    trajectories.knee = robot.matrices.transformation.hip_to_knee * [0;0;0;1];
    trajectories.ankle = robot.matrices.transformation.hip_to_ankle  * [0;0;0;1];    
    trajectories.toes = robot.matrices.transformation.hip_to_toes * [0;0;0;1];
end

