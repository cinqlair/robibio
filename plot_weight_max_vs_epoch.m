close all;clear all;clc;
%% Path for Matlab functions
addpath ('functions/');

global path;
%path = '/home/philippe/robibio/grimmer_version/output';
path = '/media/philippe/Disk_12To/robibio';


global expe;
expe = 34;
global epoch;
epoch = 1;
%global iter;
%iter = 1;

weight = [];
max_weight = [];

fprintf("Preparing data...\n\n");

isFile = true;
while (isFile)
    
    filename = sprintf('%s/expe-%d/epoch-%d.mat',path ,expe ,epoch);
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
    

figure; hold on;
plot (weight);
plot (max_weight);
grid on;
title ('Max Weight');

fprintf ("\nMax weight %.2f\n", max(max_weight));
