function metrics = updateEnergyMetrics(metrics, truth, est, cfg)
%UPDATEENERGYMETRICS Track power, energy, range, and throughput metrics.

dt_h = cfg.sim.dt / 3600;

metrics.packPowerW = truth.packVoltageV * truth.packCurrentA;
metrics.lossPowerW = truth.totalLossW + cfg.pack.auxLoadW;
metrics.netBatteryPowerW = metrics.packPowerW + cfg.pack.auxLoadW;
metrics.dischargeEnergyWh = metrics.dischargeEnergyWh + max(metrics.packPowerW, 0) * dt_h;
metrics.lossEnergyWh = metrics.lossEnergyWh + metrics.lossPowerW * dt_h;
metrics.throughputAh = metrics.throughputAh + abs(truth.packCurrentA) * dt_h;
metrics.remainingEnergyWh = max(0, est.soc * cfg.pack.nominalEnergyWh);
metrics.availablePowerW = est.soc * cfg.safety.maxPowerW;
metrics.estimatedRangeKm = metrics.remainingEnergyWh / max(cfg.vehicle.whPerKm, 1);
end
