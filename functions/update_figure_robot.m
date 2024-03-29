function [humod_time, robibio_index] = update_figure_robot(gHandle, trajectories, motors)


%    robibio_index = motors.humod_step(index);

%% Update joints
set(gHandle.joint.neck,    'XData', trajectories.neck(1),   'YData', trajectories.neck(2));
set(gHandle.joint.knee,    'XData', trajectories.knee(1),   'YData', trajectories.knee(2));
set(gHandle.joint.ankle,   'XData',  trajectories.ankle(1),   'YData', trajectories.ankle(2));
set(gHandle.joint.toes,   'XData',  trajectories.toes(1),   'YData', trajectories.toes(2));


%% Update segments
set(gHandle.segment.trunk,   'XData', [0, trajectories.neck(1)],   'YData', [0, trajectories.neck(2)]);
set(gHandle.segment.thigh,   'XData', [0, trajectories.knee(1)],   'YData', [0, trajectories.knee(2)]);
set(gHandle.segment.shang,   'XData', [trajectories.knee(1), trajectories.ankle(1)],   'YData', [trajectories.knee(2), trajectories.ankle(2)]);
set(gHandle.segment.foot,    'XData', [trajectories.ankle(1), trajectories.toes(1)],   'YData', [trajectories.ankle(2), trajectories.toes(2)]);




%% Update torques
%     set(gHandle.torque.Left.Knee,    'XData', dataset.trajectories.x(1,robibio_index),   'YData', dataset.trajectories.y(1,robibio_index),  'MarkerSize', abs(dataset.torques.q(1,robibio_index)));
%     set(gHandle.torque.Right.Knee,   'XData', dataset.trajectories.x(2,robibio_index),   'YData', dataset.trajectories.y(2,robibio_index),  'MarkerSize', abs(dataset.torques.q(2,robibio_index)));
%     set(gHandle.torque.Left.Ankle,   'XData', dataset.trajectories.x(3,robibio_index),   'YData', dataset.trajectories.y(3,robibio_index),  'MarkerSize', abs(dataset.torques.q(3,robibio_index)));
%     set(gHandle.torque.Right.Ankle,  'XData', dataset.trajectories.x(4,robibio_index),   'YData', dataset.trajectories.y(4,robibio_index),  'MarkerSize', abs(dataset.torques.q(4,robibio_index)));
%     set(gHandle.torque.Left.Foot,    'XData', dataset.trajectories.x(5,robibio_index),   'YData', dataset.trajectories.y(5,robibio_index),  'MarkerSize', abs(dataset.torques.q(5,robibio_index)));
%     set(gHandle.torque.Right.Foot,   'XData', dataset.trajectories.x(6,robibio_index),   'YData', dataset.trajectories.y(6,robibio_index),  'MarkerSize', abs(dataset.torques.q(6,robibio_index)));



%% Update motors
%% Hip
if (motors.enable.hip)
    % Motor
    set(gHandle.motor.hip,  'XData', [motors.trajectories.hip.trunk(1),  motors.trajectories.hip.thigh(1)]);
    set(gHandle.motor.hip,  'YData', [motors.trajectories.hip.trunk(2), motors.trajectories.hip.thigh(2)]);
    % Unit vector
    set(gHandle.motor.unitVectors.hip,  'XData', [motors.trajectories.hip.thigh(1), motors.trajectories.hip.thigh(1) + 100*motors.unitVectors.hip(1)]);
    set(gHandle.motor.unitVectors.hip,  'YData', [motors.trajectories.hip.thigh(2), motors.trajectories.hip.thigh(2) + 100*motors.unitVectors.hip(2)]);
    % Lever vector
    set(gHandle.motor.leverVectors.hip,  'XData', [trajectories.hip(1), trajectories.hip(1) + 1000*motors.leverVectors.hip(1)]);
    set(gHandle.motor.leverVectors.hip,  'YData', [trajectories.hip(2), trajectories.hip(2) + 1000*motors.leverVectors.hip(2)]);    
    % Force vector
    set(gHandle.motor.forceVectors.hip,  'XData', [motors.trajectories.hip.thigh(1), motors.trajectories.hip.thigh(1) + 10*motors.forceVectors.hip(1)]);
    set(gHandle.motor.forceVectors.hip,  'YData', [motors.trajectories.hip.thigh(2), motors.trajectories.hip.thigh(2) + 10*motors.forceVectors.hip(2)]);
