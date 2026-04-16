function [plant, truth] = packPlantStep(plant, ctrl, cfg, env)
%PACKPLANTSTEP Simplified electrical and thermal plant model.

dt = cfg.sim.dt;
capacityAs = cfg.pack.capacityAh * 3600 * max(plant.soh, 0.7);

requestedCurrentA = env.currentRequestA;
if ~ctrl.contactorClosed
    requestedCurrentA = 0;
end

packCurrentA = saturate(requestedCurrentA, ...
    cfg.safety.overCurrentChargeA, max(ctrl.currentLimitA, 0));

plant.soc = saturate(plant.soc - (packCurrentA * dt / capacityAs), 0.0, 1.0);

baseCellOcv = ocvFromSoc(plant.soc);
cellCurrentA = packCurrentA / cfg.pack.numParallel;
cellResistance = cfg.pack.baseResistanceOhm / cfg.pack.numSeries;
imbalanceDrift = 0.00002 * sin((1:cfg.pack.numSeries).' / 7 + plant.soc * 4);
plant.cellVoltageOffset = 0.999 * plant.cellVoltageOffset + imbalanceDrift;

if cfg.balance.enable
    bleedEffect = 0.0025 * (ctrl.balanceCurrentA / max(cfg.balance.maxBleedCurrentA, eps));
    plant.cellVoltageOffset = plant.cellVoltageOffset - bleedEffect;
end

cellVoltages = baseCellOcv + plant.cellVoltageOffset - cellCurrentA * cellResistance;
cellVoltages = saturate(cellVoltages, 2.7, 4.3);
packVoltageV = sum(cellVoltages);

jouleHeatW = (packCurrentA ^ 2) * cfg.pack.baseResistanceOhm;
entropicHeatW = abs(packCurrentA) * cfg.pack.entropicHeatCoeff * cfg.pack.numSeries;
coolingW = ctrl.coolingLevel * cfg.thermal.coolingPowerW;
heatingW = double(ctrl.heatingOn) * cfg.thermal.heatingPowerW;
thermalMassJperK = cfg.pack.massKg * cfg.pack.cpJperKgK;
coreToSurfaceW = (plant.coreTempC - plant.surfaceTempC) / max(cfg.thermal.coreToSurfaceKperW, eps);
surfaceToAmbientW = (plant.surfaceTempC - env.ambientTempC) / max(cfg.thermal.surfaceToAmbientKperW, eps);

dCore = dt * ((jouleHeatW + entropicHeatW + heatingW - coolingW - coreToSurfaceW) / thermalMassJperK);
dSurface = dt * ((coreToSurfaceW - surfaceToAmbientW - 0.3 * coolingW) / thermalMassJperK);
plant.coreTempC = plant.coreTempC + dCore;
plant.surfaceTempC = plant.surfaceTempC + dSurface;
plant.tempC = 0.55 * plant.coreTempC + 0.45 * plant.surfaceTempC;

plant.soh = max(0.75, plant.soh - cfg.estimation.sohFadePerAs * abs(packCurrentA) * dt);
plant.packCurrentA = packCurrentA;

truth.packVoltageV = packVoltageV;
truth.packCurrentA = packCurrentA;
truth.packTempC = plant.tempC;
truth.packCoreTempC = plant.coreTempC;
truth.packSurfaceTempC = plant.surfaceTempC;
truth.trueSoc = plant.soc;
truth.trueSoh = plant.soh;
truth.cellVoltagesV = cellVoltages;
truth.minCellVoltageV = min(cellVoltages);
truth.maxCellVoltageV = max(cellVoltages);
truth.totalLossW = jouleHeatW + entropicHeatW + coolingW + heatingW;
truth.ocvMeanV = baseCellOcv;
end
