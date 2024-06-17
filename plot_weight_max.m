close all;clear all;clc;
%% Path for Matlab functions
addpath ('functions/');



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
    dirname = sprintf('output/expe-%d/epoch-%d/', expe, epoch);
    if (exist(dirname, 'dir'))
        
        isIter = true;
        while (isIter)
            filename = sprintf('output/expe-%d/epoch-%d/iter-%d.mat', expe, epoch, iter);
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
