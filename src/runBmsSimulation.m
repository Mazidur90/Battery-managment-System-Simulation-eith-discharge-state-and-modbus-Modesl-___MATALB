function results = runBmsSimulation(cfg)
%RUNBMSSIMULATION Executes the end-to-end BMS simulation.

rng(cfg.sim.seed);

timeline = (0:cfg.sim.dt:cfg.sim.duration_s).';
nSteps = numel(timeline);

state = initBmsState(cfg);
profile = defaultDriveCycle(timeline, cfg);
logs = initBmsLogs(nSteps, state);

for k = 1:nSteps
    env.currentRequestA = profile.currentA(k);
    env.ambientTempC = profile.ambientTempC(k);

    [state, signals] = bmsStep(state, cfg, env);
    logs = appendBmsLog(logs, k, timeline(k), signals);
end

results.cfg = cfg;
results.timeline = timeline;
results.profile = profile;
results.logs = logs;
end
