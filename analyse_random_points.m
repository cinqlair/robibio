close all;
clear all;
clc;


global expe;
expe = 22;


% Load initial points
load(sprintf('initial-points/expe-%d.mat', expe));

N=size(initialPoints, 1)

best = [];
maxi = 0;
for (i=1:N)
    maxi = max(maxi, initialPoints(i,31));
    best = [best,maxi];
    
end    
%weight = sort(initialPoints([1:10000],31));

%max (weight)
plot (best)