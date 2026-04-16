function [ctrl, limit] = applyCurrentDerating(ctrl, meas, est, faults, cfg)
%APPLYCURRENTDERATING Compute the dynamic discharge current limit.

baseLimit = cfg.safety.overCurrentDischargeA;
tempScale = interpolateScale(meas.packTempC, ...
    cfg.supervisor.derateStartTempC, cfg.supervisor.derateEndTempC);
socScale = interpolateScale(cfg.supervisor.derateStartSoc - est.soc, ...
    0, cfg.supervisor.derateStartSoc - cfg.supervisor.derateMinSoc);
voltageScale = interpolateScale(cfg.supervisor.derateStartVoltageV - meas.minCellVoltageV, ...
    0, cfg.supervisor.derateStartVoltageV - cfg.supervisor.derateMinVoltageV);

derateScale = min([tempScale, socScale, voltageScale]);
limit.dynamicCurrentA = max(0, baseLimit * derateScale);
limit.thermalScale = tempScale;
limit.socScale = socScale;
limit.voltageScale = voltageScale;
limit.powerLimitCurrentA = cfg.safety.maxPowerW / max(meas.packVoltageV, 0.1);
limit.allowedCurrentA = min(limit.dynamicCurrentA, limit.powerLimitCurrentA);

if faults.critical
    limit.allowedCurrentA = 0;
end

ctrl.requestedCurrentA = min(ctrl.requestedCurrentA, limit.allowedCurrentA);
ctrl.currentLimitA = limit.allowedCurrentA;
ctrl.derateActive = limit.allowedCurrentA < baseLimit - 1e-6;
end
