% init Script for initializing the driving scenario and getting actor ID

% load scenario
scenario = scenarioFromDesigner();

% assign to base workspace
assignin('base', 'scenario', scenario);

% getting ActorID
actorName = 'Car1';
actorID = -1;

for i = 1:length(scenario.Actors)
    if strcmp(scenario.Actors(i).Name, actorName)
        actorID = scenario.Actors(i).ActorID;
        break;
    end
end

if actorID == -1
    error("Actor named '%s' not found in scenario.", actorName);
end

assignin('base', 'Car1ID', actorID);