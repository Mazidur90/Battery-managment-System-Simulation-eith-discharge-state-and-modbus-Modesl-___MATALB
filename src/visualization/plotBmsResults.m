function plotBmsResults(results)
%PLOTBMSRESULTS Plot the main BMS signals.

t = results.logs.time_s;
logs = results.logs;

figure("Name", "BMS End-to-End Results", "Color", "w");
tiledlayout(8, 1, "TileSpacing", "compact");

nexttile;
plot(t, logs.packVoltageV, "LineWidth", 1.2);
ylabel("Pack V");
grid on;
title("Battery Pack");

nexttile;
plot(t, logs.packCurrentA, "LineWidth", 1.2);
hold on;
plot(t, logs.currentLimitA, "--", "LineWidth", 1.1);
ylabel("Current A");
legend("Measured", "Allowed", "Location", "best");
grid on;

nexttile;
plot(t, logs.socTrue, "LineWidth", 1.4);
hold on;
plot(t, logs.socEst, "--", "LineWidth", 1.2);
plot(t, logs.sohEst, "LineWidth", 1.0);
ylabel("State");
legend("SOC True", "SOC Est", "SOH Est", "Location", "best");
grid on;

nexttile;
plot(t, logs.packTempC, "LineWidth", 1.2);
hold on;
plot(t, logs.packCoreTempC, "--", "LineWidth", 1.0);
plot(t, logs.packSurfaceTempC, ":", "LineWidth", 1.0);
plot(t, logs.maxCellVoltageV, "LineWidth", 1.1);
plot(t, logs.minCellVoltageV, "LineWidth", 1.1);
ylabel("Temp / Cell V");
legend("Temp C", "Core Temp", "Surface Temp", "Max Cell V", "Min Cell V", "Location", "best");
grid on;

nexttile;
plot(t, logs.packPowerW, "LineWidth", 1.2);
hold on;
plot(t, logs.lossPowerW, "LineWidth", 1.0);
plot(t, logs.availablePowerW, "--", "LineWidth", 1.0);
plot(t, logs.sopDischargeW, ":", "LineWidth", 1.0);
ylabel("Power W");
legend("Pack", "Loss", "Available", "SOP", "Location", "best");
grid on;

nexttile;
plot(t, logs.remainingEnergyWh, "LineWidth", 1.2);
hold on;
plot(t, logs.estimatedRangeKm, "LineWidth", 1.0);
plot(t, logs.throughputAh, "--", "LineWidth", 1.0);
ylabel("Energy / Range");
legend("Remaining Wh", "Range km", "Throughput Ah", "Location", "best");
grid on;

nexttile;
plot(t, logs.healthScore, "LineWidth", 1.2);
hold on;
plot(t, logs.thermalPenalty, "LineWidth", 1.0);
plot(t, logs.imbalancePenalty, "LineWidth", 1.0);
plot(t, logs.sensorPenalty, "LineWidth", 1.0);
ylabel("Health");
legend("Score", "Thermal", "Imbalance", "Sensor", "Location", "best");
grid on;

nexttile;
plot(t, logs.modeCode, "LineWidth", 1.2);
hold on;
plot(t, logs.faultSeverity, "LineWidth", 1.0);
plot(t, logs.commHealthRaw / 1000, "--", "LineWidth", 1.0);
ylabel("Mode / Comm");
xlabel("Time s");
legend("Mode", "Severity", "Comm Health", "Location", "best");
grid on;
end
