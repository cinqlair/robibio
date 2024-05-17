function [humod_time, robibio_index] = update_figure_robot(gHandle, robot)


%    robibio_index = motors.humod_step(index);

%% Update joints
set(gHandle.joint.neck,    'XData', robot.joints.trajectories.neck(1),   'YData', robot.joints.trajectories.neck(2));
set(gHandle.joint.knee,    'XData', robot.joints.trajectories.knee(1),   'YData', robot.joints.trajectories.knee(2));
set(gHandle.joint.ankle,   'XData',  robot.joints.trajectories.ankle(1),   'YData', robot.joints.trajectories.ankle(2));
set(gHandle.joint.toes,   'XData',  robot.joints.trajectories.toes(1),   'YData', robot.joints.trajectories.toes(2));


%% Update segments
set(gHandle.segment.trunk,   'XData', [0, robot.joints.trajectories.neck(1)],   'YData', [0, robot.joints.trajectories.neck(2)]);
set(gHandle.segment.thigh,   'XData', [0, robot.joints.trajectories.knee(1)],   'YData', [0, robot.joints.trajectories.knee(2)]);
set(gHandle.segment.shang,   'XData', [robot.joints.trajectories.knee(1), robot.joints.trajectories.ankle(1)],   'YData', [robot.joints.trajectories.knee(2), robot.joints.trajectories.ankle(2)]);
set(gHandle.segment.foot,    'XData', [robot.joints.trajectories.ankle(1), robot.joints.trajectories.toes(1)],   'YData', [robot.joints.trajectories.ankle(2), robot.joints.trajectories.toes(2)]);




%% Update torques
%     set(gHandle.torque.Left.Knee,    'XData', dataset.trajectories.x(1,robibio_index),   'YData', dataset.trajectories.y(1,robibio_index),  'MarkerSize', abs(dataset.torques.q(1,robibio_index)));
%     set(gHandle.torque.Right.Knee,   'XData', dataset.trajectories.x(2,robibio_index),   'YData', dataset.trajectories.y(2,robibio_index),  'MarkerSize', abs(dataset.torques.q(2,robibio_index)));
%     set(gHandle.torque.Left.Ankle,   'XData', dataset.trajectories.x(3,robibio_index),   'YData', dataset.trajectories.y(3,robibio_index),  'MarkerSize', abs(dataset.torques.q(3,robibio_index)));
%     set(gHandle.torque.Right.Ankle,  'XData', dataset.trajectories.x(4,robibio_index),   'YData', dataset.trajectories.y(4,robibio_index),  'MarkerSize', abs(dataset.torques.q(4,robibio_index)));
%     set(gHandle.torque.Left.Foot,    'XData', dataset.trajectories.x(5,robibio_index),   'YData', dataset.trajectories.y(5,robibio_index),  'MarkerSize', abs(dataset.torques.q(5,robibio_index)));
%     set(gHandle.torque.Right.Foot,   'XData', dataset.trajectories.x(6,robibio_index),   'YData', dataset.trajectories.y(6,robibio_index),  'MarkerSize', abs(dataset.torques.q(6,robibio_index)));



%% Update motors
%% Hip
if (robot.motors.enable.hip)
    % Motor
    set(gHandle.motor.hip,  'XData', [robot.motors.trajectories.hip.trunk(1),  robot.motors.trajectories.hip.thigh(1)]);
    set(gHandle.motor.hip,  'YData', [robot.motors.trajectories.hip.trunk(2), robot.motors.trajectories.hip.thigh(2)]);
    % Unit vector
    set(gHandle.motor.unitVectors.hip,  'XData', [robot.motors.trajectories.hip.thigh(1), robot.motors.trajectories.hip.thigh(1) + 100*robot.motors.unitVectors.hip(1)]);
    set(gHandle.motor.unitVectors.hip,  'YData', [robot.motors.trajectories.hip.thigh(2), robot.motors.trajectories.hip.thigh(2) + 100*robot.motors.unitVectors.hip(2)]);
    % Lever vector
    set(gHandle.motor.leverVectors.hip,  'XData', [robot.joints.trajectories.hip(1), robot.joints.trajectories.hip(1) + 1000*robot.motors.leverVectors.hip(1)]);
    set(gHandle.motor.leverVectors.hip,  'YData', [robot.joints.trajectories.hip(2), robot.joints.trajectories.hip(2) + 1000*robot.motors.leverVectors.hip(2)]);    
    % Force vector
    set(gHandle.motor.forceVectors.hip,  'XData', [robot.motors.trajectories.hip.thigh(1), robot.motors.trajectories.hip.thigh(1) + 10*robot.motors.forceVectors.hip(1)]);
    set(gHandle.motor.forceVectors.hip,  'YData', [robot.motors.trajectories.hip.thigh(2), robot.motors.trajectories.hip.thigh(2) + 10*robot.motors.forceVectors.hip(2)]);
