function [motors] = core(motors, dataGrimmer, start, step, stop)
    global matrices;
    global gHandle;
    
    
    %% Motion loop
    index = 1;
    for i=start:step:stop

        %% Prepare joint angles
        thetaHip = dataGrimmer.hip.theta(i);
        thetaKnee = dataGrimmer.knee.theta(i);
        thetaAnkle = dataGrimmer.ankle.theta(i);


        %% Compute transformation matrices & joints trajectories
        matrices.rotation = computeRotationMatrices(thetaHip, thetaKnee, thetaAnkle);
        matrices.transformation = computeTransformationMatrices(matrices);
        trajectories = computeJointTrajectories(matrices);

        %% Compute motors attachment coordinates, trajectories and length
        motors.trajectories = computeMotorTrajectories(matrices, motors);
        motors.lengths = computeMotorLengths(motors);

        %% Compute vectors
        motors.unitVectors = computeMotorUnitVectors(motors);
        motors.leverVectors = computeLeverVectors(motors, trajectories);

        %% Compute Jacobian
        jacobian = computeJacobian(motors);



        %% Compute motor velocities
        dqdt = [dataGrimmer.ankle.dqdt(i); dataGrimmer.knee.dqdt(i) ; dataGrimmer.hip.dqdt(i)];
        motor_velocities = transpose(jacobian) * dqdt;

        motors.velocity.hip        = motor_velocities(5);
        motors.velocity.knee       = motor_velocities(3);
        motors.velocity.ankle      = motor_velocities(1);
        motors.velocity.hip_knee   = motor_velocities(4);
        motors.velocity.knee_ankle = motor_velocities(2);




        %% Left leg minimize power
        options = optimset('Display','off');

        % Minimize power
        C = diag(motor_velocities);

        % System to solve
        Aeq = jacobian;
        beq = [dataGrimmer.ankle.torque(i); dataGrimmer.knee.torque(i) ; dataGrimmer.hip.torque(i)];

        % Bounds (Motors maximum force)
        ub = [ Inf; Inf; Inf; Inf; Inf ];
        lb = -ub;

        % Solver https://fr.mathworks.com/help/optim/ug/lsqlin.html
        [forces,resnorm,residualLeft,exitFlagLeft,output,lambda] = lsqlin(C, zeros(5,1), [], [], Aeq, beq, lb, ub, [], options);

        % Motion should be feasable
        if (exitFlagLeft ~= 1)
            print('Error with constrained linear least-squares problems solver');
        end

        % Store forces
        motors.forces = forces;
        motors.forceVectors = computeForceVectors(motors, forces);


        %% Compute motor power
        motors.powers = computeMotorPower(motors, forces);



        update_figure_robot(gHandle, trajectories, motors);    
        drawnow();

        %% Store data
        motors.dataset_motors_forces(index, :) = forces;
        motors.dataset_motors_max_force(index, :) = max(abs(forces));
        motors.dataset_grimmer_torques(index, :) = [dataGrimmer.ankle.torque(i); dataGrimmer.knee.torque(i) ; dataGrimmer.hip.torque(i)];
        motors.dataset_motors_power(index,:) = [ motors.powers.ankle ; motors.powers.knee_ankle ; motors.powers.knee ; motors.powers.hip_knee;  motors.powers.hip];
        motors.dataset_joint_power(index,:) =  [dataGrimmer.ankle.power(i); dataGrimmer.knee.power(i) ; dataGrimmer.hip.power(i)];



        index = index+1;
    end
end