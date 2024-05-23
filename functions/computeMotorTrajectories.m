function [trajectories] = computeMotorTrajectories(robot)

% Hip motor coordinates
trajectories = robot.motors.joints.trajectories;


%% Hip
if (robot.motors.enable.hip == true && robot.motors.parameters.hip.offset(1) ~=0)
    AB = robot.motors.joints.trajectories.hip.thigh - robot.motors.joints.trajectories.hip.trunk;
    lAB = norm(AB);
    l1 = robot.motors.parameters.hip.offset(1);
    l2 = sqrt(lAB*lAB - l1*l1);
    [S1, S2] = intersectCircles(robot.motors.joints.trajectories.hip.trunk, l1, robot.motors.joints.trajectories.hip.thigh, l2);
    
    if (robot.motors.parameters.hip.offset(1)>0)
        trajectories.hip.trunk(1:2) = S1;
    else
        trajectories.hip.trunk(1:2) = S2;
    end;
end


%% Knee
if (robot.motors.enable.knee == true && robot.motors.parameters.knee.offset(1) ~=0)
    AB = robot.motors.joints.trajectories.knee.shang - robot.motors.joints.trajectories.knee.thigh;
    lAB = norm(AB);
    l1 = robot.motors.parameters.knee.offset(1);
    l2 = sqrt(lAB*lAB - l1*l1);
    [S1, S2] = intersectCircles(robot.motors.joints.trajectories.knee.thigh, l1, robot.motors.joints.trajectories.knee.shang, l2);
    
    if (robot.motors.parameters.knee.offset(1)>0)
        trajectories.knee.thigh(1:2) = S1;
    else
        trajectories.knee.thigh(1:2) = S2;
    end;
end

%% Ankle
if (robot.motors.enable.ankle== true && robot.motors.parameters.ankle.offset(1) ~=0)
    AB = robot.motors.joints.trajectories.ankle.foot - robot.motors.joints.trajectories.ankle.shang;
    lAB = norm(AB);
    l1 = robot.motors.parameters.ankle.offset(1);
    l2 = sqrt(lAB*lAB - l1*l1);
    [S1, S2] = intersectCircles(robot.motors.joints.trajectories.ankle.shang, l1, robot.motors.joints.trajectories.ankle.foot, l2);
    
    if (robot.motors.parameters.ankle.offset(1)>0)
        trajectories.ankle.shang(1:2) = S1;
    else
        trajectories.ankle.shang(1:2) = S2;
    end;
end

%% Hip-Knee
if (robot.motors.enable.hip_knee== true && robot.motors.parameters.hip_knee.offset(1) ~=0)
    AB = robot.motors.joints.trajectories.hip_knee.shang - robot.motors.joints.trajectories.hip_knee.trunk;
    lAB = norm(AB);
    l1 = robot.motors.parameters.hip_knee.offset(1);
    l2 = sqrt(lAB*lAB - l1*l1);
    [S1, S2] = intersectCircles(robot.motors.joints.trajectories.hip_knee.trunk, l1, robot.motors.joints.trajectories.hip_knee.shang, l2);
    
    if (robot.motors.parameters.hip_knee.offset(1)>0)
        trajectories.hip_knee.trunk(1:2) = S1;
    else
        trajectories.hip_knee.trunk(1:2) = S2;
    end;
end

%% Knee-Ankle
if (robot.motors.enable.knee_ankle== true && robot.motors.parameters.knee_ankle.offset(1) ~=0)
    AB = robot.motors.joints.trajectories.knee_ankle.foot - robot.motors.joints.trajectories.knee_ankle.thigh;
    lAB = norm(AB);
    l1 = robot.motors.parameters.knee_ankle.offset(1);
    l2 = sqrt(lAB*lAB - l1*l1);
    [S1, S2] = intersectCircles(robot.motors.joints.trajectories.knee_ankle.thigh, l1, robot.motors.joints.trajectories.knee_ankle.foot, l2);
    
    if (robot.motors.parameters.knee_ankle.offset(1)>0)
        trajectories.knee_ankle.thigh(1:2) = S1;
    else
        trajectories.knee_ankle.thigh(1:2) = S2;
    end;
end
end

