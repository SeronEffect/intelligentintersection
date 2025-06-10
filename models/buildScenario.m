function scenario = buildScenario(initSpeed, occlusionDepth)

    scenario = scenarioFromDesigner(initSpeed, 0);

    mask = [scenario.Actors.IsObstacle];
    scenario.Actors(mask) = [];
end