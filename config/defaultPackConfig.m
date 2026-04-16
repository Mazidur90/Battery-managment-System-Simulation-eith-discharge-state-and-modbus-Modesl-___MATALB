function cfg = defaultPackConfig()
%DEFAULTPACKCONFIG Default parameters for the tutorial-style discharge BMS.

cfg.sim.dt = 1.0;
cfg.sim.duration_s = 1180;
cfg.sim.seed = 7;
cfg.sim.modelName = "bms_discharge_model";

cfg.cell.name = "Kokam 31Ah";
cfg.cell.partNumber = "SLPB 80106100";
cfg.cell.capacityAh = 31;
cfg.cell.nominalVoltageV = 3.7;
cfg.cell.maxVoltageV = 4.2;
cfg.cell.cutoffVoltageV = 2.7;
cfg.cell.maxChargeCurrentA = 62;
cfg.cell.continuousDischargeCurrentA = 155;
cfg.cell.peakDischargeCurrentA = 310;
cfg.cell.dischargeTempMinC = -20;
cfg.cell.dischargeTempMaxC = 60;
cfg.cell.chargeTempMinC = 0;
cfg.cell.chargeTempMaxC = 40;

cfg.pack.numSeries = 1;
cfg.pack.numParallel = 1;
cfg.pack.capacityAhCell = cfg.cell.capacityAh;
cfg.pack.capacityAh = cfg.cell.capacityAh;
cfg.pack.nominalVoltageCell = cfg.cell.nominalVoltageV;
cfg.pack.maxVoltageCell = cfg.cell.maxVoltageV;
cfg.pack.minVoltageCell = cfg.cell.cutoffVoltageV;
cfg.pack.initialSoc = 0.85;
cfg.pack.initialTempC = 20;
cfg.pack.massKg = 0.8;
cfg.pack.cpJperKgK = 900;
cfg.pack.thermalResistanceKperW = 4.5;
cfg.pack.baseResistanceOhm = 0.0045;
cfg.pack.entropicHeatCoeff = 0.002;
cfg.pack.nominalEnergyWh = cfg.pack.capacityAh * cfg.cell.nominalVoltageV;
cfg.pack.auxLoadW = 35;
cfg.pack.internalShortRiskCoeff = 0.015;

cfg.sensor.voltageNoiseStd = 0.003;
cfg.sensor.currentNoiseStd = 0.20;
cfg.sensor.tempNoiseStd = 0.10;

cfg.estimation.ocvBlend = 0.04;
cfg.estimation.socCorrectionGain = 0.12;
cfg.estimation.sohFadePerAs = 1.0e-10;

cfg.balance.enable = false;
cfg.balance.startDeltaV = 0.012;
cfg.balance.stopDeltaV = 0.006;
cfg.balance.maxBleedCurrentA = 0.35;

cfg.thermal.convectiveCoeffWm2K = 5;
cfg.thermal.ambientTempK = 293.15;
cfg.thermal.ambientTempC = cfg.thermal.ambientTempK - 273.15;
cfg.thermal.coolingOnC = 34;
cfg.thermal.coolingOffC = 31;
cfg.thermal.heatingOnC = 10;
cfg.thermal.heatingOffC = 13;
cfg.thermal.coolingPowerW = 5;
cfg.thermal.heatingPowerW = 5;
cfg.thermal.coreToSurfaceKperW = 0.9;
cfg.thermal.surfaceToAmbientKperW = 3.2;

cfg.safety.overVoltageCell = cfg.cell.maxVoltageV;
cfg.safety.underVoltageCell = cfg.cell.cutoffVoltageV;
cfg.safety.overTempC = cfg.cell.dischargeTempMaxC;
cfg.safety.underTempC = cfg.cell.dischargeTempMinC;
cfg.safety.overCurrentDischargeA = cfg.cell.continuousDischargeCurrentA;
cfg.safety.overCurrentChargeA = 0;
cfg.safety.maxSoc = 0.98;
cfg.safety.minSoc = 0.05;
cfg.safety.maxPowerW = 550;
cfg.safety.maxTempRisePerStepC = 1.2;
cfg.safety.maxSensorVoltageErrorV = 0.08;
cfg.safety.maxCellImbalanceV = 0.025;
cfg.safety.maxCoreTempC = 68;
cfg.safety.maxSurfaceTempC = 62;

cfg.vehicle.nominalDriveCurrentA = 80;
cfg.vehicle.nominalRegenCurrentA = 0;
cfg.vehicle.nominalSpeedKph = 52;
cfg.vehicle.whPerKm = 70;

cfg.supervisor.derateStartTempC = 45;
cfg.supervisor.derateEndTempC = 58;
cfg.supervisor.derateStartSoc = 0.12;
cfg.supervisor.derateMinSoc = 0.05;
cfg.supervisor.derateStartVoltageV = 3.0;
cfg.supervisor.derateMinVoltageV = 2.75;
cfg.supervisor.coolingLevels = [0 0.35 0.7 1.0];
cfg.supervisor.modeNames = ["Standby" "Drive" "Derated" "Fault"];
cfg.supervisor.healthWeights = [0.35 0.25 0.20 0.20];
cfg.supervisor.sopPowerCeilingW = 650;

cfg.comm.nodeId = hex2dec('18');
cfg.comm.txPeriod_s = 1;
cfg.comm.frameBaseId = hex2dec('600');
cfg.comm.scaling.voltage = 100;
cfg.comm.scaling.current = 10;
cfg.comm.scaling.temp = 10;
cfg.comm.scaling.soc = 1000;

cfg.lookup.soc = [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0];
cfg.lookup.tempC = [-20 0 25 40 60];
cfg.lookup.ocvV = [2.70 3.10 3.28 3.42 3.54 3.66 3.75 3.86 3.97 4.08 4.20];
cfg.lookup.r0Ohm = [0.0065 0.0058 0.0052 0.0048 0.0045; ...
                    0.0062 0.0055 0.0050 0.0046 0.0043; ...
                    0.0060 0.0053 0.0048 0.0044 0.0041; ...
                    0.0058 0.0051 0.0046 0.0042 0.0039; ...
                    0.0056 0.0049 0.0045 0.0041 0.0038; ...
                    0.0055 0.0048 0.0044 0.0040 0.0037; ...
                    0.0054 0.0047 0.0043 0.0039 0.0036; ...
                    0.0053 0.0046 0.0042 0.0038 0.0035; ...
                    0.0052 0.0045 0.0041 0.0037 0.0034; ...
                    0.0051 0.0044 0.0040 0.0036 0.0033; ...
                    0.0050 0.0043 0.0039 0.0035 0.0032];
cfg.lookup.r1Ohm = 0.4 * cfg.lookup.r0Ohm;
cfg.lookup.c1F = [1800 2100 2400 2700 3000; ...
                  1900 2200 2500 2800 3100; ...
                  2000 2300 2600 2900 3200; ...
                  2100 2400 2700 3000 3300; ...
                  2200 2500 2800 3100 3400; ...
                  2300 2600 2900 3200 3500; ...
                  2400 2700 3000 3300 3600; ...
                  2500 2800 3100 3400 3700; ...
                  2600 2900 3200 3500 3800; ...
                  2700 3000 3300 3600 3900; ...
                  2800 3100 3400 3700 4000];
end
