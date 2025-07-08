speeds = [5, 10, 15, 20];
allData = cell(size(speeds));

figure;
hold on;
grid on;
title('Number of detection for different speed settings');
xlabel('Time (s)');
ylabel('Number of Detections');
colors = lines(numel(speeds));

% run simulation multiple times
for i = 1:numel(speeds)
    speed = speeds(i);

    scenario = intelligentintersection_speedtest_radar('car', speed);

    simOut = sim('intIntersection.slx');

    scopeData = simOut.get('scopeData');

    allData{i} = scopeData;
    
    plot(scopeData.time, squeeze(scopeData.signals.values), ...
         'DisplayName', sprintf('Speed = %d', speed), ...
          'Color', colors(i,:));
end

legend show;