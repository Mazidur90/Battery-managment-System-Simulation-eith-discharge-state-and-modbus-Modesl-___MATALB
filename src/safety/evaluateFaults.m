function faults = evaluateFaults(meas, est, cfg)
%EVALUATEFAULTS Safety checks for pack operation.

faults = emptyFaultStruct();
faults.overVoltage = meas.maxCellVoltageV >= cfg.safety.overVoltageCell;
faults.underVoltage = meas.minCellVoltageV <= cfg.safety.underVoltageCell;
faults.overTemp = meas.packTempC >= cfg.safety.overTempC;
faults.underTemp = meas.packTempC <= cfg.safety.underTempC;
faults.overCurrentDischarge = meas.packCurrentA >= cfg.safety.overCurrentDischargeA;
faults.overCurrentCharge = meas.packCurrentA <= cfg.safety.overCurrentChargeA;
faults.socHigh = est.soc >= cfg.safety.maxSoc;
faults.socLow = est.soc <= cfg.safety.minSoc;
faults.overPower = meas.packVoltageV * meas.packCurrentA >= cfg.safety.maxPowerW;
faults.sensorVoltage = abs(meas.voltageResidualV) >= cfg.safety.maxSensorVoltageErrorV;
faults.cellImbalance = (meas.maxCellVoltageV - meas.minCellVoltageV) >= cfg.safety.maxCellImbalanceV;
faults.critical = faults.overVoltage || faults.underVoltage || faults.overTemp ...
    || faults.overCurrentDischarge || faults.overCurrentCharge || faults.overPower ...
    || faults.sensorVoltage;
end
