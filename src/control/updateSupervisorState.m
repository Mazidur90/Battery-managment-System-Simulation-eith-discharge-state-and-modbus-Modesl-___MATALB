function supervisor = updateSupervisorState(supervisor, meas, est, ctrl, faults, cfg)
%UPDATESUPERVISORSTATE Update BMS operating mode and counters.

supervisor.faults = faults;
supervisor.latchedFault = supervisor.latchedFault || faults.critical;

if faults.critical
    supervisor.modeCode = 3;
elseif ctrl.derateActive
    supervisor.modeCode = 2;
elseif abs(meas.packCurrentA) > 1
    supervisor.modeCode = 1;
else
    supervisor.modeCode = 0;
end

supervisor.modeName = cfg.supervisor.modeNames(supervisor.modeCode + 1);
supervisor.faultCount = supervisor.faultCount + double(faults.critical);
supervisor.derateCount = supervisor.derateCount + double(ctrl.derateActive);
supervisor.lastSoc = est.soc;
end
