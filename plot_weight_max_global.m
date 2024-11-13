close all;
clear all;
clc;
%% Path for Matlab functions
addpath ('functions/');

global path;
%path = '/home/philippe/robibio/grimmer_version/output';
path = 'output/single_fast';


global archId;
archId = 7;
global motionId;
motionId = 11;
global epoch;


for archId = 1:14
    for motionId = 1:14
        

        epoch = 1;
        
        weight = [];
        max_weight = [];
        
        %fprintf("Preparing data...\n\n");
        
        isFile = true;
        while (isFile)
            
            filename = sprintf('%s/arch-%d-motion-%d/epoch-%d.mat',path, archId, motionId, epoch);
            if (isfile(filename))
                
                load(filename);
                %fprintf('Expe %d | Epoch %d | Iter %d | weight = %f kg\n', expe, epoch, iter, data.weight);
                weight = [weight; -data.fval];
                max_weight = [max_weight; max(weight)];
                epoch = epoch + 1;
            else
                isFile = false;
            end
            
        end
        fprintf ("%.2f\t", max(max_weight));        
    end
    fprintf ("\n");
end


% figure; hold on;
% plot (weight);
% plot (max_weight);
% grid on;
% title ('Max Weight');


