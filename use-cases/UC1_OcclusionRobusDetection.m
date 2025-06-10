% setup paths
addpath(fullfile(pwd, 'models'));
addpath(fullfile(pwd, 'use-cases'));
resultsDir = fullfile(pwd, '..', 'results','UC1');
if ~exist(resultsDir, 'dir')
    mkdir(resultsDir);
end

% preallocation for speed and variable setup
initSpeed = 5;
depths = 0.5:0.5:3.0;

results = struct('depth', [], 'pd', [], 'pfa', []);

% looping of occlusion depths
for idx = 1:numel(depths)
    d = depths(idx);
    fprintf("Runninc UC1 for occlusion depths = %.1f m, initSpeed = %.1f m/s\n", d, initSpeed);

    scene = buildScenario(d, initSpeed);

    assignin('base', 'scenario', scene);

    simOut = sim('intersection_radar', ...
                 'StopTime', '20', ...
                 'SrcWorkspace', 'base', ...
                 'SaveOutput', 'on');

    [pd,pfa] = analyzeDetections(simOut);

    results(idx).depth = d;
    results(idx).pd = pd;
    results(idx).pfa = pfa;
    save(fullfile(resultsdir, sprintf('res_%.1f.mat', d)), 'pd', 'pfa');
end

% Plotting
depthsVals = [results.depths];
pdVals = [results.pd];
pfaVals = [results.pfa];

figure;
plot(depthsVals, pdVals, '-o', 'DisplayName', 'Pd');
hold on;
plot(depthsVals, pfaVals, '-x', 'DisplayName', 'Pfa');
hold off;

xlabel('Occlusion Depth (m)');
ylabel('Probability');
title('Detection Performance vs Occlusion Depth');
legend('Location', 'best');
grid on;