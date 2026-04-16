function diag = computeDiagnostics(truth, meas, est, ctrl, supervisor, limit)
%COMPUTEDIAGNOSTICS Build high-level health and diagnostics signals.

diag.voltageResidualV = meas.packVoltageV - truth.packVoltageV;
diag.tempResidualC = meas.packTempC - truth.packTempC;
diag.socError = est.soc - truth.trueSoc;
diag.derateMarginA = limit.allowedCurrentA - meas.packCurrentA;
diag.balanceCurrentA = sum(ctrl.balanceCurrentA);
diag.modeCode = supervisor.modeCode;
diag.faultLatched = supervisor.latchedFault;
diag.faultSeverity = supervisor.faultSeverity;
diag.currentLimitA = limit.allowedCurrentA;
diag.coreTempC = truth.packCoreTempC;
diag.surfaceTempC = truth.packSurfaceTempC;
end
