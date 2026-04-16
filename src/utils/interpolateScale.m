function scale = interpolateScale(value, startValue, endValue)
%INTERPOLATESCALE Map a value to a [0,1] scale with linear roll-off.

if value <= startValue
    scale = 1.0;
elseif value >= endValue
    scale = 0.0;
else
    scale = 1 - (value - startValue) / max(endValue - startValue, eps);
end
end
