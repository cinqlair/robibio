function [criteria] = coreOptim(x, robot, dataGrimmer, start, step, stop, id)

global best_solution;
global indexBest;
global outputData;
global gConfigHandler;
global expe;
global epoch;
global iter;


system (sprintf('rm -rf output/expe-%d/epoch-%d/iter-%d', expe, epoch, iter));
mkdir(sprintf('output/expe-%d/epoch-%d/iter-%d', expe, epoch, iter));
hash = randi(1e6);
save(sprintf('output/expe-%d/epoch-%d/iter-%d/hash.mat', expe, epoch, iter),  'hash');

%% Add motor coordinates to structure
%motors = appendX2motors(x, motors);
robot.motors.parameters = appendX2motors(x);

%% Run core
weight =  core(robot, dataGrimmer, start, step, stop);


%% Optimization criteria
criteria = -weight;


%% Update the best solution if needed
if (isempty(best_solution) || best_solution > criteria)
    
    
    %% Update and display the best solution
    best_solution = criteria;
    fprintf ('-------------------------------------\n');
    fprintf ('New best solution!\n');
    fprintf ('\tExpe %d\n', expe);
    fprintf ('\tEpoch %d\n', epoch);
    fprintf ('\tIteration %d\n', iter);
    fprintf ('\n');
    
    fprintf ('\tMax Weight= %.1f kg\n',weight);
    fprintf ('\tCriteria = %f\n',criteria);
    fprintf ('-------------------------------------\n\n\n');
end


%% Save iteration data
data.x = x;
data.weight = weight;
data.criteria = criteria;
data.robot = robot;
save(sprintf('output/expe-%d/epoch-%d/iter-%d.mat', expe, epoch, iter), 'data');

iter = iter + 1;

end

