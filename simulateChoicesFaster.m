function [ choices ]= simulateChoicesFaster ( params )
% Simulates choices by DDM model

% Constants derived from params
yMean = params.k * params.c * params.dt;
ySD = sqrt(params.dt);
params.timeout = 8;
maxDtCount = params.timeout/params.dt; 


% Start time measure
tic;

% Preallocate matrix. [Note: shows no performance benefit]
choiceTally = zeros(params.trialCount, 2);

choices = zeros(params.trialCount, 2);

for i = 1:params.trialCount
    M = normrnd(yMean,ySD, [maxDtCount,1]);
    CM = cumsum(M,1);
    a = find(abs(CM)>=1,1);
    choiceTally(i,:) = [round(CM(a)) a];
end

choices = choiceTally;

% End time measure
toc;

end






