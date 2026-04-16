function est = updateSohEstimate(est, meas, cfg)
%UPDATESOHESTIMATE Very simple SOH estimator based on throughput and stress.

throughputPenalty = 4.0e-10 * abs(meas.packCurrentA) * cfg.sim.dt;
thermalPenalty = 2.0e-6 * max(meas.packTempC - 35, 0) * cfg.sim.dt;
voltagePenalty = 1.0e-5 * max(meas.maxCellVoltageV - 4.15, 0) * cfg.sim.dt;

est.soh = max(0.75, est.soh - throughputPenalty - thermalPenalty - voltagePenalty);
end
