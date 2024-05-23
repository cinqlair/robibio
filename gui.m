close all;clear all;clc;
%% Path for Matlab functions
addpath ('functions/');

global expe;
expe = 0;
global epoch;
epoch = 372;
global step; 
step = 1;

currentHash = 0;

figure(1);
gHandle = init_figure_robot();


while (1)
    
    %% Check for new hash (expe restarted)
    load(sprintf('output/expe-%d/epoch-%d/hash.mat', expe, epoch));
    
    if (currentHash ~= hash) 
        % New run, reset epoch and step
        disp(sprintf ('New expe | hash = %d', hash));
        currentHash = hash;
        epoch = 1;
        step = 1;
    end
    filename = sprintf('output/expe-%d/epoch-%d/step-%d.mat', expe, epoch, step);
    if (isfile(sprintf('output/expe-%d/epoch-%d/step-%d.mat', expe, epoch, step)))
        load(filename)
    
    
        update_figure_robot(gHandle, robot);
        title(sprintf('Motion | Step %d', robot.step));
        drawnow();
        
        step = step + 1;
    else
      pause(0.2);
    end;
end