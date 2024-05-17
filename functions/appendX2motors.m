function parameters = appendX2motors(x)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    parameters.hip.trunk         = [x(1); x(2)];
    parameters.hip.thigh         = [x(3); x(4)];
    parameters.hip.offset        = [x(5); x(6)];

    parameters.knee.thigh        = [x(7); x(8)];
    parameters.knee.shang        = [x(9); x(10)];
    parameters.knee.offset       = [x(11); x(12)];

    parameters.ankle.shang       = [x(13); x(14)];
    parameters.ankle.foot        = [x(15); x(16)];
    parameters.ankle.offset      = [x(17); x(18)];

    parameters.hip_knee.trunk    = [x(19); x(20)];
    parameters.hip_knee.shang    = [x(21); x(22)];
    parameters.hip_knee.offset   = [x(23); x(24)];


    parameters.knee_ankle.thigh   = [x(25); x(26)];
    parameters.knee_ankle.foot    = [x(27); x(28)];
    parameters.knee_ankle.offset  = [x(29); x(30)];
end

