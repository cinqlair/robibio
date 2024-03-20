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
    if (motors.enable.hip)
        set(gHandle.motor.hip,  'XData', [motors.trajectories.hip.trunk(1),  motors.trajectories.hip.thigh(1)]);
        set(gHandle.motor.hip,  'YData', [motors.trajectories.hip.trunk(2), motors.trajectories.hip.thigh(2)]);
    end

    if (motors.enable.knee)
        set(gHandle.motor.knee, 'XData', [motors.trajectories.knee.thigh(1),  motors.trajectories.knee.shang(1)]);
        set(gHandle.motor.knee, 'YData', [motors.trajectories.knee.thigh(2),  motors.trajectories.knee.shang(2)]);
    end

    if (motors.enable.ankle)
        set(gHandle.motor.ankle, 'XData', [motors.trajectories.ankle.shang(1), motors.trajectories.ankle.foot(1)]);
        set(gHandle.motor.ankle, 'YData', [motors.trajectories.ankle.shang(2), motors.trajectories.ankle.foot(2)]);
    end
    
    if (motors.enable.hip_knee)
        set(gHandle.motor.hip_knee, 'XData', [motors.trajectories.hip_knee.trunk(1),  motors.trajectories.hip_knee.shang(1)]);
        set(gHandle.motor.hip_knee, 'YData', [motors.trajectories.hip_knee.trunk(2), motors.trajectories.hip_knee.shang(2)]);
    end;
    
    if (motors.enable.knee_ankle)
        set(gHandle.motor.knee_ankle, 'XData', [motors.trajectories.knee_ankle.thigh(1),  motors.trajectories.knee_ankle.foot(1)]);
        set(gHandle.motor.knee_ankle, 'YData', [motors.trajectories.knee_ankle.thigh(2), motors.trajectories.knee_ankle.foot(2)]);
    end;

%     humod_time = dataset.timestamp(motors.humod_step(index));    
%     
end

