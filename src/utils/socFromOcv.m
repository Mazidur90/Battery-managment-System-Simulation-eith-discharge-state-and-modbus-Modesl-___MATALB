function soc = socFromOcv(ocv)
%SOCFROMOCV Approximate inverse OCV curve.

socGrid = linspace(0, 1, 1000);
ocvGrid = ocvFromSoc(socGrid);
soc = interp1(ocvGrid, socGrid, ocv, "linear", "extrap");
soc = saturate(soc, 0.0, 1.0);
end
