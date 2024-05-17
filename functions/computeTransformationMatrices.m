%% Compute the transfomation matrices from hip to toes
function [transformation] = computeTransformationMatrices(robot)
    transformation.hip_to_neck = robot.matrices.translation.hip_to_neck;
    transformation.hip_to_knee = robot.matrices.rotation.hip * robot.matrices.translation.hip_to_knee;
    transformation.hip_to_ankle = transformation.hip_to_knee * robot.matrices.rotation.knee * robot.matrices.translation.knee_to_ankle;
    transformation.hip_to_toes = transformation.hip_to_ankle * robot.matrices.rotation.ankle * robot.matrices.translation.ankle_to_toes;
end

