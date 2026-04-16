function severity = classifyFaultSeverity(faults)
%CLASSIFYFAULTSEVERITY Collapse many faults into a simple severity score.

severity = 0;

if faults.cellImbalance || faults.socLow || faults.socHigh
    severity = max(severity, 1);
end

if faults.overPower || faults.underTemp || faults.overTemp
    severity = max(severity, 2);
end

if faults.overVoltage || faults.underVoltage || faults.overCurrentDischarge ...
        || faults.overCurrentCharge || faults.sensorVoltage
    severity = max(severity, 3);
end
end
