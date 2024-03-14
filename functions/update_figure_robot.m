function [humod_time, robibio_index] = update_figure_robot(gHandle, dataset, motors, index)


    robibio_index = motors.humod_step(index);

    %% Update joints
    set(gHandle.joint.Left.Knee,    'XData', dataset.trajectories.x(3,robibio_index),   'YData', dataset.trajectories.y(3,robibio_index));
    set(gHandle.joint.Right.Knee,   'XData', dataset.trajectories.x(4,robibio_index),   'YData', dataset.trajectories.y(4,robibio_index));
    set(gHandle.joint.Left.Ankle,   'XData', dataset.trajectories.x(5,robibio_index),   'YData', dataset.trajectories.y(5,robibio_index));
    set(gHandle.joint.Right.Ankle,  'XData', dataset.trajectories.x(6,robibio_index),   'YData', dataset.trajectories.y(6,robibio_index));
    set(gHandle.joint.Left.Foot,    'XData', dataset.trajectories.x(7,robibio_index),   'YData', dataset.trajectories.y(7,robibio_index));
    set(gHandle.joint.Right.Foot,   'XData', dataset.trajectories.x(8,robibio_index),   'YData', dataset.trajectories.y(8,robibio_index));
    
    %% Update segments
    set(gHandle.segment.Left.Thigh,   'XData', [0, dataset.trajectories.x(3,robibio_index)],   'YData', [0, dataset.trajectories.y(3,robibio_index)]);
    set(gHandle.segment.Right.Thigh,  'XData', [0, dataset.trajectories.x(4,robibio_index)],   'YData', [0, dataset.trajectories.y(4,robibio_index)]);
    set(gHandle.segment.Left.Shang,   'XData', [dataset.trajectories.x(3,robibio_index), dataset.trajectories.x(5,robibio_index)],   'YData', [dataset.trajectories.y(3,robibio_index), dataset.trajectories.y(5,robibio_index)]);
    set(gHandle.segment.Right.Shang,  'XData', [dataset.trajectories.x(4,robibio_index), dataset.trajectories.x(6,robibio_index)],   'YData', [dataset.trajectories.y(4,robibio_index), dataset.trajectories.y(6,robibio_index)]);
    set(gHandle.segment.Left.Foot,    'XData', [dataset.trajectories.x(5,robibio_index), dataset.trajectories.x(7,robibio_index)],   'YData', [dataset.trajectories.y(5,robibio_index), dataset.trajectories.y(7,robibio_index)]);
    set(gHandle.segment.Right.Foot,   'XData', [dataset.trajectories.x(6,robibio_index), dataset.trajectories.x(8,robibio_index)],   'YData', [dataset.trajectories.y(6,robibio_index), dataset.trajectories.y(8,robibio_index)]);
    
    %% Update torques
    set(gHandle.torque.Left.Knee,    'XData', dataset.trajectories.x(1,robibio_index),   'YData', dataset.trajectories.y(1,robibio_index),  'MarkerSize', abs(dataset.torques.q(1,robibio_index)));
    set(gHandle.torque.Right.Knee,   'XData', dataset.trajectories.x(2,robibio_index),   'YData', dataset.trajectories.y(2,robibio_index),  'MarkerSize', abs(dataset.torques.q(2,robibio_index)));
    set(gHandle.torque.Left.Ankle,   'XData', dataset.trajectories.x(3,robibio_index),   'YData', dataset.trajectories.y(3,robibio_index),  'MarkerSize', abs(dataset.torques.q(3,robibio_index)));
    set(gHandle.torque.Right.Ankle,  'XData', dataset.trajectories.x(4,robibio_index),   'YData', dataset.trajectories.y(4,robibio_index),  'MarkerSize', abs(dataset.torques.q(4,robibio_index)));
    set(gHandle.torque.Left.Foot,    'XData', dataset.trajectories.x(5,robibio_index),   'YData', dataset.trajectories.y(5,robibio_index),  'MarkerSize', abs(dataset.torques.q(5,robibio_index)));
    set(gHandle.torque.Right.Foot,   'XData', dataset.trajectories.x(6,robibio_index),   'YData', dataset.trajectories.y(6,robibio_index),  'MarkerSize', abs(dataset.torques.q(6,robibio_index)));
    
    
    
    %% Update motors
    if (motors.enable.hip)
        set(gHandle.motor.Left.Hip,           'XData', [motors.trajectories.hip.left.trunk(1,index),  motors.trajectories.hip.left.thigh(1,index)]);
        set(gHandle.motor.Left.Hip,           'YData', [motors.trajectories.hip.left.trunk(2,index),  motors.trajectories.hip.left.thigh(2,index)]);
        set(gHandle.motor.Right.Hip,          'XData', [motors.trajectories.hip.right.trunk(1,index), motors.trajectories.hip.right.thigh(1,index)]);
        set(gHandle.motor.Right.Hip,          'YData', [motors.trajectories.hip.right.trunk(2,index), motors.trajectories.hip.right.thigh(2,index)]);
    end;

    if (motors.enable.knee)
        set(gHandle.motor.Left.Knee,          'XData', [motors.trajectories.knee.left.thigh(1,index),  motors.trajectories.knee.left.shang(1,index)]);
        set(gHandle.motor.Left.Knee,          'YData', [motors.trajectories.knee.left.thigh(2,index),  motors.trajectories.knee.left.shang(2,index)]);
        set(gHandle.motor.Right.Knee,         'XData', [motors.trajectories.knee.right.thigh(1,index), motors.trajectories.knee.right.shang(1,index)]);
        set(gHandle.motor.Right.Knee,         'YData', [motors.trajectories.knee.right.thigh(2,index), motors.trajectories.knee.right.shang(2,index)]);
    end;

    if (motors.enable.ankle)
        set(gHandle.motor.Left.Ankle,         'XData', [motors.trajectories.ankle.left.shang(1,index),  motors.trajectories.ankle.left.foot(1,index)]);
        set(gHandle.motor.Left.Ankle,         'YData', [motors.trajectories.ankle.left.shang(2,index),  motors.trajectories.ankle.left.foot(2,index)]);
        set(gHandle.motor.Right.Ankle,        'XData', [motors.trajectories.ankle.right.shang(1,index), motors.trajectories.ankle.right.foot(1,index)]);
        set(gHandle.motor.Right.Ankle,        'YData', [motors.trajectories.ankle.right.shang(2,index), motors.trajectories.ankle.right.foot(2,index)]);
    end
    
    if (motors.enable.hip_knee)
        set(gHandle.motor.Left.Hip_Knee,      'XData', [motors.trajectories.hip_knee.left.trunk(1,index),  motors.trajectories.hip_knee.left.shang(1,index)]);
        set(gHandle.motor.Left.Hip_Knee,      'YData', [motors.trajectories.hip_knee.left.trunk(2,index),  motors.trajectories.hip_knee.left.shang(2,index)]);
        set(gHandle.motor.Right.Hip_Knee,     'XData', [motors.trajectories.hip_knee.right.trunk(1,index), motors.trajectories.hip_knee.right.shang(1,index)]);
        set(gHandle.motor.Right.Hip_Knee,     'YData', [motors.trajectories.hip_knee.right.trunk(2,index), motors.trajectories.hip_knee.right.shang(2,index)]);
    end;
    
    if (motors.enable.knee_ankle)
        set(gHandle.motor.Left.Knee_Ankle,    'XData', [motors.trajectories.knee_ankle.left.thigh(1,index),  motors.trajectories.knee_ankle.left.foot(1,index)]);
        set(gHandle.motor.Left.Knee_Ankle,    'YData', [motors.trajectories.knee_ankle.left.thigh(2,index),  motors.trajectories.knee_ankle.left.foot(2,index)]);
        set(gHandle.motor.Right.Knee_Ankle,   'XData', [motors.trajectories.knee_ankle.right.thigh(1,index), motors.trajectories.knee_ankle.right.foot(1,index)]);
        set(gHandle.motor.Right.Knee_Ankle,   'YData', [motors.trajectories.knee_ankle.right.thigh(2,index), motors.trajectories.knee_ankle.right.foot(2,index)]);
    end;

    humod_time = dataset.timestamp(motors.humod_step(index));    
    
end

