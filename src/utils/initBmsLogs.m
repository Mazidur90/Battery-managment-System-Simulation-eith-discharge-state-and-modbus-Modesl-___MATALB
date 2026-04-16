function logs = initBmsLogs(nSteps, state)
%INITBMSLOGS Preallocate the simulation log structure.

faultFields = fieldnames(state.supervisor.faults);

logs.time_s = zeros(nSteps, 1);
logs.packVoltageV = zeros(nSteps, 1);
logs.packCurrentA = zeros(nSteps, 1);
logs.packTempC = zeros(nSteps, 1);
logs.packCoreTempC = zeros(nSteps, 1);
logs.packSurfaceTempC = zeros(nSteps, 1);
logs.socTrue = zeros(nSteps, 1);
logs.socEst = zeros(nSteps, 1);
logs.sohTrue = zeros(nSteps, 1);
logs.sohEst = zeros(nSteps, 1);
logs.minCellVoltageV = zeros(nSteps, 1);
logs.maxCellVoltageV = zeros(nSteps, 1);
logs.contactorClosed = false(nSteps, 1);
logs.coolingOn = false(nSteps, 1);
logs.heatingOn = false(nSteps, 1);
logs.balanceActive = false(nSteps, 1);
logs.coolingLevel = zeros(nSteps, 1);
logs.currentLimitA = zeros(nSteps, 1);
logs.derateActive = false(nSteps, 1);
logs.modeCode = zeros(nSteps, 1);
logs.faultLatched = false(nSteps, 1);
logs.faultSeverity = zeros(nSteps, 1);
logs.packPowerW = zeros(nSteps, 1);
logs.lossPowerW = zeros(nSteps, 1);
logs.remainingEnergyWh = zeros(nSteps, 1);
logs.availablePowerW = zeros(nSteps, 1);
logs.estimatedRangeKm = zeros(nSteps, 1);
logs.dischargeEnergyWh = zeros(nSteps, 1);
logs.throughputAh = zeros(nSteps, 1);
logs.sopDischargeW = zeros(nSteps, 1);
logs.healthScore = zeros(nSteps, 1);
logs.thermalPenalty = zeros(nSteps, 1);
logs.imbalancePenalty = zeros(nSteps, 1);
logs.sensorPenalty = zeros(nSteps, 1);
logs.commId = zeros(nSteps, 1);
logs.commModeCode = zeros(nSteps, 1);
logs.commFaultSeverity = zeros(nSteps, 1);
logs.commVoltageRaw = zeros(nSteps, 1);
logs.commCurrentRaw = zeros(nSteps, 1);
logs.commTempRaw = zeros(nSteps, 1);
logs.commSocRaw = zeros(nSteps, 1);
logs.commHealthRaw = zeros(nSteps, 1);
logs.voltageResidualV = zeros(nSteps, 1);
logs.tempResidualC = zeros(nSteps, 1);
logs.socError = zeros(nSteps, 1);
logs.derateMarginA = zeros(nSteps, 1);

for i = 1:numel(faultFields)
    logs.faultMatrix.(faultFields{i}) = false(nSteps, 1);
end
end
