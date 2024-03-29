function [gHandler] = update_initial_configuration(gHandler, x, motors)
    
    hold on; grid on;
    
    %% Draw body
%     gHandler.joint.hip = plot (0,0,'k.', 'MarkerSize', 30); % Hip
%     gHandler.joint.knee = plot (0,-380,'k.', 'MarkerSize', 30); % Knee
%     gHandler.joint.ankle = plot (0,-738.5,'k.', 'MarkerSize', 30); % Ankle
%     gHandler.joint.toes = plot (121,-792.5,'k.', 'MarkerSize', 30); % Toes
%     
%     gHandler.segment.trunk = line ([0,0],[0,500], 'Color', 'k','LineWidth', 5); % Trunk
%     gHandler.segment.thigh = line ([0,0],[0,-380], 'Color', 'k','LineWidth', 5); % Thigh
%     gHandler.segment.shang = line ([0,0],[-380,-738.5], 'Color', 'k','LineWidth', 5); % Shang
%     gHandler.segment.foot = line ([0,121],[-738.5, -792.5], 'Color', 'k','LineWidth', 5); % Foot

    
    %% Motors    
    if (motors.enable.hip)
        set(gHandler.motor.hip,  'XData', [x(1), x(3)]);
        set(gHandler.motor.hip,  'YData', [x(2), x(4)-380]);
        
        %gHandler.motor.hip = line ([x(1) x(3)],[x(2) x(4)-380], 'LineWidth', 3, 'Color', [1,0,0,0.5], 'Marker', '.', 'MarkerSize', 10);
    end
    
    if (motors.enable.knee)
        set(gHandler.motor.knee, 'XData', [x(6),  x(8)]);
        set(gHandler.motor.knee, 'YData', [x(7)-380,  x(9)-738.5]);
    
        %gHandler.motor.knee = line ([x(6) x(8)],[x(7)-380 x(9)-738.5], 'LineWidth', 2, 'Color', [0,1,0,0.5], 'Marker', '.', 'MarkerSize', 10);
    end
    
    if (motors.enable.ankle)
        set(gHandler.motor.ankle, 'XData', [x(11), x(13)+121]);
        set(gHandler.motor.ankle, 'YData', [x(12)-738.5 x(14)-792.5]);
        %gHandler.motor.ankle = line ([x(11) x(13)+121],[x(12)-738.5 x(14)-792.5], 'LineWidth', 2, 'Color', [0,0,1,0.5], 'Marker', '.', 'MarkerSize', 10);
    end
    
    if (motors.enable.hip_knee)
        set(gHandler.motor.hip_knee, 'XData', [x(16) x(18)]);
        set(gHandler.motor.hip_knee, 'YData', [x(17) x(19)-738.5]);
        %gHandler.motor.hip_knee = line ([x(16) x(18)],[x(17) x(19)-738.5], 'LineWidth', 2, 'Color', [0,1,1,0.5], 'Marker', '.', 'MarkerSize', 10);
    end
    
    if (motors.enable.knee_ankle)
        set(gHandler.motor.knee_ankle, 'XData', [x(21) x(23)+121]);
        set(gHandler.motor.knee_ankle, 'YData', [x(22)-380 x(24)-792.5]);
        %gHandler.motor.knee_ankle = line ([x(21) x(23)+121],[x(22)-380 x(24)-792.5], 'LineWidth', 2, 'Color', [1,0,1,0.5], 'Marker', '.', 'MarkerSize', 10);
    end

end

