function [criteria] = coreOptim(x, motors, dataGrimmer, start, step, stop, id)

    global best_solution;
    global indexBest;
    global outputData;
    global gConfigHandler;

    %% Add motor coordinates to structure
    %motors = appendX2motors(x, motors);
    motors.parameters = appendX2motors(x);

    %% Run core
    motors = core(motors, dataGrimmer, start, step, stop);
    
    
    %% Optimization criteria  
    averageInputPower = mean(motors.dataset_input_power);
    averageOutputPower = mean(motors.dataset_output_power);
    %efficiency = mean(motors.dataset_efficiency);
    efficiency = averageOutputPower / averageInputPower;
    
    maxForce = max(motors.dataset_motors_max_force(:));
        
    %% Optimization criteria
    criteria = maxForce;
             
    
    %% Update the best solution if needed
    if (isempty(best_solution) || best_solution(end) > criteria)
        
        %% Store data in history
        %%
        %% STORE POWER IN OUTPUTDATA
        %%
        data = [now, indexBest, x, maxForce, averageInputPower, averageOutputPower, efficiency, criteria];
        outputData = [outputData; data];
        
        % Save in .csv and .mat files
        dlmwrite(sprintf ('output/optim-%d.csv',id),data,'-append','precision','%10.10f');
        save(sprintf ('output/optim-%d.mat',id),'outputData');
        
        %% Update and display the best solution
        best_solution = data;
        fprintf ('------------------------------------- iter %d\n', indexBest);
        fprintf ('New best solution!\n');
        fprintf ('\tAverage input power = %.4fW\n',averageInputPower);
        fprintf ('\tAverage output power = %.4fW\n',averageOutputPower);
        fprintf ('\tEfficiency = %.6f\n', efficiency);        
        fprintf ('\tMax Weight= %.1f/%.1fkg\n',13/maxForce, 67.1/maxForce);
        fprintf ('\tMax Force = %.1fN\n',maxForce);
        fprintf ('\tCriteria = %f\n',criteria);
        fprintf ('-------------------------------------\n');
    end
    update_initial_configuration(gConfigHandler, x, motors);
    drawnow();
end

