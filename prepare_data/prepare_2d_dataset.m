clc;
close all;
clear all;

tic

%% Path for Matlab functions
addpath ('../functions')



%% Load dataset
% dataGrimmer contains the data (1000 sample per motion)
% dataGrimmer.{hip|knee|ankle}.{angleDeg|torque|theta|angle}
% N is the number of samples
motionNames = [ "Walking_11"];
[dataGrimmer, N] = loadGrimmerData('../', motionNames);
dataGrimmer

plot (dataGrimmer.hip.angleDeg);
hold on 
plot (10*dataGrimmer.hip.torque);




%% Extract position for each joint (From Humod)
Position_3D.UpperLumbar_Humod  = [data.motion.jointX.smoothed(6,:);    data.motion.jointY.smoothed(6,:);  data.motion.jointZ.smoothed(6,:)];
Position_3D.LowerLumbar_Humod  = [data.motion.jointX.smoothed(7,:);    data.motion.jointY.smoothed(7,:);  data.motion.jointZ.smoothed(7,:)];
Position_3D.Hip_Left_Humod     = [data.motion.jointX.smoothed(8,:);    data.motion.jointY.smoothed(8,:);  data.motion.jointZ.smoothed(8,:)];
Position_3D.Hip_Right_Humod    = [data.motion.jointX.smoothed(9,:);    data.motion.jointY.smoothed(9,:);  data.motion.jointZ.smoothed(9,:)];
Position_3D.Knee_Left_Humod    = [data.motion.jointX.smoothed(10,:);   data.motion.jointY.smoothed(10,:); data.motion.jointZ.smoothed(10,:)];
Position_3D.Knee_Right_Humod   = [data.motion.jointX.smoothed(11,:);   data.motion.jointY.smoothed(11,:); data.motion.jointZ.smoothed(11,:)];
Position_3D.Ankle_Left_Humod   = [data.motion.jointX.smoothed(12,:);   data.motion.jointY.smoothed(12,:); data.motion.jointZ.smoothed(12,:)];
Position_3D.Ankle_Right_Humod  = [data.motion.jointX.smoothed(13,:);   data.motion.jointY.smoothed(13,:); data.motion.jointZ.smoothed(13,:)];


%% Initialize figure
figure; set(gcf,'Position',[300 100 1200 562]);
subplot (1,2,1);

%% 3D model
hold on;

h3d.UpperLumbar_Humod = plot3(0,0,0,'k.', 'MarkerSize',20);
h3d.LowerLumbar_Humod = plot3(0,0,0,'k.', 'MarkerSize',20);
h3d.Hip_Left_Humod    = plot3(0,0,0,'b.', 'MarkerSize',20);
h3d.Hip_Right_Humod   = plot3(0,0,0,'b.', 'MarkerSize',20);
h3d.Knee_Left_Humod   = plot3(0,0,0,'r.', 'MarkerSize',20);
h3d.Knee_Right_Humod  = plot3(0,0,0,'r.', 'MarkerSize',20);
h3d.Ankle_Left_Humod  = plot3(0,0,0,'g.', 'MarkerSize',20);
h3d.Ankle_Right_Humod= plot3(0,0,0,'g.', 'MarkerSize',20);

h3d.UpperLumbar   = plot3(0,0,0,'ko', 'MarkerSize',10);
h3d.LowerLumbar   = plot3(0,0,0,'ko', 'MarkerSize',10);
h3d.Hip_Left      = plot3(0,0,0,'bo', 'MarkerSize',10);
h3d.Hip_Right     = plot3(0,0,0,'bo', 'MarkerSize',10);
h3d.Knee_Left     = plot3(0,0,0,'ro', 'MarkerSize',10);
h3d.Knee_Right    = plot3(0,0,0,'ro', 'MarkerSize',10);
h3d.Ankle_Left    = plot3(0,0,0,'go', 'MarkerSize',10);
h3d.Ankle_Right   = plot3(0,0,0,'go', 'MarkerSize',10);
h3d.Foot_Left     = plot3(0,0,0,'mo', 'MarkerSize',10);
h3d.Foot_Right    = plot3(0,0,0,'mo', 'MarkerSize',10);

% Perspective
view(25,25);
%% Left view
%view(0,0);
%% Front view
%view(90,0)
%% Top view
%view(0,90)

