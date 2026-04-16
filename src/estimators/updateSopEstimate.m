function est = updateSopEstimate(est, meas, cfg)
%UPDATESOPESTIMATE Estimate available discharge power from present state.

voltageMarginV = max(meas.minCellVoltageV - cfg.safety.underVoltageCell, 0);
thermalScale = interpolateScale(meas.packTempC, ...
    cfg.supervisor.derateStartTempC, cfg.supervisor.derateEndTempC);
socScale = interpolateScale(cfg.supervisor.derateStartSoc - est.soc, ...
    0, cfg.supervisor.derateStartSoc - cfg.supervisor.derateMinSoc);

currentLimitedPowerW = cfg.safety.overCurrentDischargeA * max(meas.packVoltageV, 0);
voltageLimitedPowerW = max(0, voltageMarginV / max(cfg.pack.baseResistanceOhm, eps)) * max(meas.packVoltageV, 0);
thermalLimitedPowerW = cfg.supervisor.sopPowerCeilingW * min(thermalScale, socScale);

est.sopDischargeW = max(0, min([currentLimitedPowerW, voltageLimitedPowerW, thermalLimitedPowerW, cfg.supervisor.sopPowerCeilingW]));
est.sopChargeW = 0;
end
