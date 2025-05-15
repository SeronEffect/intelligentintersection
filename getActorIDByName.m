function id = getActorIDByName(scenario, name)
    id = -1;
    for i = 1:length(scenario.Actors)
        if strcmp(scenario.Actors(i).Name, name)
            id = scenario.Actors(i).ActorID;
            return;
        end
    end
    error("Actor with name '%s' not found", name);
end