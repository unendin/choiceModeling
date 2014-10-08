function [ choices ]= simulateChoice ( params )
% Simulates choices by DDM model

% Constants derived from params
yMean = params.k * params.c * params.dt;
ySD = sqrt(params.dt);

% Start time measure
tic;

% Preallocate matrix. [Note: shows no performance benefit]
choiceTally = zeros(params.trialCount, 2);

% Loop through trials
for i = 1:params.trialCount  
    
    % Initialize time and decision variable
    t = 0;
    ySum = 0;

    % Accumulate evidence to bound
    while abs(ySum) < params.a

        % Sample drift rate
        dY = normrnd(yMean,ySD);

        % Increment DV
        ySum = ySum + dY;

        % Increment time
        t =  t + 1;
    end
    
    % Append time count and +/- bound 
    choiceTally(i,:) = [round(ySum) t];   
end

choices = choiceTally;

% End time measure
toc;

end