axis square equal;
grid on;
axis([-1000, 1000, -600, 600, -100, 1200]);
rotate3d;
set(gca,'XAxisLocation','bottom','YAxisLocation','left', 'ydir', 'reverse');
xlabel ('X');
ylabel ('Z');
zlabel ('Y');


%% 2D model
subplot (1,2,2); hold on;
h2d.Hip           = plot3(0,0,0,'bo', 'MarkerSize',5);
h2d.Knee_Left     = plot3(0,0,0,'ro', 'MarkerSize',5);
h2d.Knee_Right    = plot3(0,0,0,'r.', 'MarkerSize',20);
h2d.Ankle_Left    = plot3(0,0,0,'go', 'MarkerSize',5);
h2d.Ankle_Right   = plot3(0,0,0,'g.', 'MarkerSize',20);
h2d.Foot_Left     = plot3(0,0,0,'mo', 'MarkerSize',5);
h2d.Foot_Right    = plot3(0,0,0,'m.', 'MarkerSize',20);

axis square equal;
grid on;
axis([-1000, 1000, -1200, 400]);
set(gca,'XAxisLocation','top','YAxisLocation','left');
xlabel ('X');
ylabel ('Y');


%% The dataset containing the output ROBIBIO data
dataset=[];



%% Main Loop
index = 1;
for step = 1+start_time*frame_rate : 1 : end_time*frame_rate
    
       
    
    %% Display Humod joint positions
    set(h3d.UpperLumbar_Humod,    'XData', Position_3D.UpperLumbar_Humod(1,step),    'YData', Position_3D.UpperLumbar_Humod(3,step),    'ZData', Position_3D.UpperLumbar_Humod(2,step));
    set(h3d.LowerLumbar_Humod,    'XData', Position_3D.LowerLumbar_Humod(1,step),    'YData', Position_3D.LowerLumbar_Humod(3,step),    'ZData', Position_3D.LowerLumbar_Humod(2,step));
    set(h3d.Hip_Left_Humod,       'XData', Position_3D.Hip_Left_Humod(1,step),       'YData', Position_3D.Hip_Left_Humod(3,step),       'ZData', Position_3D.Hip_Left_Humod(2,step));
    set(h3d.Hip_Right_Humod,      'XData', Position_3D.Hip_Right_Humod(1,step),      'YData', Position_3D.Hip_Right_Humod(3,step),      'ZData', Position_3D.Hip_Right_Humod(2,step));
    set(h3d.Knee_Left_Humod,      'XData', Position_3D.Knee_Left_Humod(1,step),      'YData', Position_3D.Knee_Left_Humod(3,step),      'ZData', Position_3D.Knee_Left_Humod(2,step));
    set(h3d.Knee_Right_Humod,     'XData', Position_3D.Knee_Right_Humod(1,step),     'YData', Position_3D.Knee_Right_Humod(3,step),     'ZData', Position_3D.Knee_Right_Humod(2,step));
    set(h3d.Ankle_Left_Humod,     'XData', Position_3D.Ankle_Left_Humod(1,step),     'YData', Position_3D.Ankle_Left_Humod(3,step),     'ZData', Position_3D.Ankle_Left_Humod(2,step));
    set(h3d.Ankle_Right_Humod,    'XData', Position_3D.Ankle_Right_Humod(1,step),    'YData', Position_3D.Ankle_Right_Humod(3,step),    'ZData', Position_3D.Ankle_Right_Humod(2,step));
    
    
    
    
%% Compute 3D forward kinematic
%% ____________________________


    Transformation_3D.Origin_to_LowerLumbar =  tra_x(data.motion.trajectory.q(1, step))    * ...
                                            tra_y(data.motion.trajectory.q(2, step))    * ...
                                            tra_z(data.motion.trajectory.q(3, step))    * ...
                                            rot_x(data.motion.trajectory.q(4, step))    * ...                                            
                                            rot_y(data.motion.trajectory.q(5, step))    * ...
                                            rot_z(data.motion.trajectory.q(6, step));                                            

    Transformation_3D.LowerLumbar_to_UpperLumbar = rot_x(data.motion.trajectory.q(21, step)) * ...
                                                rot_z(data.motion.trajectory.q(22, step)) * ...
                                                tra_y(179.9334);
    
                                            
                                            
    % ROBIBIO parameters
