function [gHandler] = plot_initial_configuration(x, motors)
    
    hold on; grid on;
    
    %% Draw body
    gHandler.joint.hip = plot (0,0,'k.', 'MarkerSize', 30); % Hip
    gHandler.joint.knee = plot (0,-380,'k.', 'MarkerSize', 30); % Knee
    gHandler.joint.ankle = plot (0,-738.5,'k.', 'MarkerSize', 30); % Ankle
    gHandler.joint.toes = plot (121,-792.5,'k.', 'MarkerSize', 30); % Toes
    
    gHandler.segment.trunk = line ([0,0],[0,500], 'Color', 'k','LineWidth', 5); % Trunk
    gHandler.segment.thigh = line ([0,0],[0,-380], 'Color', 'k','LineWidth', 5); % Thigh
    gHandler.segment.shang = line ([0,0],[-380,-738.5], 'Color', 'k','LineWidth', 5); % Shang
    gHandler.segment.foot = line ([0,121],[-738.5, -792.5], 'Color', 'k','LineWidth', 5); % Foot

    
    %% Motors    
    if (motors.enable.hip)
        gHandler.motor.hip = line ([x(1) x(3)],[x(2) x(4)-380], 'LineWidth', 3, 'Color', [1,0,0,0.5], 'Marker', '.', 'MarkerSize', 10);
    end
    
    if (motors.enable.knee)
        gHandler.motor.knee = line ([x(6) x(8)],[x(7)-380 x(9)-738.5], 'LineWidth', 2, 'Color', [0,1,0,0.5], 'Marker', '.', 'MarkerSize', 10);
    end
    
    if (motors.enable.ankle)
        gHandler.motor.ankle = line ([x(11) x(13)+121],[x(12)-738.5 x(14)-792.5], 'LineWidth', 2, 'Color', [0,0,1,0.5], 'Marker', '.', 'MarkerSize', 10);
    end
    
    if (motors.enable.hip_knee)
        gHandler.motor.hip_knee = line ([x(16) x(18)],[x(17) x(19)-738.5], 'LineWidth', 2, 'Color', [0,1,1,0.5], 'Marker', '.', 'MarkerSize', 10);
    end
    
    if (motors.enable.knee_ankle)
        gHandler.motor.knee_ankle = line ([x(21) x(23)+121],[x(22)-380 x(24)-792.5], 'LineWidth', 2, 'Color', [1,0,1,0.5], 'Marker', '.', 'MarkerSize', 10);
    end
    axis square equal;
end

