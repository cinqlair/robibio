%% Compute the translation matrices for the body segments
function [translation] = computeTranslationMatrices(dimensions)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


    translation.hip_to_neck = [1 0 0 dimensions.trunk(1) ; 0 1 0 dimensions.trunk(2); 0 0 1 dimensions.trunk(3); 0 0 0 1];
    translation.hip_to_knee = [1 0 0 dimensions.thigh(1) ; 0 1 0 dimensions.thigh(2); 0 0 1 dimensions.thigh(3); 0 0 0 1];
    translation.knee_to_ankle = [1 0 0 dimensions.shang(1) ; 0 1 0 dimensions.shang(2); 0 0 1 dimensions.shang(3); 0 0 0 1];
    translation.ankle_to_toes = [1 0 0 dimensions.foot(1) ; 0 1 0 dimensions.foot(2); 0 0 1 dimensions.foot(3); 0 0 0 1];


end