%     Transformation_3D.LowerLumbar_to_Hip_Left  = tra_x(36.9783) * tra_y(93.6711) * tra_z(-118.2911) ;
%     Transformation_3D.LowerLumbar_to_Hip_Right = tra_x(36.9783) * tra_y(-93.6711) * tra_z(-118.2911);

    % Humod parameters
    Transformation_3D.LowerLumbar_to_Hip_Left  =   tra_x(36.885084768078410) * ...
                                                tra_y(-1.182588212536048e+02) * ...
                                                tra_z(-87.899481914679100);
    Transformation_3D.LowerLumbar_to_Hip_Right =   tra_x(37.071586486844716) * ...
                                                tra_y(-1.183232989216850e+02) * ...
                                                tra_z(99.442865923128310);

    
    Transformation_3D.Hip_Left_to_Knee_Left    =   rot_x(data.motion.trajectory.q(23, step))   * ...
                                                rot_y(data.motion.trajectory.q(24, step))   * ...                                            
                                                rot_z(data.motion.trajectory.q(25, step))  * ...
                                                tra_y(-379.8820);                                            
    Transformation_3D.Hip_Right_to_Knee_Right  =   rot_x(data.motion.trajectory.q(26, step))   * ...
                                                rot_y(data.motion.trajectory.q(27, step))   * ...                                            
                                                rot_z(data.motion.trajectory.q(28, step))  * ...
                                                tra_y(-379.8820);
                                            
                                            
    Transformation_3D.Knee_Left_to_Ankle_Left    = rot_z(data.motion.trajectory.q(29, step))   * ...
                                                tra_y(-358.5084);                             
    Transformation_3D.Knee_Right_to_Ankle_Right  = rot_z(data.motion.trajectory.q(30, step))   * ...
                                                tra_y(-358.5084);
    

    Transformation_3D.Ankle_Left_to_Foot_Left    = rot_x(data.motion.trajectory.q(31, step))   * ...
                                                rot_y(data.motion.trajectory.q(32, step))   * ...
                                                rot_z(data.motion.trajectory.q(33, step))   * ...
                                                tra_x(121) * ...
                                                tra_y(-54) * ...
                                                tra_z(-29);
    Transformation_3D.Ankle_Right_to_Foot_Right =  rot_x(data.motion.trajectory.q(34, step))   * ...
                                                rot_y(data.motion.trajectory.q(35, step))   * ...
                                                rot_z(data.motion.trajectory.q(36, step))   * ...
                                                tra_x(121) * ...
                                                tra_y(-54) * ...
                                                tra_z(29);
                                            
    %% Compute position of each joint (3D)
    Position_3D.Origin = [0;0;0;1];
    Position_3D.LowerLumbar    = Transformation_3D.Origin_to_LowerLumbar * Position_3D.Origin;
    Position_3D.UpperLumbar    = Transformation_3D.Origin_to_LowerLumbar * Transformation_3D.LowerLumbar_to_UpperLumbar * Position_3D.Origin  ;
    Position_3D.Hip_Left       = Transformation_3D.Origin_to_LowerLumbar * Transformation_3D.LowerLumbar_to_Hip_Left  *  Position_3D.Origin  ;
    Position_3D.Hip_Right      = Transformation_3D.Origin_to_LowerLumbar * Transformation_3D.LowerLumbar_to_Hip_Right * Position_3D.Origin  ;
    Position_3D.Knee_Left      = Transformation_3D.Origin_to_LowerLumbar * Transformation_3D.LowerLumbar_to_Hip_Left  * Transformation_3D.Hip_Left_to_Knee_Left   * Position_3D.Origin;
    Position_3D.Knee_Right     = Transformation_3D.Origin_to_LowerLumbar * Transformation_3D.LowerLumbar_to_Hip_Right * Transformation_3D.Hip_Right_to_Knee_Right * Position_3D.Origin;
    Position_3D.Ankle_Left     = Transformation_3D.Origin_to_LowerLumbar * Transformation_3D.LowerLumbar_to_Hip_Left  * Transformation_3D.Hip_Left_to_Knee_Left   * Transformation_3D.Knee_Left_to_Ankle_Left   * Position_3D.Origin;
    Position_3D.Ankle_Right    = Transformation_3D.Origin_to_LowerLumbar * Transformation_3D.LowerLumbar_to_Hip_Right * Transformation_3D.Hip_Right_to_Knee_Right * Transformation_3D.Knee_Right_to_Ankle_Right * Position_3D.Origin;
    Position_3D.Foot_Left      = Transformation_3D.Origin_to_LowerLumbar * Transformation_3D.LowerLumbar_to_Hip_Left  * Transformation_3D.Hip_Left_to_Knee_Left   * Transformation_3D.Knee_Left_to_Ankle_Left   * Transformation_3D.Ankle_Left_to_Foot_Left   * Position_3D.Origin;
    Position_3D.Foot_Right     = Transformation_3D.Origin_to_LowerLumbar * Transformation_3D.LowerLumbar_to_Hip_Right * Transformation_3D.Hip_Right_to_Knee_Right * Transformation_3D.Knee_Right_to_Ankle_Right * Transformation_3D.Ankle_Right_to_Foot_Right * Position_3D.Origin;
    
    %% Update 3D figure
    subplot (1,2,1);
    set(h3d.LowerLumbar,  'XData', Position_3D.LowerLumbar(1),   'YData', Position_3D.LowerLumbar(3),   'ZData', Position_3D.LowerLumbar(2));
    set(h3d.UpperLumbar,  'XData', Position_3D.UpperLumbar(1),   'YData', Position_3D.UpperLumbar(3),   'ZData', Position_3D.UpperLumbar(2));
    set(h3d.Hip_Left,     'XData', Position_3D.Hip_Left(1),      'YData', Position_3D.Hip_Left(3),      'ZData', Position_3D.Hip_Left(2));
    set(h3d.Hip_Right,    'XData', Position_3D.Hip_Right(1),     'YData', Position_3D.Hip_Right(3),     'ZData', Position_3D.Hip_Right(2));
    set(h3d.Knee_Left,    'XData', Position_3D.Knee_Left(1),     'YData', Position_3D.Knee_Left(3),     'ZData', Position_3D.Knee_Left(2));
    set(h3d.Knee_Right,   'XData', Position_3D.Knee_Right(1),    'YData', Position_3D.Knee_Right(3),    'ZData', Position_3D.Knee_Right(2));
    set(h3d.Ankle_Left,   'XData', Position_3D.Ankle_Left(1),    'YData', Position_3D.Ankle_Left(3),    'ZData', Position_3D.Ankle_Left(2));
    set(h3d.Ankle_Right,  'XData', Position_3D.Ankle_Right(1),   'YData', Position_3D.Ankle_Right(3),   'ZData', Position_3D.Ankle_Right(2));
    set(h3d.Foot_Left,    'XData', Position_3D.Foot_Left(1),     'YData', Position_3D.Foot_Left(3),     'ZData', Position_3D.Foot_Left(2));
    set(h3d.Foot_Right,   'XData', Position_3D.Foot_Right(1),    'YData', Position_3D.Foot_Right(3),    'ZData', Position_3D.Foot_Right(2));
    
    coef_torques = 0.5;
    set(h3d.Hip_Left,     'MarkerSize', coef_torques * abs (torques.NE_Torques.filtered_torques(25,step)));
    set(h3d.Hip_Right,    'MarkerSize', coef_torques * abs (torques.NE_Torques.filtered_torques(28,step)));    
    set(h3d.Knee_Left,    'MarkerSize', coef_torques * abs (torques.NE_Torques.filtered_torques(29,step)));
    set(h3d.Knee_Right,   'MarkerSize', coef_torques * abs (torques.NE_Torques.filtered_torques(30,step)));
    set(h3d.Ankle_Left,   'MarkerSize', coef_torques * abs (torques.NE_Torques.filtered_torques(33,step)));
    set(h3d.Ankle_Right,  'MarkerSize', coef_torques * abs (torques.NE_Torques.filtered_torques(36,step)));
    
    
    %% Set step and time in title    
    title (sprintf('HuMoD | Step: %d | time=%.2fs',step,time_second(step)));    
    
    
