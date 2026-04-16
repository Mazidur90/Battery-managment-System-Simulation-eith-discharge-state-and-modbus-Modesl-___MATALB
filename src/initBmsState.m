function state = initBmsState(cfg)
%INITBMSSTATE Initialize the plant, estimators, and supervisory state.

nSeries = cfg.pack.numSeries;

cellOffset = linspace(-0.012, 0.012, nSeries).';

state.true.soc = cfg.pack.initialSoc;
state.true.soh = 1.00;
state.true.tempC = cfg.pack.initialTempC;
state.true.coreTempC = cfg.pack.initialTempC;
state.true.surfaceTempC = cfg.pack.initialTempC;
state.true.cellVoltageOffset = cellOffset;
state.true.packCurrentA = 0;

state.est.soc = cfg.pack.initialSoc - 0.02;
state.est.soh = 0.99;
state.est.filteredVoltageV = cfg.pack.numSeries * cfg.pack.nominalVoltageCell;
state.est.sopDischargeW = cfg.supervisor.sopPowerCeilingW;
state.est.sopChargeW = 0;

state.ctrl.coolingOn = false;
state.ctrl.heatingOn = false;
state.ctrl.contactorClosed = true;
state.ctrl.balanceCurrentA = zeros(nSeries, 1);
state.ctrl.requestedCurrentA = 0;
state.ctrl.currentLimitA = cfg.safety.overCurrentDischargeA;
state.ctrl.derateActive = false;
state.ctrl.coolingLevel = 0;

state.supervisor.faults = emptyFaultStruct();
state.supervisor.latchedFault = false;
state.supervisor.modeCode = 0;
state.supervisor.modeName = cfg.supervisor.modeNames(1);
state.supervisor.faultCount = 0;
state.supervisor.derateCount = 0;
state.supervisor.lastSoc = state.est.soc;
state.supervisor.faultSeverity = 0;

state.metrics.packPowerW = 0;
state.metrics.netBatteryPowerW = 0;
state.metrics.lossPowerW = 0;
state.metrics.dischargeEnergyWh = 0;
state.metrics.lossEnergyWh = 0;
state.metrics.throughputAh = 0;
state.metrics.remainingEnergyWh = cfg.pack.nominalEnergyWh * state.est.soc;
state.metrics.availablePowerW = cfg.safety.maxPowerW;
state.metrics.estimatedRangeKm = state.metrics.remainingEnergyWh / max(cfg.vehicle.whPerKm, 1);

state.health.score = 1.0;
state.health.thermalPenalty = 0;
state.health.imbalancePenalty = 0;
state.health.sensorPenalty = 0;
state.health.trueSoh = state.true.soh;

state.comm.id = cfg.comm.frameBaseId + cfg.comm.nodeId;
state.comm.modeCode = state.supervisor.modeCode;
state.comm.faultSeverity = 0;
state.comm.voltageRaw = 0;
state.comm.currentRaw = 0;
state.comm.tempRaw = 0;
state.comm.socRaw = 0;
state.comm.healthRaw = 1000;
state.comm.payload = uint16(zeros(1, 5));
end
