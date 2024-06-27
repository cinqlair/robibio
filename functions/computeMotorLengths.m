function [lengths] = computeMotorLengths(robot)

    % Distance between attachment points
    if (robot.motors.enable.hip)
        lengths.hip = norm (robot.motors.statorsEnd.hip.trunk(:) - robot.motors.slidersEnd.hip.thigh(:));
    end
    
    if (robot.motors.enable.knee)
        lengths.knee = norm (robot.motors.statorsEnd.knee.thigh(:) - robot.motors.slidersEnd.knee.shang(:));
    end
    
    if (robot.motors.enable.ankle)
        lengths.ankle = norm (robot.motors.statorsEnd.ankle.foot(:) - robot.motors.slidersEnd.ankle.shang(:));
    end
    
    if (robot.motors.enable.hip_knee)
        lengths.hip_knee = norm (robot.motors.statorsEnd.hip_knee.trunk(:) - robot.motors.slidersEnd.hip_knee.shang(:));
    end
    
    if (robot.motors.enable.knee_ankle)
        lengths.knee_ankle = norm (robot.motors.statorsEnd.knee_ankle.thigh(:)  - robot.motors.slidersEnd.knee_ankle.foot(:));
    end
end