end

%% Knee
if (motors.enable.knee)
    % Motor
    set(gHandle.motor.knee, 'XData', [motors.trajectories.knee.thigh(1),  motors.trajectories.knee.shang(1)]);
    set(gHandle.motor.knee, 'YData', [motors.trajectories.knee.thigh(2),  motors.trajectories.knee.shang(2)]);
    % Unit vector
    set(gHandle.motor.unitVectors.knee,  'XData', [motors.trajectories.knee.shang(1), motors.trajectories.knee.shang(1) + 100*motors.unitVectors.knee(1)]);
    set(gHandle.motor.unitVectors.knee,  'YData', [motors.trajectories.knee.shang(2), motors.trajectories.knee.shang(2) + 100*motors.unitVectors.knee(2)]);
    % Lever vector
    set(gHandle.motor.leverVectors.knee,  'XData', [trajectories.knee(1), trajectories.knee(1) + 1000*motors.leverVectors.knee(1)]);
    set(gHandle.motor.leverVectors.knee,  'YData', [trajectories.knee(2), trajectories.knee(2) + 1000*motors.leverVectors.knee(2)]); 
    % Force vector
    set(gHandle.motor.forceVectors.knee,  'XData', [motors.trajectories.knee.shang(1), motors.trajectories.knee.shang(1) + 10*motors.forceVectors.knee(1)]);
    set(gHandle.motor.forceVectors.knee,  'YData', [motors.trajectories.knee.shang(2), motors.trajectories.knee.shang(2) + 10*motors.forceVectors.knee(2)]);
end

%% Ankle
if (motors.enable.ankle)
    % Motor
    set(gHandle.motor.ankle, 'XData', [motors.trajectories.ankle.shang(1), motors.trajectories.ankle.foot(1)]);
    set(gHandle.motor.ankle, 'YData', [motors.trajectories.ankle.shang(2), motors.trajectories.ankle.foot(2)]);
    % Unit vector
    set(gHandle.motor.unitVectors.ankle,  'XData', [motors.trajectories.ankle.foot(1), motors.trajectories.ankle.foot(1) + 100*motors.unitVectors.ankle(1)]);
    set(gHandle.motor.unitVectors.ankle,  'YData', [motors.trajectories.ankle.foot(2), motors.trajectories.ankle.foot(2) + 100*motors.unitVectors.ankle(2)]);
    % Lever vector
    set(gHandle.motor.leverVectors.ankle,  'XData', [trajectories.ankle(1), trajectories.ankle(1) + 1000*motors.leverVectors.ankle(1)]);
    set(gHandle.motor.leverVectors.ankle,  'YData', [trajectories.ankle(2), trajectories.ankle(2) + 1000*motors.leverVectors.ankle(2)]); 
    % Force vector
    set(gHandle.motor.forceVectors.ankle,  'XData', [motors.trajectories.ankle.foot(1), motors.trajectories.ankle.foot(1) + 10*motors.forceVectors.ankle(1)]);
    set(gHandle.motor.forceVectors.ankle,  'YData', [motors.trajectories.ankle.foot(2), motors.trajectories.ankle.foot(2) + 10*motors.forceVectors.ankle(2)]);    
end