%% Compute 2D forward kinematic
%% ____________________________

    Transformation_2D.Hip_to_Knee_Left   =   rot_z(data.motion.trajectory.q(25, step))  * ...
                                             tra_y(-379.8820);                                            
    Transformation_2D.Hip_to_Knee_Right  =   rot_z(data.motion.trajectory.q(28, step))  * ...
                                             tra_y(-379.8820);
                                         
    Transformation_2D.Knee_Left_to_Ankle_Left    =  rot_z(data.motion.trajectory.q(29, step))   * ...
                                                    tra_y(-358.5);                             
    Transformation_2D.Knee_Right_to_Ankle_Right  =  rot_z(data.motion.trajectory.q(30, step))   * ...
                                                    tra_y(-358.5);                                         
    Transformation_2D.Ankle_Left_to_Foot_Left    =  rot_z(data.motion.trajectory.q(33, step))   * ...
                                                    tra_x(121) * ...
                                                    tra_y(-54);
    Transformation_2D.Ankle_Right_to_Foot_Right  =  rot_z(data.motion.trajectory.q(36, step))   * ...
                                                    tra_x(121) * ...
                                                    tra_y(-54);                                    

                                                
    %% Compute global transformation matrices for each joint (2D)
    Transformation_2D.Hip_to_Ankle_Left     = Transformation_2D.Hip_to_Knee_Left    * Transformation_2D.Knee_Left_to_Ankle_Left;
    Transformation_2D.Hip_to_Ankle_Right    = Transformation_2D.Hip_to_Knee_Right   * Transformation_2D.Knee_Right_to_Ankle_Right;
    Transformation_2D.Hip_to_Foot_Left      = Transformation_2D.Hip_to_Knee_Left    * Transformation_2D.Knee_Left_to_Ankle_Left   * Transformation_2D.Ankle_Left_to_Foot_Left;
    Transformation_2D.Hip_to_Foot_Right     = Transformation_2D.Hip_to_Knee_Right   * Transformation_2D.Knee_Right_to_Ankle_Right * Transformation_2D.Ankle_Right_to_Foot_Right;
    
                                                
    %% Compute position of each joint (2D)
    Position_2D.Origin = [0;0;0;1];
    Position_2D.Hip             = Position_2D.Origin;
    Position_2D.Knee_Left       = Transformation_2D.Hip_to_Knee_Left  * Position_3D.Origin;
    Position_2D.Knee_Right      = Transformation_2D.Hip_to_Knee_Right * Position_3D.Origin;    
    Position_2D.Ankle_Left      = Transformation_2D.Hip_to_Ankle_Left * Position_3D.Origin;
    Position_2D.Ankle_Right     = Transformation_2D.Hip_to_Ankle_Right * Position_3D.Origin;    
    Position_2D.Foot_Left       = Transformation_2D.Hip_to_Foot_Left * Position_3D.Origin;
    Position_2D.Foot_Right      = Transformation_2D.Hip_to_Foot_Right * Position_3D.Origin;

                                                        
    
    %% Update 2D figure
    subplot (1,2,2);
    set(h2d.Hip,          'XData', Position_2D.Hip(1),           'YData', Position_2D.Hip(2));
    set(h2d.Knee_Left,    'XData', Position_2D.Knee_Left(1),     'YData', Position_2D.Knee_Left(2));
    set(h2d.Knee_Right,   'XData', Position_2D.Knee_Right(1),    'YData', Position_2D.Knee_Right(2));
    set(h2d.Ankle_Left,   'XData', Position_2D.Ankle_Left(1),    'YData', Position_2D.Ankle_Left(2));
    set(h2d.Ankle_Right,  'XData', Position_2D.Ankle_Right(1),   'YData', Position_2D.Ankle_Right(2));
    set(h2d.Foot_Left,    'XData', Position_2D.Foot_Left(1),     'YData', Position_2D.Foot_Left(2));
    set(h2d.Foot_Right,   'XData', Position_2D.Foot_Right(1),    'YData', Position_2D.Foot_Right(2));

 
    %% Set step and time in title    
    title (sprintf('ROBIBIO | Step: %d | time=%.2fs',step - start_time*frame_rate, time_second(step) - start_time));   
    
    % Store positions
    dataset.trajectories.x(:,index) = [Position_2D.Hip(1); Position_2D.Hip(1); Position_2D.Knee_Left(1); Position_2D.Knee_Right(1); Position_2D.Ankle_Left(1); Position_2D.Ankle_Right(1); Position_2D.Foot_Left(1); Position_2D.Foot_Right(1)];
    dataset.trajectories.y(:,index) = [Position_2D.Hip(2); Position_2D.Hip(2); Position_2D.Knee_Left(2); Position_2D.Knee_Right(2); Position_2D.Ankle_Left(2); Position_2D.Ankle_Right(2); Position_2D.Foot_Left(2); Position_2D.Foot_Right(2)];
    
    dataset.trajectories.joints.left.hip(:,index) = [Position_2D.Hip(1); Position_2D.Hip(2); 0 ; 1];
    dataset.trajectories.joints.right.hip(:,index) = [Position_2D.Hip(1); Position_2D.Hip(2); 0 ; 1];
    dataset.trajectories.joints.left.knee(:,index) = [Position_2D.Knee_Left(1); Position_2D.Knee_Left(2); 0 ; 1];
    dataset.trajectories.joints.right.knee(:,index) = [Position_2D.Knee_Right(1); Position_2D.Knee_Right(2); 0 ; 1];
    dataset.trajectories.joints.left.ankle(:,index) = [Position_2D.Ankle_Left(1); Position_2D.Ankle_Left(2); 0 ; 1];
    dataset.trajectories.joints.right.ankle(:,index) = [Position_2D.Ankle_Right(1); Position_2D.Ankle_Right(2); 0 ; 1];
    dataset.trajectories.joints.left.foot(:,index) = [Position_2D.Foot_Left(1); Position_2D.Foot_Left(2); 0 ; 1];
    dataset.trajectories.joints.right.foot(:,index) = [Position_2D.Foot_Right(1); Position_2D.Foot_Right(2); 0 ; 1];
    
    
    % Store position, velocity and acceleration
    dataset.trajectories.q(:,index) = [data.motion.trajectory.q(25, step); data.motion.trajectory.q(28, step); data.motion.trajectory.q(29, step); data.motion.trajectory.q(30, step); data.motion.trajectory.q(33, step); data.motion.trajectory.q(36, step)];
    dataset.trajectories.dqdt(:,index) = [data.motion.trajectory.dqdt(25, step); data.motion.trajectory.dqdt(28, step); data.motion.trajectory.dqdt(29, step); data.motion.trajectory.dqdt(30, step); data.motion.trajectory.dqdt(33, step); data.motion.trajectory.dqdt(36, step)];
    dataset.trajectories.ddqddt(:,index) = [data.motion.trajectory.ddqddt(25, step); data.motion.trajectory.ddqddt(28, step); data.motion.trajectory.ddqddt(29, step); data.motion.trajectory.ddqddt(30, step); data.motion.trajectory.ddqddt(33, step); data.motion.trajectory.ddqddt(36, step)];
    
    % Store torques
    dataset.torques.q(:,index) = [torques.NE_Torques.filtered_torques(25,step); torques.NE_Torques.filtered_torques(28,step); torques.NE_Torques.filtered_torques(29,step); torques.NE_Torques.filtered_torques(30,step); torques.NE_Torques.filtered_torques(33,step); torques.NE_Torques.filtered_torques(36,step)];
    
    % Store power
    dataset.power.q(:,index) = dataset.trajectories.dqdt(:,index).*dataset.torques.q(:,index);
    dataset.power.total(:,index) = sum(dataset.power.q(:,index));

    
    % Store transformation matrices
    dataset.transformation_matrices.hip_to_knee_left(:,index)   = reshape(Transformation_2D.Hip_to_Knee_Left, [16,1]);
    dataset.transformation_matrices.hip_to_knee_right(:,index)  = reshape(Transformation_2D.Hip_to_Knee_Right, [16,1]);
    dataset.transformation_matrices.hip_to_ankle_left(:,index)  = reshape(Transformation_2D.Hip_to_Ankle_Left, [16,1]);
    dataset.transformation_matrices.hip_to_ankle_right(:,index) = reshape(Transformation_2D.Hip_to_Ankle_Right, [16,1]);
    dataset.transformation_matrices.hip_to_foot_left(:,index)   = reshape(Transformation_2D.Hip_to_Foot_Left, [16,1]);
    dataset.transformation_matrices.hip_to_foot_right(:,index)  = reshape(Transformation_2D.Hip_to_Foot_Right, [16,1]);
    
    dataset.timestamp(index) = step/frame_rate;
    
    if (mod(step,50) == 0)
        drawnow;
    end;
    
%     if (time_second(step)>22.2)
%         pause;
%     end
    
    index = index+1;
end;

dataset.frame_rate = frame_rate;
dataset.frames = size (dataset.trajectories.q,2);
dataset.parameters.thigh = [0,-380];
dataset.parameters.shang = [0,-358,5];
dataset.parameters.foot = [121,-54];
dataset.labels = [{'Hip_Left'}, {'Hip_Right'}, {'Knee_Left'}, {'Knee_Right'}, {'Ankle_Left'}, {'Ankle_Right'}];
dataset.title = data_title;
dataset.id = id;




%% Save 2D data
save (strcat ('../dataset/robibio/', output_file), 'dataset');

toc/60