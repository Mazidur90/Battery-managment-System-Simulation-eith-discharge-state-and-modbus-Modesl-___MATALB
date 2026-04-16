function [state, signals] = bmsStep(state, cfg, env)
%BMSSTEP One closed-loop plant plus BMS control step.

state.ctrl.requestedCurrentA = env.currentRequestA;
[state.true, truth] = packPlantStep(state.true, state.ctrl, cfg, env);
meas = measurePack(truth, cfg);

state.est = updateSocEstimate(state.est, meas, cfg);
state.est = updateSohEstimate(state.est, meas, cfg);
state.est = updateSopEstimate(state.est, meas, cfg);

faults = evaluateFaults(meas, state.est, cfg);
state.ctrl = updateThermalControl(state.ctrl, meas, cfg);
state.ctrl = updateBalancingControl(state.ctrl, meas, state.est, cfg);
[state.ctrl, limit] = applyCurrentDerating(state.ctrl, meas, state.est, faults, cfg);
state.supervisor = updateSupervisorState(state.supervisor, meas, state.est, state.ctrl, faults, cfg);
state.supervisor.faultSeverity = classifyFaultSeverity(faults);
state.ctrl = updateContactorControl(state.ctrl, state.supervisor, cfg);
state.metrics = updateEnergyMetrics(state.metrics, truth, state.est, cfg);
state.health = computeHealthScore(truth, state.est, meas, cfg);
state.comm = generateBmsFrame(meas, state.est, state.supervisor, state.health, cfg);
diag = computeDiagnostics(truth, meas, state.est, state.ctrl, state.supervisor, limit);

signals = collectSignals(truth, meas, state, diag);
end
