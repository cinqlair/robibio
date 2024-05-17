close all;clear all;clc;
%% Path for Matlab functions
addpath ('../functions/');




for i=1:1:250
    [force, state] = P02_23x80F_HP(i, 200)
    x(i)=i;
    y(i)=force;
end

plot (x,y);
grid on;