function est = updateSocEstimate(est, meas, cfg)
%UPDATESOCESTIMATE Hybrid coulomb counting plus OCV correction.

dt = cfg.sim.dt;
capacityAs = cfg.pack.capacityAh * 3600 * max(est.soh, 0.75);

est.filteredVoltageV = (1 - cfg.estimation.ocvBlend) * est.filteredVoltageV ...
    + cfg.estimation.ocvBlend * meas.packVoltageV;

socCc = est.soc - (meas.packCurrentA * dt / capacityAs);
meanCellVoltage = est.filteredVoltageV / cfg.pack.numSeries;
socOcv = socFromOcv(meanCellVoltage);

est.soc = saturate((1 - cfg.estimation.socCorrectionGain) * socCc ...
    + cfg.estimation.socCorrectionGain * socOcv, 0.0, 1.0);
end
