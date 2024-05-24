close all;clear all;clc;
%% Path for Matlab functions
addpath ('functions/');

global expe;
expe = 1;
global epoch;
epoch = 1;
global iter; 
iter = 1;
global step; 
step = 1;


global saveSteps;
saveSteps = false;



best = load (sprintf('output/expe-%d/best.mat', expe))
best = best.data;

epoch = best.epoch;

fprintf('Best solution | Epoch %d | Iter %d | Weight = %f\n', best.epoch, best.iter, best.weight);


currentHash = 0;

figure(1);
gHandle = init_figure_robot();

% fprintf('Press a key to start');
% pause

isOver = false;
while (isOver == false)
    
    %% Check for new hash (expe restarted)
    if (isfile(sprintf('output/expe-%d/epoch-%d/iter-%d/hash.mat', expe, epoch, iter)))
        load(sprintf('output/expe-%d/epoch-%d/iter-%d/hash.mat', expe, epoch, iter));
    else
        hash = currentHash;
    end
    
%     if (currentHash ~= hash) 
%         % New run, reset epoch and step
%         disp(sprintf ('New expe | hash = %d', hash));
%         currentHash = hash;
%         epoch = 1;
%         step = 1;
%     end
    filename = sprintf('output/expe-%d/epoch-%d/iter-%d/step-%d.mat', expe, epoch, iter, step);
    if (isfile(sprintf('output/expe-%d/epoch-%d/iter-%d/step-%d.mat', expe, epoch, iter, step)))
        load(filename)
    
    
        update_figure_robot(gHandle, robot);
        title(sprintf('Motion | Expe %d | Epoch %d | Iter %d | Step %d | %.2f kg', expe, epoch, iter, robot.step, best.weight));
        drawnow();
        
        step = step + 1;
        if (step > 1)
            step = 1;
            iter = iter +1;
        end
    else
      isOver= true;
      pause(0.2);
    end;
end