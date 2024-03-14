function [criteria] = coreOptim(x, motors, dataset, start, step, stop, id)

    global best_solution;
    global indexBest;
    global outputData;
    

    %% Add motor coordinates to structure
    motors = appendX2motors(x, motors);

    %% Run core
    motors = core(motors, dataset, start, step, stop);
    
    
    %% Optimization criteria    
    feasable = mean(motors.feasable);
    efficiency = mean(motors.efficiency);
    averagePower = mean(motors.power.input);
    
        
    %% Optimization criteria
    criteria = 1-feasable;
             
    
    %% Update the best solution if needed
    if (isempty(best_solution) || best_solution(end) > criteria)
        
        %% Store data in history
        %%
        %% STORE POWER IN OUTPUTDATA
        %%
        data = [now, indexBest, x, feasable, averagePower, criteria];
        outputData = [outputData; data];
        
        % Save in .csv and .mat files
        dlmwrite(sprintf ('output/optim-%d.csv',id),data,'-append','precision','%10.10f');
        save(sprintf ('output/optim-%d.mat',id),'outputData');
        
        %% Update and display the best solution
        best_solution = data;
        fprintf ('-------------------------------------\n');
        fprintf ('New best solution!\n');
        fprintf ('\tFeasability = %.2f %%\n',feasable *100);
        fprintf ('\tEfficiency = %.6f\n', efficiency);        
        fprintf ('\tAverage power = %.0fW\n',averagePower);
        fprintf ('\tCriteria = %f\n',criteria);
        fprintf ('-------------------------------------\n');
    end
    

end

