function [handle] = init_figure_robot()


    %% All elements are on the same figure
    hold on;


    %% Robot joints

    handle.joint.neck   = plot(0,0,'k.', 'MarkerSize',20);
    handle.joint.hip    = plot(0,0,'k.', 'MarkerSize',20);
    handle.joint.knee   = plot(0,0,'k.', 'MarkerSize',20);
    handle.joint.ankle  = plot(0,0,'k.', 'MarkerSize',20);
    handle.joint.toes   = plot(0,0,'k.', 'MarkerSize',20);


    %% Segments
    handle.segment.trunk   = line ([0,0], [0,0], 'LineWidth', 3, 'Color', 'k');
    handle.segment.thigh   = line ([0,0], [0,0], 'LineWidth', 3, 'Color', 'k');
    handle.segment.shang   = line ([0,0], [0,0], 'LineWidth', 3, 'Color', 'k');
    handle.segment.foot    = line ([0,0], [0,0], 'LineWidth', 3, 'Color', 'k');

    %% Motor joints
    handle.motor.joint.hip   = plot(0,0,'o', 'MarkerSize',10, 'Color', [1,0,0,0.1]);
    handle.motor.joint.knee    = plot(0,0,'o', 'MarkerSize',10, 'Color', [0,1,0,0.1]);
    handle.motor.joint.ankle   = plot(0,0,'o', 'MarkerSize',10, 'Color', [0,0,1,0.1]);
    handle.motor.joint.hip_knee  = plot(0,0,'o', 'MarkerSize',10, 'Color', [0,1,1,0.1]);
    handle.motor.joint.knee_ankle   = plot(0,0,'o', 'MarkerSize',10, 'Color', [1,0.5,0,0.1]);

    %% Motors
    handle.motor.hip           = line ([0,0], [0,0], 'LineWidth', 1, 'Color', [1,0,0,0.1], 'Marker', 'o');
    handle.motor.knee          = line ([0,0], [0,0], 'LineWidth', 1, 'Color', [0,1,0,0.1], 'Marker', 'o');
    handle.motor.ankle         = line ([0,0], [0,0], 'LineWidth', 1, 'Color', [0,0,1,0.1], 'Marker', 'o');
    handle.motor.hip_knee      = line ([0,0], [0,0], 'LineWidth', 1, 'Color', [0,1,1,0.1], 'Marker', 'o');
    handle.motor.knee_ankle    = line ([0,0], [0,0], 'LineWidth', 1, 'Color', [1,0.5,0,0.1], 'Marker', 'o');

    %% Unit vectors
    handle.motor.unitVectors.hip        = line ([0,0], [0,0], 'LineWidth', 1, 'Color', [0,0,0,0.2], 'Marker', '.');
    handle.motor.unitVectors.knee       = line ([0,0], [0,0], 'LineWidth', 1, 'Color', [0,0,0,0.2], 'Marker', '.');
    handle.motor.unitVectors.ankle      = line ([0,0], [0,0], 'LineWidth', 1, 'Color', [0,0,0,0.2], 'Marker', '.');
    handle.motor.unitVectors.hip_knee   = line ([0,0], [0,0], 'LineWidth', 1, 'Color', [0,0,0,0.2], 'Marker', '.');
    handle.motor.unitVectors.knee_ankle = line ([0,0], [0,0], 'LineWidth', 1, 'Color', [0,0,0,0.2], 'Marker', '.');
    
    %% Force vectors
    handle.motor.forceVectors.hip        = line ([0,0], [0,0], 'LineWidth', 3, 'Color', [0,0,0,0.4], 'Marker', '.');
    handle.motor.forceVectors.knee       = line ([0,0], [0,0], 'LineWidth', 3, 'Color', [0,0,0,0.4], 'Marker', '.');
    handle.motor.forceVectors.ankle      = line ([0,0], [0,0], 'LineWidth', 3, 'Color', [0,0,0,0.4], 'Marker', '.');
    handle.motor.forceVectors.hip_knee   = line ([0,0], [0,0], 'LineWidth', 3, 'Color', [0,0,0,0.4], 'Marker', '.');
    handle.motor.forceVectors.knee_ankle = line ([0,0], [0,0], 'LineWidth', 3, 'Color', [0,0,0,0.4], 'Marker', '.');
    
    %% Lever vectors
    handle.motor.leverVectors.hip        = line ([0,0], [0,0], 'LineWidth', 1, 'Color', [1,0,0,1], 'Marker', '.');
    handle.motor.leverVectors.knee       = line ([0,0], [0,0], 'LineWidth', 1, 'Color', [0,1,0,1], 'Marker', '.');
    handle.motor.leverVectors.ankle      = line ([0,0], [0,0], 'LineWidth', 1, 'Color', [0,0,1,1], 'Marker', '.');
    handle.motor.leverVectors.hip_knee.hip   = line ([0,0], [0,0], 'LineWidth', 1, 'Color', [0,1,1,1], 'Marker', '.');
    handle.motor.leverVectors.hip_knee.knee  = line ([0,0], [0,0], 'LineWidth', 3, 'Color', [0,1,1,1], 'Marker', '.');
    handle.motor.leverVectors.knee_ankle.knee = line ([0,0], [0,0], 'LineWidth', 1, 'Color', [1,0.5,0,1], 'Marker', '.');
    handle.motor.leverVectors.knee_ankle.ankle  = line ([0,0], [0,0], 'LineWidth', 3, 'Color', [1,0.5,0,1], 'Marker', '.');
    
    %% Sliders end
    handle.motor.slidersEnd.hip           = line ([0,0], [0,0], 'LineWidth', 3, 'Color', [0.1,0.1,0.1,0.3], 'Marker', '.');
    handle.motor.slidersEnd.knee          = line ([0,0], [0,0], 'LineWidth', 3, 'Color', [0.1,0.1,0.1,0.3], 'Marker', '.');
    handle.motor.slidersEnd.ankle         = line ([0,0], [0,0], 'LineWidth', 3, 'Color', [0.1,0.1,0.1,0.3], 'Marker', '.');
    handle.motor.slidersEnd.hip_knee      = line ([0,0], [0,0], 'LineWidth', 3, 'Color', [0.1,0.1,0.1,0.3], 'Marker', '.');
    handle.motor.slidersEnd.knee_ankle    = line ([0,0], [0,0], 'LineWidth', 3, 'Color', [0.1,0.1,0.1,0.3], 'Marker', '.');
    
    %% Stators end
    handle.motor.statorsEnd.hip           = line ([0,0], [0,0], 'LineWidth', 15, 'Color', [0.1,0.1,0.1,0.1], 'Marker', '.');
    handle.motor.statorsEnd.knee          = line ([0,0], [0,0], 'LineWidth', 15, 'Color', [0.1,0.1,0.1,0.1], 'Marker', '.');
    handle.motor.statorsEnd.ankle         = line ([0,0], [0,0], 'LineWidth', 15, 'Color', [0.1,0.1,0.1,0.1], 'Marker', '.');
    handle.motor.statorsEnd.hip_knee      = line ([0,0], [0,0], 'LineWidth', 15, 'Color', [0.1,0.1,0.1,0.1], 'Marker', '.');
    handle.motor.statorsEnd.knee_ankle    = line ([0,0], [0,0], 'LineWidth', 15, 'Color', [0.1,0.1,0.1,0.1], 'Marker', '.');
    
    % %% Torques    
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