%% Hip-Knee
if (motors.enable.hip_knee)
    % Motor
    set(gHandle.motor.hip_knee, 'XData', [motors.trajectories.hip_knee.trunk(1),  motors.trajectories.hip_knee.shang(1)]);
    set(gHandle.motor.hip_knee, 'YData', [motors.trajectories.hip_knee.trunk(2), motors.trajectories.hip_knee.shang(2)]);
    % Unit vector
    set(gHandle.motor.unitVectors.hip_knee,  'XData', [motors.trajectories.hip_knee.shang(1), motors.trajectories.hip_knee.shang(1) + 100*motors.unitVectors.hip_knee(1)]);
    set(gHandle.motor.unitVectors.hip_knee,  'YData', [motors.trajectories.hip_knee.shang(2), motors.trajectories.hip_knee.shang(2) + 100*motors.unitVectors.hip_knee(2)]);
    % Lever vector
    set(gHandle.motor.leverVectors.hip_knee.hip,  'XData', [trajectories.hip(1), trajectories.hip(1) + 1000*motors.leverVectors.hip_knee.hip(1)]);
    set(gHandle.motor.leverVectors.hip_knee.hip,  'YData', [trajectories.hip(2), trajectories.hip(2) + 1000*motors.leverVectors.hip_knee.hip(2)]); 
    set(gHandle.motor.leverVectors.hip_knee.knee,  'XData', [trajectories.knee(1), trajectories.knee(1) + 1000*motors.leverVectors.hip_knee.knee(1)]);
    set(gHandle.motor.leverVectors.hip_knee.knee,  'YData', [trajectories.knee(2), trajectories.knee(2) + 1000*motors.leverVectors.hip_knee.knee(2)]); 
    % Forcevector
    set(gHandle.motor.forceVectors.hip_knee,  'XData', [motors.trajectories.hip_knee.shang(1), motors.trajectories.hip_knee.shang(1) + 100*motors.forceVectors.hip_knee(1)]);
    set(gHandle.motor.forceVectors.hip_knee,  'YData', [motors.trajectories.hip_knee.shang(2), motors.trajectories.hip_knee.shang(2) + 100*motors.forceVectors.hip_knee(2)]);
end;


%% Knee-Ankle
if (motors.enable.knee_ankle)
    % Motor
    set(gHandle.motor.knee_ankle, 'XData', [motors.trajectories.knee_ankle.thigh(1),  motors.trajectories.knee_ankle.foot(1)]);
    set(gHandle.motor.knee_ankle, 'YData', [motors.trajectories.knee_ankle.thigh(2), motors.trajectories.knee_ankle.foot(2)]);
    % Unit vector
    set(gHandle.motor.unitVectors.knee_ankle,  'XData', [motors.trajectories.knee_ankle.foot(1), motors.trajectories.knee_ankle.foot(1) + 100*motors.unitVectors.knee_ankle(1)]);
    set(gHandle.motor.unitVectors.knee_ankle,  'YData', [motors.trajectories.knee_ankle.foot(2), motors.trajectories.knee_ankle.foot(2) + 100*motors.unitVectors.knee_ankle(2)]);
    % Lever vector
    set(gHandle.motor.leverVectors.knee_ankle.knee,  'XData', [trajectories.knee(1), trajectories.knee(1) + 1000*motors.leverVectors.knee_ankle.knee(1)]);
    set(gHandle.motor.leverVectors.knee_ankle.knee,  'YData', [trajectories.knee(2), trajectories.knee(2) + 1000*motors.leverVectors.knee_ankle.knee(2)]); 
    set(gHandle.motor.leverVectors.knee_ankle.ankle,  'XData', [trajectories.ankle(1), trajectories.ankle(1) + 1000*motors.leverVectors.knee_ankle.ankle(1)]);
    set(gHandle.motor.leverVectors.knee_ankle.ankle,  'YData', [trajectories.ankle(2), trajectories.ankle(2) + 1000*motors.leverVectors.knee_ankle.ankle(2)]);
    % Unit vector
    set(gHandle.motor.forceVectors.knee_ankle,  'XData', [motors.trajectories.knee_ankle.foot(1), motors.trajectories.knee_ankle.foot(1) + 100*motors.forceVectors.knee_ankle(1)]);
    set(gHandle.motor.forceVectors.knee_ankle,  'YData', [motors.trajectories.knee_ankle.foot(2), motors.trajectories.knee_ankle.foot(2) + 100*motors.forceVectors.knee_ankle(2)]);
end;

%     humod_time = dataset.timestamp(motors.humod_step(index));
%
end

