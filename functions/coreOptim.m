function [criteria] = coreOptim(x, robot, dataGrimmer, start, step, stop, id)



global outputData;
global gConfigHandler;
global path; 
global expe;
global epoch;
global iter;

global saveSteps;
global saveIters;


global bestWeight;
global bestEpoch; 
global bestIter;

if (saveSteps)
    system (sprintf('rm -rf %s/expe-%d/epoch-%d/iter-%d', path, expe, epoch, iter));
    mkdir(sprintf('%s/expe-%d/epoch-%d/iter-%d',path ,expe ,epoch ,iter));
    hash = randi(1e6);
    save(sprintf('%s/expe-%d/epoch-%d/iter-%d/hash.mat', path, expe, epoch, iter),  'hash');
end

%% Add motor coordinates to structure
%motors = appendX2motors(x, motors);
robot.motors.parameters = appendX2motors(x);

%% Run core
weight =  core(robot, dataGrimmer, start, step, stop);


%% Optimization criteria
criteria = -weight;


%% Update the best solution if needed
if (isempty(bestWeight) || weight > bestWeight )
    
    
    %% Update and display the best solution
    bestWeight = weight;
    bestEpoch = epoch; 
    bestIter = iter;
    fprintf ('-------------------------------------\n');
    fprintf ('New best solution!\n');
    fprintf ('\tExpe %d\n', expe);
    fprintf ('\tEpoch %d\n', epoch);
    fprintf ('\tIteration %d\n', iter);
    fprintf ('\n');
    
    fprintf ('\tMax Weight= %.1f kg\n',weight);
    fprintf ('\tCriteria = %f\n',criteria);
    fprintf ('-------------------------------------\n\n\n');
    
    %% Save step data
    if (saveSteps)
        data.weight = weight;
        data.epoch = epoch;
        data.iter = iter;
        save(sprintf('%s/expe-%d/best.mat', path, expe), 'data');
    end
end


%% Save iteration data
data.x = x;
data.weight = weight;
data.criteria = criteria;
data.robot = robot;

%% Save step data
if (saveIters)
    save(sprintf('%s/expe-%d/epoch-%d/iter-%d.mat',path , expe, epoch, iter), 'data');
end


iter = iter + 1;

end

