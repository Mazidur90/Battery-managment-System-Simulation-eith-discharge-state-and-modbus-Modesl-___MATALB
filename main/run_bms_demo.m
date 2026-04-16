clear;
clc;

projectRoot = fileparts(fileparts(mfilename("fullpath")));
addpath(genpath(projectRoot));

cfg = defaultPackConfig();
results = runBmsSimulation(cfg);
faultNames = fieldnames(results.logs.faultMatrix);
finalFaults = false(numel(faultNames), 1);
for i = 1:numel(faultNames)
    finalFaults(i) = results.logs.faultMatrix.(faultNames{i})(end);
end

fprintf("Simulation complete.\n");
fprintf("Cell: %s\n", cfg.cell.name);
fprintf("Discharge current limit: %.1f A\n", cfg.safety.overCurrentDischargeA);
fprintf("Under-voltage limit: %.2f V\n", cfg.safety.underVoltageCell);
fprintf("Temperature window: %.1f C to %.1f C\n", cfg.safety.underTempC, cfg.safety.overTempC);
fprintf("Final SOC estimate: %.3f\n", results.logs.socEst(end));
fprintf("Final true SOC: %.3f\n", results.logs.socTrue(end));
fprintf("Final SOH estimate: %.3f\n", results.logs.sohEst(end));
fprintf("Remaining energy: %.1f Wh\n", results.logs.remainingEnergyWh(end));
fprintf("Estimated range: %.1f km\n", results.logs.estimatedRangeKm(end));
fprintf("SOP discharge capability: %.1f W\n", results.logs.sopDischargeW(end));
fprintf("Health score: %.3f\n", results.logs.healthScore(end));
fprintf("Fault severity: %d\n", round(results.logs.faultSeverity(end)));
fprintf("Supervisor mode code: %d\n", results.logs.modeCode(end));
fprintf("Fault active at end: %d\n", any(finalFaults));

plotBmsResults(results);
