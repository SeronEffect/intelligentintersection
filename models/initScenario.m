% init Script for initializing the driving scenario and regenerating upon
% request
function initScenario()

    mdl = 'intintersec';
    if ~bdIsLoaded(mdl)
        return;
    end

    valStr     = get_param("intintersec/Car1SpeedSlider", "Value");
    initSpeed1  = str2double(valStr);

    % load scenario
    scenario = scenarioFromDesigner(initSpeed1);

    % assign to base workspace
    assignin('base', 'scenario', scenario);
