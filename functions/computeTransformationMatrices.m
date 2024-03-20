%% Compute the transfomation matrices from hip to toes
function [transformation] = computeTransformationMatrices(matrices)
    transformation.hip_to_neck = matrices.translation.hip_to_neck;
    transformation.hip_to_knee = matrices.rotation.hip * matrices.translation.hip_to_knee;
    transformation.hip_to_ankle = transformation.hip_to_knee * matrices.rotation.knee * matrices.translation.knee_to_ankle;
    transformation.hip_to_toes = transformation.hip_to_ankle * matrices.rotation.ankle * matrices.translation.ankle_to_toes;
end

