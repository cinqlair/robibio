function parameters = appendX2motors(x)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    parameters.hip.trunk         = [x(1); x(2)];
    parameters.hip.thigh         = [x(3); x(4)];
    parameters.hip.offset        = x(5);

    parameters.knee.thigh        = [x(6); x(7)];
    parameters.knee.shang        = [x(8); x(9)];
    parameters.knee.offset       = x(10);

    parameters.ankle.shang       = [x(11); x(12)];
    parameters.ankle.foot        = [x(13); x(14)];
    parameters.ankle.offset      = x(15);

    parameters.hip_knee.trunk    = [x(16); x(17)];
    parameters.hip_knee.shang    = [x(18); x(19)];
    parameters.hip_knee.offset   = x(20);


    parameters.knee_ankle.thigh   = [x(21); x(22)];
    parameters.knee_ankle.foot    = [x(23); x(24)];
    parameters.knee_ankle.offset  = x(25);
end

