function ctrl = updateThermalControl(ctrl, meas, cfg)
%UPDATETHERMALCONTROL Cooling and heating hysteresis.

if ctrl.coolingOn
    ctrl.coolingOn = meas.packTempC > cfg.thermal.coolingOffC;
else
    ctrl.coolingOn = meas.packTempC >= cfg.thermal.coolingOnC;
end

if ctrl.heatingOn
    ctrl.heatingOn = meas.packTempC < cfg.thermal.heatingOffC;
else
    ctrl.heatingOn = meas.packTempC <= cfg.thermal.heatingOnC;
end

if ctrl.coolingOn
    ctrl.heatingOn = false;
end

if ~ctrl.coolingOn
    ctrl.coolingLevel = 0;
else
    tempRatio = saturate((meas.packTempC - cfg.thermal.coolingOffC) ...
        / max(cfg.thermal.coolingOnC - cfg.thermal.coolingOffC, eps), 0, 1);
    idx = min(numel(cfg.supervisor.coolingLevels), max(1, 1 + round(tempRatio * (numel(cfg.supervisor.coolingLevels) - 1))));
    ctrl.coolingLevel = cfg.supervisor.coolingLevels(idx);
end
end
