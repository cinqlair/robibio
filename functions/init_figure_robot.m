function [handle] = init_figure_robot()
    
    hold on;
    
    
%% Robot joints
    
    handle.joint.neck   = plot(0,0,'b.', 'MarkerSize',20);        
    handle.joint.hip    = plot(0,0,'b.', 'MarkerSize',20);    
    handle.joint.knee   = plot(0,0,'b.', 'MarkerSize',20);
    handle.joint.ankle  = plot(0,0,'b.', 'MarkerSize',20);    
    handle.joint.toes   = plot(0,0,'b.', 'MarkerSize',20);

    
%% Segments    
    handle.segment.trunk   = line ([0,0], [0,0], 'Color', 'r');
    handle.segment.thigh   = line ([0,0], [0,0], 'Color', 'r');
    handle.segment.shang   = line ([0,0], [0,0], 'Color', 'r');
    handle.segment.foot    = line ([0,0], [0,0], 'Color', 'r');


% %% Motors
% 
%     handle.motor.Left.Hip           = line ([0,0], [0,0], 'LineWidth', 5, 'Color', [1,0,0,0.2], 'Marker', '.');
%     handle.motor.Right.Hip          = line ([0,0], [0,0], 'LineWidth', 5, 'Color', [0,0,1,0.2], 'Marker', '.');
%     handle.motor.Left.Knee          = line ([0,0], [0,0], 'LineWidth', 5, 'Color', [1,0,0,0.2], 'Marker', '.');
%     handle.motor.Right.Knee         = line ([0,0], [0,0], 'LineWidth', 5, 'Color', [0,0,1,0.2], 'Marker', '.');
%     handle.motor.Left.Ankle         = line ([0,0], [0,0], 'LineWidth', 5, 'Color', [1,0,0,0.2], 'Marker', '.');
%     handle.motor.Right.Ankle        = line ([0,0], [0,0], 'LineWidth', 5, 'Color', [0,0,1,0.2], 'Marker', '.');
%     handle.motor.Left.Hip_Knee      = line ([0,0], [0,0], 'LineWidth', 5, 'Color', [1,0,0,0.2], 'Marker', '.');
%     handle.motor.Right.Hip_Knee     = line ([0,0], [0,0], 'LineWidth', 5, 'Color', [0,0,1,0.2], 'Marker', '.');
%     handle.motor.Left.Knee_Ankle    = line ([0,0], [0,0], 'LineWidth', 5, 'Color', [1,0,0,0.2], 'Marker', '.');
%     handle.motor.Right.Knee_Ankle   = line ([0,0], [0,0], 'LineWidth', 5, 'Color', [0,0,1,0.2], 'Marker', '.');
%     
% %% Torques   
% 
%     handle.torque.Left.Knee     = plot(0,0,'ro', 'MarkerSize',0.1);    
%     handle.torque.Right.Knee    = plot(0,0,'bo', 'MarkerSize',0.1);
%     handle.torque.Left.Ankle    = plot(0,0,'ro', 'MarkerSize',0.1);
%     handle.torque.Right.Ankle   = plot(0,0,'bo', 'MarkerSize',0.1);
%     handle.torque.Left.Foot     = plot(0,0,'ro', 'MarkerSize',0.1);
%     handle.torque.Right.Foot    = plot(0,0,'bo', 'MarkerSize',0.1);
    
    axis square equal;
    grid on;
    axis([-1000, 1000, -1000, 600]);
    set(gca,'XAxisLocation','bottom','YAxisLocation','left');
    xlabel ('X');
    ylabel ('Y');   
    
end

