close all;clear all;clc;
%% Path for Matlab functions
addpath ('functions/');

global expe;
expe = 1;
global epoch;
epoch = 1;
global step; 
step = 1;

currentHash = 0;

figure(1);
gHandle = init_figure_robot();

fprintf('Press a key to start');
pause

isOver = false;
while (isOver == false)
    
    %% Check for new hash (expe restarted)
    if (isfile(sprintf('output/expe-%d/epoch-%d/hash.mat', expe, epoch)))
        load(sprintf('output/expe-%d/epoch-%d/hash.mat', expe, epoch));
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
    filename = sprintf('output/expe-%d/epoch-%d/step-%d.mat', expe, epoch, step);
    if (isfile(sprintf('output/expe-%d/epoch-%d/step-%d.mat', expe, epoch, step)))
        load(filename)
    
    
        update_figure_robot(gHandle, robot);
        title(sprintf('Motion | Expe %d | Epoch %d | Step %d', expe, epoch, robot.step));
        drawnow();
        
        step = step + 1;
        if (step > 1)
            step = 1;
            epoch = epoch +1;
        end
    else
        isOver= true;
      pause(0.2);
    end;
end