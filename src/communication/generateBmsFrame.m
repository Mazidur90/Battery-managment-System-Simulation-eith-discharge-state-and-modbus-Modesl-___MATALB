function frame = generateBmsFrame(meas, est, supervisor, health, cfg)
%GENERATEBMSFRAME Create a CAN-like status frame for the BMS.

frame.id = cfg.comm.frameBaseId + cfg.comm.nodeId;
frame.modeCode = supervisor.modeCode;
frame.faultSeverity = supervisor.faultSeverity;
frame.voltageRaw = round(meas.packVoltageV * cfg.comm.scaling.voltage);
frame.currentRaw = round(meas.packCurrentA * cfg.comm.scaling.current);
frame.tempRaw = round(meas.packTempC * cfg.comm.scaling.temp);
frame.socRaw = round(est.soc * cfg.comm.scaling.soc);
frame.healthRaw = round(health.score * 1000);
frame.payload = uint16([frame.voltageRaw, frame.currentRaw, frame.tempRaw, frame.socRaw, frame.healthRaw]);
end
