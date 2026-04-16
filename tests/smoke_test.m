clear;
clc;

projectRoot = fileparts(fileparts(mfilename("fullpath")));
addpath(genpath(projectRoot));

cfg = defaultPackConfig();
cfg.sim.duration_s = 120;

results = runBmsSimulation(cfg);

assert(~isempty(results.logs.time_s), "Simulation logs are empty.");
assert(all(results.logs.socEst >= 0 & results.logs.socEst <= 1), "SOC estimate out of bounds.");
assert(all(results.logs.sohEst > 0.70), "SOH estimate dropped below expected floor.");
assert(all(results.logs.maxCellVoltageV < 4.35), "Cell voltage exceeded expected cap.");
assert(all(results.logs.currentLimitA >= 0), "Current limit dropped below zero.");
assert(all(results.logs.remainingEnergyWh >= 0), "Remaining energy became negative.");
assert(all(results.logs.modeCode >= 0 & results.logs.modeCode <= 3), "Unexpected supervisor mode code.");
assert(all(results.logs.healthScore >= 0 & results.logs.healthScore <= 1), "Health score out of bounds.");
assert(all(results.logs.sopDischargeW >= 0), "SOP estimate became negative.");

disp("Smoke test passed.");
