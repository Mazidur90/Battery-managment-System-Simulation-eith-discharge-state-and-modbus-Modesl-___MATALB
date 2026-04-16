function ocv = ocvFromSoc(soc)
%OCVFROMSOC Approximate Li-ion open-circuit voltage curve.

soc = saturate(soc, 0.0, 1.0);
ocv = 3.0 + 1.15 * soc + 0.09 * tanh(8 * (soc - 0.55));
end
