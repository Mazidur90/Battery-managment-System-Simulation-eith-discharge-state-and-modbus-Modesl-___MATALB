function ctrl = updateContactorControl(ctrl, supervisor, ~)
%UPDATECONTACTORCONTROL Opens the contactor on latched critical fault.

ctrl.contactorClosed = ~supervisor.latchedFault;

if ~ctrl.contactorClosed
    ctrl.balanceCurrentA(:) = 0;
    ctrl.coolingOn = true;
    ctrl.heatingOn = false;
    ctrl.coolingLevel = 1.0;
end
end
