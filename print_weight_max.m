close all;clear all;clc;
%% Path for Matlab functions
addpath ('functions/');

global path;
%path = '/home/philippe/robibio/grimmer_version/output';
path = '/media/philippe/Disk_12To/robibio';




for expe=1:14
    filename = sprintf('%s/expe-%d/best.mat', path, expe);
    if (~isfile(filename))
        fprintf('No file %f\n', filename);
    else
        load(filename)
        fprintf('Expe %d | Epoch %d | Iteration %d | Best = %f\n', expe, data.epoch, data.iter, data.weight)
    end
end