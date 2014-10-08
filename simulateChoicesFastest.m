function [ choices ]= simulateChoicesFastest ( params )
% Simulates choices by DDM model

% Constants derived from params
% params.k = 10;
% params.c = .5;
% params.dt = .05;
% params.timeout = 1;
% params.trialCount =5;

params.timeout = 8;

yMean = params.k * params.c * params.dt;
ySD = sqrt(params.dt);
maxDtCount = params.timeout/params.dt; 


% Start time measure
tic;

% Preallocate matrix. [Note: shows no performance benefit]
M = normrnd(yMean, ySD, [maxDtCount, params.trialCount]);
CM = cumsum(M);
idx = find(abs(CM)>=1);
[r c] = ind2sub(size(CM),idx);
choices = accumarray(c,r,[],@min);
choices(params.trialCount, 2) = 1;

% End time measure
toc;

end