end

%% Knee
if (robot.motors.enable.knee)
    % Motor
    set(gHandle.motor.knee, 'XData', [robot.motors.trajectories.knee.thigh(1),  robot.motors.trajectories.knee.shang(1)]);
    set(gHandle.motor.knee, 'YData', [robot.motors.trajectories.knee.thigh(2),  robot.motors.trajectories.knee.shang(2)]);
    % Unit vector
    set(gHandle.motor.unitVectors.knee,  'XData', [robot.motors.trajectories.knee.shang(1), robot.motors.trajectories.knee.shang(1) + 100*robot.motors.unitVectors.knee(1)]);
    set(gHandle.motor.unitVectors.knee,  'YData', [robot.motors.trajectories.knee.shang(2), robot.motors.trajectories.knee.shang(2) + 100*robot.motors.unitVectors.knee(2)]);
    % Lever vector
    set(gHandle.motor.leverVectors.knee,  'XData', [robot.joints.trajectories.knee(1), robot.joints.trajectories.knee(1) + 1000*robot.motors.leverVectors.knee(1)]);
    set(gHandle.motor.leverVectors.knee,  'YData', [robot.joints.trajectories.knee(2), robot.joints.trajectories.knee(2) + 1000*robot.motors.leverVectors.knee(2)]); 
    % Force vector
    set(gHandle.motor.forceVectors.knee,  'XData', [robot.motors.trajectories.knee.shang(1), robot.motors.trajectories.knee.shang(1) + 10*robot.motors.forceVectors.knee(1)]);
    set(gHandle.motor.forceVectors.knee,  'YData', [robot.motors.trajectories.knee.shang(2), robot.motors.trajectories.knee.shang(2) + 10*robot.motors.forceVectors.knee(2)]);
end

%% Ankle
if (robot.motors.enable.ankle)
    % Motor
    set(gHandle.motor.ankle, 'XData', [robot.motors.trajectories.ankle.shang(1), robot.motors.trajectories.ankle.foot(1)]);
    set(gHandle.motor.ankle, 'YData', [robot.motors.trajectories.ankle.shang(2), robot.motors.trajectories.ankle.foot(2)]);
    % Unit vector
    set(gHandle.motor.unitVectors.ankle,  'XData', [robot.motors.trajectories.ankle.foot(1), robot.motors.trajectories.ankle.foot(1) + 100*robot.motors.unitVectors.ankle(1)]);
    set(gHandle.motor.unitVectors.ankle,  'YData', [robot.motors.trajectories.ankle.foot(2), robot.motors.trajectories.ankle.foot(2) + 100*robot.motors.unitVectors.ankle(2)]);
    % Lever vector
    set(gHandle.motor.leverVectors.ankle,  'XData', [robot.joints.trajectories.ankle(1), robot.joints.trajectories.ankle(1) + 1000*robot.motors.leverVectors.ankle(1)]);
    set(gHandle.motor.leverVectors.ankle,  'YData', [robot.joints.trajectories.ankle(2), robot.joints.trajectories.ankle(2) + 1000*robot.motors.leverVectors.ankle(2)]); 
    % Force vector
    set(gHandle.motor.forceVectors.ankle,  'XData', [robot.motors.trajectories.ankle.foot(1), robot.motors.trajectories.ankle.foot(1) + 10*robot.motors.forceVectors.ankle(1)]);
    set(gHandle.motor.forceVectors.ankle,  'YData', [robot.motors.trajectories.ankle.foot(2), robot.motors.trajectories.ankle.foot(2) + 10*robot.motors.forceVectors.ankle(2)]);    
end

