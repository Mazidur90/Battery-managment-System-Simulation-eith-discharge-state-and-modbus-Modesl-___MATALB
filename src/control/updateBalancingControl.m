function ctrl = updateBalancingControl(ctrl, meas, est, cfg)
%UPDATEBALANCINGCONTROL Passive balancing for high cells near top of charge.

nSeries = numel(meas.cellVoltagesV);
ctrl.balanceCurrentA = zeros(nSeries, 1);

if ~cfg.balance.enable || ~ctrl.contactorClosed
    return;
end

deltaV = meas.maxCellVoltageV - meas.minCellVoltageV;
nearTop = est.soc > 0.80;
lowCurrent = abs(meas.packCurrentA) < 20;

if nearTop && lowCurrent && deltaV >= cfg.balance.startDeltaV
    highCellMask = meas.cellVoltagesV > (meas.minCellVoltageV + cfg.balance.stopDeltaV);
    ctrl.balanceCurrentA(highCellMask) = cfg.balance.maxBleedCurrentA;
end
end
