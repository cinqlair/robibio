function [lengths] = computeMotorLengths(robot)


    % Distance between attachment points
    lengths.hip = norm (robot.motors.statorsEnd.hip.trunk(:) - robot.motors.slidersEnd.hip.thigh(:))
    lengths.knee = norm (robot.motors.statorsEnd.knee.thigh(:) - robot.motors.slidersEnd.knee.shang(:));
    lengths.ankle = norm (robot.motors.statorsEnd.ankle.foot(:) - robot.motors.slidersEnd.ankle.shang(:));
    lengths.hip_knee = norm (robot.motors.statorsEnd.hip_knee.trunk(:) - robot.motors.slidersEnd.hip_knee.shang(:));
    lengths.knee_ankle = norm (robot.motors.statorsEnd.knee_ankle.thigh(:)  - robot.motors.slidersEnd.knee_ankle.foot(:));
    
    robot.motors.statorsEnd.hip_knee.trunk(:)
robot.motors.slidersEnd.hip_knee.shang(:)
lengths.hip_knee
end

