function meas = measurePack(truth, cfg)
%MEASUREPACK Sensor model with simple Gaussian noise.

meas.packVoltageV = truth.packVoltageV + cfg.sensor.voltageNoiseStd * randn();
meas.packCurrentA = truth.packCurrentA + cfg.sensor.currentNoiseStd * randn();
meas.packTempC = truth.packTempC + cfg.sensor.tempNoiseStd * randn();
meas.cellVoltagesV = truth.cellVoltagesV + cfg.sensor.voltageNoiseStd * randn(size(truth.cellVoltagesV));
meas.minCellVoltageV = min(meas.cellVoltagesV);
meas.maxCellVoltageV = max(meas.cellVoltagesV);
meas.voltageResidualV = meas.packVoltageV - truth.packVoltageV;
meas.currentResidualA = meas.packCurrentA - truth.packCurrentA;
meas.tempResidualC = meas.packTempC - truth.packTempC;
end
