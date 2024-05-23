function [robot] = core(robot, dataGrimmer, start, step, stop)
global matrices;
global gHandle;
global expe;
global epoch;

%% Motion loop
index = 1;
for i=start:step:stop
    
    % Store the current step
    robot.step = i;
    
    %% Prepare joint angles
    thetaHip = dataGrimmer.hip.theta(i);
    thetaKnee = dataGrimmer.knee.theta(i);
    thetaAnkle = dataGrimmer.ankle.theta(i);
    
    
    %% Compute transformation matrices & joints trajectories
    robot.matrices.rotation = computeRotationMatrices(thetaHip, thetaKnee, thetaAnkle);
    robot.matrices.transformation = computeTransformationMatrices(robot);
    robot.joints.trajectories = computeJointTrajectories(robot);
    
    
    
    %% Compute motors attachment coordinates, trajectories and length
    robot.motors.joints.trajectories = computeMotorJointsTrajectories(robot);
    robot.motors.trajectories = computeMotorTrajectories(robot);
    
    
    
    %% Compute vectors
    robot.motors.unitVectors = computeMotorUnitVectors(robot);
    robot.motors.leverVectors = computeLeverVectors(robot);
    
    
    
    %% TODO ADD OFFSET AND ROTULE
    
    robot.motors.slidersEnd = computeSlidersEnd(robot);
    robot.motors.statorsEnd = computeStatorsEnd(robot);
    robot.motors.lengths = computeMotorLengths(robot);
    [robot.motors.maxForces, robot.motors.status] = computeMotorMaxForce(robot);
    
    
    
    
    %% Compute Jacobian
    % Torque = Jacobian * Forces
    jacobian = computeJacobian(robot);
    
    
    %% Compute motor velocities
    dqdt = [dataGrimmer.ankle.dqdt(i); dataGrimmer.knee.dqdt(i) ; dataGrimmer.hip.dqdt(i)];
    motor_velocities = transpose(jacobian) * dqdt;
    
    robot.motors.velocity.hip        = motor_velocities(5);
    robot.motors.velocity.knee       = motor_velocities(3);
    robot.motors.velocity.ankle      = motor_velocities(1);
    robot.motors.velocity.hip_knee   = motor_velocities(4);
    robot.motors.velocity.knee_ankle = motor_velocities(2);
    

    %% Compute Torques
    Torques = abs(jacobian) * [ robot.motors.maxForces.ankle ; robot.motors.maxForces.knee_ankle ; robot.motors.maxForces.knee ; robot.motors.maxForces.hip_knee;  robot.motors.maxForces.hip];
    
    robot.joints.torques.hip        = Torques(3);
    robot.joints.torques.knee       = Torques(2);
    robot.joints.torques.ankle      = Torques(1);
    
%     
%     %% Left leg minimize power
%     
%     options = optimset('Display','off');
%     
%     % Minimize power
%     C = diag(motor_velocities);
%     
%     % System to solve
%     Aeq = jacobian;
%     beq = [dataGrimmer.ankle.torque(i); dataGrimmer.knee.torque(i) ; dataGrimmer.hip.torque(i)];
%     
%     % Bounds (Motors maximum force)
%     %ub = [ Inf; Inf; Inf; Inf; Inf ];
%     ub = [ robot.motors.maxForces.ankle ; robot.motors.maxForces.knee_ankle ; robot.motors.maxForces.knee ; robot.motors.maxForces.hip_knee;  robot.motors.maxForces.hip];
%     lb = -ub;
%     
%     % Solver https://fr.mathworks.com/help/optim/ug/lsqlin.html
%     [forces,resnorm,residualLeft,exitFlagLeft,output,lambda] = lsqlin(C, zeros(5,1), [], [], Aeq, beq, lb, ub, [], options);
%     
%     % Motion should be feasable
%     if (exitFlagLeft ~= 1)
%         %fprintf('Error with constrained linear least-squares problems solver\n');
%         forces=[0;0;0;0;0];
%     end
    
    % Store forces
    robot.motors.forces = robot.motors.maxForces;
    robot.motors.forceVectors = computeForceVectors(robot);
    

    %% Compute motor power
    robot.motors.powers = computeMotorPower(robot);
    
    %% Save step data
    save(sprintf('output/expe-%d/epoch-%d/step-%d.mat', expe, epoch, index), 'robot');   
    
    %% Increase index for next step
    index = index+1;
    
end
end