function health = computeHealthScore(truth, est, meas, cfg)
%COMPUTEHEALTHSCORE Combine SOH, thermal stress, voltage stability, and noise.

sohTerm = saturate(est.soh, 0, 1);
thermalPenalty = saturate((meas.packTempC - 25) / 40, 0, 1);
imbalancePenalty = saturate((meas.maxCellVoltageV - meas.minCellVoltageV) / max(cfg.safety.maxCellImbalanceV, eps), 0, 1);
sensorPenalty = saturate(abs(meas.voltageResidualV) / max(cfg.safety.maxSensorVoltageErrorV, eps), 0, 1);

weights = cfg.supervisor.healthWeights;
health.score = saturate(weights(1) * sohTerm ...
    + weights(2) * (1 - thermalPenalty) ...
    + weights(3) * (1 - imbalancePenalty) ...
    + weights(4) * (1 - sensorPenalty), 0, 1);
health.thermalPenalty = thermalPenalty;
health.imbalancePenalty = imbalancePenalty;
health.sensorPenalty = sensorPenalty;
health.trueSoh = truth.trueSoh;
end