%% Hip-Knee
if (robot.motors.enable.hip_knee)
    % Motor
    set(gHandle.motor.hip_knee, 'XData', [robot.motors.trajectories.hip_knee.trunk(1),  robot.motors.trajectories.hip_knee.shang(1)]);
    set(gHandle.motor.hip_knee, 'YData', [robot.motors.trajectories.hip_knee.trunk(2), robot.motors.trajectories.hip_knee.shang(2)]);
    % Unit vector
    set(gHandle.motor.unitVectors.hip_knee,  'XData', [robot.motors.trajectories.hip_knee.shang(1), robot.motors.trajectories.hip_knee.shang(1) + 100*robot.motors.unitVectors.hip_knee(1)]);
    set(gHandle.motor.unitVectors.hip_knee,  'YData', [robot.motors.trajectories.hip_knee.shang(2), robot.motors.trajectories.hip_knee.shang(2) + 100*robot.motors.unitVectors.hip_knee(2)]);
    % Lever vector
    set(gHandle.motor.leverVectors.hip_knee.hip,  'XData', [robot.joints.trajectories.hip(1), robot.joints.trajectories.hip(1) + 1000*robot.motors.leverVectors.hip_knee.hip(1)]);
    set(gHandle.motor.leverVectors.hip_knee.hip,  'YData', [robot.joints.trajectories.hip(2), robot.joints.trajectories.hip(2) + 1000*robot.motors.leverVectors.hip_knee.hip(2)]); 
    set(gHandle.motor.leverVectors.hip_knee.knee,  'XData', [robot.joints.trajectories.knee(1), robot.joints.trajectories.knee(1) + 1000*robot.motors.leverVectors.hip_knee.knee(1)]);
    set(gHandle.motor.leverVectors.hip_knee.knee,  'YData', [robot.joints.trajectories.knee(2), robot.joints.trajectories.knee(2) + 1000*robot.motors.leverVectors.hip_knee.knee(2)]); 
    % Forcevector
    set(gHandle.motor.forceVectors.hip_knee,  'XData', [robot.motors.trajectories.hip_knee.shang(1), robot.motors.trajectories.hip_knee.shang(1) + 100*robot.motors.forceVectors.hip_knee(1)]);
    set(gHandle.motor.forceVectors.hip_knee,  'YData', [robot.motors.trajectories.hip_knee.shang(2), robot.motors.trajectories.hip_knee.shang(2) + 100*robot.motors.forceVectors.hip_knee(2)]);
end;


%% Knee-Ankle
if (robot.motors.enable.knee_ankle)
    % Motor
    set(gHandle.motor.knee_ankle, 'XData', [robot.motors.trajectories.knee_ankle.thigh(1),  robot.motors.trajectories.knee_ankle.foot(1)]);
    set(gHandle.motor.knee_ankle, 'YData', [robot.motors.trajectories.knee_ankle.thigh(2), robot.motors.trajectories.knee_ankle.foot(2)]);
    % Unit vector
    set(gHandle.motor.unitVectors.knee_ankle,  'XData', [robot.motors.trajectories.knee_ankle.foot(1), robot.motors.trajectories.knee_ankle.foot(1) + 100*robot.motors.unitVectors.knee_ankle(1)]);
    set(gHandle.motor.unitVectors.knee_ankle,  'YData', [robot.motors.trajectories.knee_ankle.foot(2), robot.motors.trajectories.knee_ankle.foot(2) + 100*robot.motors.unitVectors.knee_ankle(2)]);
    % Lever vector
    set(gHandle.motor.leverVectors.knee_ankle.knee,  'XData', [robot.joints.trajectories.knee(1), robot.joints.trajectories.knee(1) + 1000*robot.motors.leverVectors.knee_ankle.knee(1)]);
    set(gHandle.motor.leverVectors.knee_ankle.knee,  'YData', [robot.joints.trajectories.knee(2), robot.joints.trajectories.knee(2) + 1000*robot.motors.leverVectors.knee_ankle.knee(2)]); 
    set(gHandle.motor.leverVectors.knee_ankle.ankle,  'XData', [robot.joints.trajectories.ankle(1), robot.joints.trajectories.ankle(1) + 1000*robot.motors.leverVectors.knee_ankle.ankle(1)]);
    set(gHandle.motor.leverVectors.knee_ankle.ankle,  'YData', [robot.joints.trajectories.ankle(2), robot.joints.trajectories.ankle(2) + 1000*robot.motors.leverVectors.knee_ankle.ankle(2)]);
    % Unit vector
    set(gHandle.motor.forceVectors.knee_ankle,  'XData', [robot.motors.trajectories.knee_ankle.foot(1), robot.motors.trajectories.knee_ankle.foot(1) + 100*robot.motors.forceVectors.knee_ankle(1)]);
    set(gHandle.motor.forceVectors.knee_ankle,  'YData', [robot.motors.trajectories.knee_ankle.foot(2), robot.motors.trajectories.knee_ankle.foot(2) + 100*robot.motors.forceVectors.knee_ankle(2)]);
end;


end

