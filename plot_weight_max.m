close all;clear all;clc;
%% Path for Matlab functions
addpath ('functions/');

global path;
path = '/home/philippe/robibio/grimmer_version/output';


global expe;
expe = 1;
global epoch;
epoch = 1;
global iter;
iter = 1;

weight = [];
max_weight = [];

fprintf("Preparing data...\n\n");

isEpoch = true;
while (isEpoch)
    
    %dirname = sprintf('output/expe-%d/epoch-%d/iter-%d.mat', expe, epoch, iter);
    dirname = sprintf('%s/expe-%d/epoch-%d/',path ,expe ,epoch);
    if (exist(dirname, 'dir'))
        
        isIter = true;
        while (isIter)
            filename = sprintf('%s/expe-%d/epoch-%d/iter-%d.mat', path, expe, epoch, iter);
            if (isfile(filename))
                load(filename);
                %fprintf('Expe %d | Epoch %d | Iter %d | weight = %f kg\n', expe, epoch, iter, data.weight);
                weight = [weight; data.weight];
                max_weight = [max_weight; max(weight)];
                iter = iter +1;
            else
                isIter = false;
                % Next epoch
                iter = 1;
                epoch = epoch +1;
            end
        end
    else
        isEpoch = false;
    end
    
    
    
end

figure; hold on;
plot (weight);
plot (max_weight);
grid on;
title ('Max Weight');

fprintf ("\nMax weight %.2f\n", max(max_weight));
