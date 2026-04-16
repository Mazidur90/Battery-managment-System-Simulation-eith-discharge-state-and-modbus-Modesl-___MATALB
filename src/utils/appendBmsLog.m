function logs = appendBmsLog(logs, idx, time_s, signals)
%APPENDBMSLOG Append one timestep of signals into the log structure.

logs.time_s(idx) = time_s;
logs.packVoltageV(idx) = signals.packVoltageV;
logs.packCurrentA(idx) = signals.packCurrentA;
logs.packTempC(idx) = signals.packTempC;
logs.packCoreTempC(idx) = signals.packCoreTempC;
logs.packSurfaceTempC(idx) = signals.packSurfaceTempC;
logs.socTrue(idx) = signals.socTrue;
logs.socEst(idx) = signals.socEst;
logs.sohTrue(idx) = signals.sohTrue;
logs.sohEst(idx) = signals.sohEst;
logs.minCellVoltageV(idx) = signals.minCellVoltageV;
logs.maxCellVoltageV(idx) = signals.maxCellVoltageV;
logs.contactorClosed(idx) = signals.contactorClosed;
logs.coolingOn(idx) = signals.coolingOn;
logs.heatingOn(idx) = signals.heatingOn;
logs.balanceActive(idx) = signals.balanceActive;
logs.coolingLevel(idx) = signals.coolingLevel;
logs.currentLimitA(idx) = signals.currentLimitA;
logs.derateActive(idx) = signals.derateActive;
logs.modeCode(idx) = signals.modeCode;
logs.faultLatched(idx) = signals.faultLatched;
logs.faultSeverity(idx) = signals.faultSeverity;
logs.packPowerW(idx) = signals.packPowerW;
logs.lossPowerW(idx) = signals.lossPowerW;
logs.remainingEnergyWh(idx) = signals.remainingEnergyWh;
logs.availablePowerW(idx) = signals.availablePowerW;
logs.estimatedRangeKm(idx) = signals.estimatedRangeKm;
logs.dischargeEnergyWh(idx) = signals.dischargeEnergyWh;
logs.throughputAh(idx) = signals.throughputAh;
logs.sopDischargeW(idx) = signals.sopDischargeW;
logs.healthScore(idx) = signals.healthScore;
logs.thermalPenalty(idx) = signals.thermalPenalty;
logs.imbalancePenalty(idx) = signals.imbalancePenalty;
logs.sensorPenalty(idx) = signals.sensorPenalty;
logs.commId(idx) = signals.commId;
logs.commModeCode(idx) = signals.commModeCode;
logs.commFaultSeverity(idx) = signals.commFaultSeverity;
logs.commVoltageRaw(idx) = signals.commVoltageRaw;
logs.commCurrentRaw(idx) = signals.commCurrentRaw;
logs.commTempRaw(idx) = signals.commTempRaw;
logs.commSocRaw(idx) = signals.commSocRaw;
logs.commHealthRaw(idx) = signals.commHealthRaw;
logs.voltageResidualV(idx) = signals.voltageResidualV;
logs.tempResidualC(idx) = signals.tempResidualC;
logs.socError(idx) = signals.socError;
logs.derateMarginA(idx) = signals.derateMarginA;

faultFields = fieldnames(signals.faults);
for i = 1:numel(faultFields)
    logs.faultMatrix.(faultFields{i})(idx) = signals.faults.(faultFields{i});
end
end
