function [scenario, egoVehicle] = createScenario(actorSpeed)
% createDrivingScenario Returns the drivingScenario defined in the Designer

% Construct a drivingScenario object.
scenario = drivingScenario('GeoReference', [52.182089 10.5615225 0], ...
    'VerticalAxis', 'Y');

% Add all road segments
roadCenters = [-42.5 4.9 -0.00013406518698922;
    -41.7 -16.9 0;
    -43.385982854891 -55.757610975502 -0.0003910765129902;
    -44.254763536058 -67.352020646773 -0.00050897808426242;
    -45.096184797016 -78.568109499702 -0.00064321917726318];
headings = [-75;NaN;NaN;NaN;NaN];
marking = [laneMarking('Unmarked')
    laneMarking('DoubleSolid', 'Color', [0.98 0.86 0.36])
    laneMarking('Solid')];
laneSpecification = lanespec([1 1], 'Width', 3, 'Marking', marking);
road(scenario, roadCenters, 'Heading', headings, 'Lanes', laneSpecification, 'Name', 'Am Exer (unten)');

roadCenters = [-108.33083298157 20.743937261892 -0.0009612625106481;
    -81.5 20.6 -0.00041230897892675;
    -58.8 19.8 -0.00013406518698922;
    -45.5 13.6 -0.00013406518698922;
    -42.4 4.9 -0.00013406518698922];
lanetypes = [laneType('Driving')
    laneType('Parking')];
laneSpecification = lanespec([1 1], 'Width', 3, 'Type', lanetypes);
road(scenario, roadCenters, 'Lanes', laneSpecification, 'Name', 'Am Exer (links)');

roadCenters = [-43.45 16.05 -0.00013406518698922;
    -39.4 18.9 0;
    -24.2 21.5 0;
    -2.3 21.3 -1.5233290059591e-05];
laneSpecification = lanespec([1 1], 'Width', 3);
road(scenario, roadCenters, 'Lanes', laneSpecification, 'Name', 'Am Exer (rechts)');

% Add the actors
car1 = vehicle(scenario, ...
    'ClassID', 1, ...
    'Length', 4.848, ...
    'Width', 1.842, ...
    'Height', 1.517, ...
    'Position', [-43.2 -76.8 0], ...
    'ExitTime', 13, ...
    'RearOverhang', 1.119, ...
    'FrontOverhang', 0.911, ...
    'Mesh', driving.scenario.carMesh, ...
    'Name', 'Car1');
waypoints = [-43.2 -76.8 0;
    -42.2 -63.7 0;
    -41.1 -49.9 0;
    -40.7 -31.1 0;
    -39.9 -13 0;
    -40.7 2.8 0;
    -46.5 17.4 0;
    -61 21.3 0;
    -73.4 21.9 0;
    -86.9 22.2 0];

trajectory(car1, waypoints, actorSpeed);

% Add the ego vehicle
egoVehicle = vehicle(scenario, ...
    'ClassID', 1, ...
    'Length', 4.848, ...
    'Width', 1.842, ...
    'Height', 1.517, ...
    'Position', [-35.4 26.9 0], ...
    'Yaw', -135, ...
    'RearOverhang', 1.119, ...
    'FrontOverhang', 0.911, ...
    'Mesh', driving.scenario.carMesh, ...
    'Name', 'RadarCar');