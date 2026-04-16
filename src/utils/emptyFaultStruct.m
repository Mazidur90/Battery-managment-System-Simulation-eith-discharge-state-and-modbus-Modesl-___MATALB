function faults = emptyFaultStruct()
%EMPTYFAULTSTRUCT Common fault layout used across the project.

faults.overVoltage = false;
faults.underVoltage = false;
faults.overTemp = false;
faults.underTemp = false;
faults.overCurrentDischarge = false;
faults.overCurrentCharge = false;
faults.socHigh = false;
faults.socLow = false;
faults.overPower = false;
faults.sensorVoltage = false;
faults.cellImbalance = false;
faults.critical = false;
end
