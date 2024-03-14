function [handle] = plot_initial_configuration(x, motors)
    
    hold on; grid on;
    
    %% Draw body
    plot (0,0,'k.', 'MarkerSize', 30); % Hip
    plot (0,-380,'k.', 'MarkerSize', 30); % Knee
    plot (0,-738.5,'k.', 'MarkerSize', 30); % Ankle
    plot (121,-792.5,'k.', 'MarkerSize', 30); % Toes
    
    line ([0,0],[0,500], 'Color', 'k','LineWidth', 5); % Trunk
    line ([0,0],[0,-380], 'Color', 'k','LineWidth', 5); % Thigh
    line ([0,0],[-380,-738.5], 'Color', 'k','LineWidth', 5); % Tibia
    line ([0,121],[-738.5, -792.5], 'Color', 'k','LineWidth', 5); % Foot

    
    %% Motors
    % Hip motor
    %line ([x(1) 0],[x(2) x(2)], 'LineWidth', 3, 'Color', 'k');
    %line ([x(3) 0],[x(4)-380 x(4)-380], 'LineWidth', 3, 'Color', 'k');
    
    if (motors.enable.hip)
        line ([x(1) x(3)],[x(2) x(4)-380], 'LineWidth', 3, 'Color', [1,0,0,0.5], 'Marker', '.', 'MarkerSize', 10);
    end
    
    if (motors.enable.knee)
        line ([x(6) x(8)],[x(7)-380 x(9)-738.5], 'LineWidth', 2, 'Color', [0,1,0,0.5], 'Marker', '.', 'MarkerSize', 10);
    end
    
    if (motors.enable.ankle)
        line ([x(11) x(13)+121],[x(12)-738.5 x(14)-792.5], 'LineWidth', 2, 'Color', [0,0,1,0.5], 'Marker', '.', 'MarkerSize', 10);
    end
    
    if (motors.enable.hip_knee)
        line ([x(16) x(18)],[x(17) x(19)-738.5], 'LineWidth', 2, 'Color', [0,1,1,0.5], 'Marker', '.', 'MarkerSize', 10);
    end
    
    if (motors.enable.knee_ankle)
        line ([x(21) x(23)+121],[x(22)-380 x(24)-792.5], 'LineWidth', 2, 'Color', [1,0,1,0.5], 'Marker', '.', 'MarkerSize', 10);
    end
    axis square equal;
end

