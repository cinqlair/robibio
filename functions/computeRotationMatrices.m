%% Compute the rotation matrices for the body joints
function [rotation] = computeRotationMatrices(thetaHip, thetaKnee, thetaAnkle)

    rotation.hip = [cos(thetaHip) -sin(thetaHip) 0 0 ; sin(thetaHip), cos(thetaHip), 0, 0; 0,0,1,0; 0, 0, 0, 1];
    rotation.knee= [cos(thetaKnee) -sin(thetaKnee) 0 0 ; sin(thetaKnee), cos(thetaKnee), 0, 0; 0,0,1,0; 0, 0, 0, 1];
    rotation.ankle= [cos(thetaAnkle) -sin(thetaAnkle) 0 0 ; sin(thetaAnkle), cos(thetaAnkle), 0, 0; 0,0,1,0; 0, 0, 0, 1];

end

